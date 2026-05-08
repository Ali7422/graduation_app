import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/networking/api_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_theme.dart';
import '../../../podcasts_details/presentation/screen/movies_details_screen.dart';
import '../../domain/entities/podcast.dart';
import '../../data/data_sources/podcast_remote_data_source.dart';
import '../../data/repositories/podcast_repository_impl.dart';
import '../../domain/usecases/search_podcasts_use_case.dart';
import '../manager/podcast_cubit.dart';
import '../manager/podcast_state.dart';

class PodcastSearchPage extends StatefulWidget {
  const PodcastSearchPage({super.key});

  @override
  State<PodcastSearchPage> createState() => _PodcastSearchPageState();
}

class _PodcastSearchPageState extends State<PodcastSearchPage> {
  late final PodcastCubit _cubit;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    final apiService = ApiService();
    final remoteDataSource = PodcastRemoteDataSourceImpl(apiService);
    final repository = PodcastRepositoryImpl(remoteDataSource);
    final useCase = SearchPodcastsUseCase(repository);
    _cubit = PodcastCubit(useCase);
    
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9) {
        _cubit.search(_searchController.text, isLoadMore: true);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
    _cubit.close();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _cubit.search(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.backGroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backGroundColor,
          title: Text('Search Podcasts', style: TextStyleHelper.font24WhiteBold),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search by title or publisher...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: AppColors.gold),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      _searchController.clear();
                      _cubit.search('');
                    },
                  ),
                  filled: true,
                  fillColor: AppColors.blackOne,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.gold, width: 1),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<PodcastCubit, PodcastState>(
                builder: (context, state) {
                  if (state is PodcastInitial) {
                    return const _PlaceholderView(
                      icon: Icons.podcasts_rounded,
                      message: 'Discover your next favorite podcast',
                    );
                  } else if (state is PodcastLoading) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.gold));
                  } else if (state is PodcastSuccess || state is PodcastPaginationLoading || state is PodcastPaginationError) {
                    List<Podcast> podcasts = [];
                    bool isLoadingMore = false;
                    
                    if (state is PodcastSuccess) {
                      podcasts = state.podcasts;
                    } else if (state is PodcastPaginationLoading) {
                      podcasts = state.podcasts;
                      isLoadingMore = true;
                    } else if (state is PodcastPaginationError) {
                      podcasts = state.podcasts;
                    }
                    
                    return _PodcastListView(
                      podcasts: podcasts, 
                      isLoadingMore: isLoadingMore,
                      scrollController: _scrollController,
                    );
                  } else if (state is PodcastEmpty) {
                    return const _PlaceholderView(
                      icon: Icons.search_off_rounded,
                      message: 'We couldn\'t find any podcasts matching your search.',
                    );
                  } else if (state is PodcastError) {
                    return _ErrorView(
                      message: state.message,
                      onRetry: () => _cubit.search(_searchController.text),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            const SizedBox(height: 80), // Space for bottom nav bar
          ],
        ),
      ),
    );
  }
}

class _PodcastListView extends StatelessWidget {
  final List<Podcast> podcasts;
  final bool isLoadingMore;
  final ScrollController scrollController;
  
  const _PodcastListView({
    required this.podcasts, 
    this.isLoadingMore = false,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: podcasts.length + (isLoadingMore ? 1 : 0),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == podcasts.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(color: AppColors.gold),
            ),
          );
        }
        
        final podcast = podcasts[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: AppColors.blackThree,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.blackFour, width: 0.5),
          ),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PodcastDetailsScreen(podcastId: podcast.id),
                ),
              );
            },
            contentPadding: const EdgeInsets.all(12),
            leading: Hero(
              tag: podcast.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: podcast.thumbnail ?? podcast.image,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AppColors.blackOne,
                    child: const Center(child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.gold)),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),
            title: Text(
              podcast.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyleHelper.font16WhiteBold,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                podcast.publisher,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyleHelper.font14GreyRegular,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.gold),
          ),
        );
      },
    );
  }
}

class _PlaceholderView extends StatelessWidget {
  final IconData icon;
  final String message;
  const _PlaceholderView({required this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: AppColors.gold.withOpacity(0.3)),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyleHelper.font18WhiteBold.copyWith(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline_rounded, size: 80, color: AppColors.red),
          const SizedBox(height: 24),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyleHelper.font16WhiteBold,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gold,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Try Again', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
