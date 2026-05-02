 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/networking/api_service.dart';
import 'package:dio/dio.dart';

import '../../../podcast_search/data/data_sources/podcast_remote_data_source.dart';
import '../../../podcast_search/data/repositories/podcast_repository_impl.dart';
import '../../../podcast_search/domain/usecases/get_podcasts_by_category_use_case.dart';
import '../../../podcast_search/domain/usecases/get_trending_podcasts_use_case.dart';
import '../../../podcast_search/domain/usecases/search_podcasts_use_case.dart';
import '../cubit/podcasts_cubit.dart';
import 'widget/available_now_section.dart';
import 'widget/genre_movies_section.dart';

class HomeTabs extends StatefulWidget {
  final Function(String category)? onSeeMore;
  const HomeTabs({super.key, this.onSeeMore});
  static const String routeName = "/HomeTabs";
  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {
  final List<String> _allCategories = [
    'Technology',
    'Business',
    'Comedy',
    'Education',
    'Health',
    'News',
    'Sports',
    'Music',
    'True Crime',
    'Science',
  ];

  late List<String> _selectedCategories;

  @override
  void initState() {
    super.initState();
    _selectRandomCategories();
  }

  void _selectRandomCategories() {
    final shuffled = List<String>.from(_allCategories)..shuffle();
    _selectedCategories = shuffled.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final apiService = ApiService(Dio());
        final dataSource = PodcastRemoteDataSourceImpl(apiService);
        final repository = PodcastRepositoryImpl(dataSource);
        return PodcastsCubit(
          getTrendingPodcastsUseCase: GetTrendingPodcastsUseCase(repository),
          getPodcastsByCategoryUseCase: GetPodcastsByCategoryUseCase(repository),
          searchPodcastsUseCase: SearchPodcastsUseCase(repository),
        )..getPodcastsList();
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<PodcastsCubit, PodcastsState>(
            builder: (context, state) {
              if (state is PodcastsLoaded) {
                final podcasts = state.podcastsList;
                final cubit = context.read<PodcastsCubit>();

                return RefreshIndicator(
                  color: AppColors.gold,
                  onRefresh: () async {
                    await cubit.getPodcastsList();
                    setState(() {
                      _selectRandomCategories();
                    });
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        // Available Now Section
                        AvailableNowSection(podcasts: podcasts),
                        const SizedBox(height: 8),
                        ...List.generate(
                          _selectedCategories.length,
                          (index) => CategoryPodcastsSection(
                            key: ValueKey(_selectedCategories[index]),
                            title: _selectedCategories[index],
                            podcastsFuture: cubit.getPodcastsByCategory(
                              _selectedCategories[index],
                            ),
                            onSeeMorePressed: () {
                              widget.onSeeMore?.call(_selectedCategories[index]);
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              } else if (state is PodcastsLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.gold),
                );
              } else if (state is PodcastsError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
