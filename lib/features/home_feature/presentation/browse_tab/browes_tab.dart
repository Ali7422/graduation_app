import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/home_feature/presentation/browse_tab/widget/genre_movise_grid.dart';
import 'package:dio/dio.dart';
import 'package:movies/core/networking/api_service.dart';
import 'package:movies/features/podcast_search/data/data_sources/podcast_remote_data_source.dart';
import 'package:movies/features/podcast_search/data/repositories/podcast_repository_impl.dart';
import 'package:movies/features/podcast_search/domain/usecases/get_podcasts_by_category_use_case.dart';
import 'package:movies/features/podcast_search/domain/usecases/get_trending_podcasts_use_case.dart';
import 'package:movies/features/podcast_search/domain/usecases/search_podcasts_use_case.dart';
import '../cubit/podcasts_cubit.dart';

class BrowseTab extends StatefulWidget {
  final String? selectedCategory;

  const BrowseTab({super.key, this.selectedCategory});
  static const String routeName = "/BrowseTab";

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _categories = [
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

  @override
  void initState() {
    super.initState();

    int initialIndex = 0;
    if (widget.selectedCategory != null) {
      final index = _categories.indexWhere(
            (c) => c.toLowerCase() == widget.selectedCategory!.toLowerCase(),
      );
      if (index != -1) {
        initialIndex = index;
      }
    }

    _tabController = TabController(
      length: _categories.length,
      vsync: this,
      initialIndex: initialIndex,
    );
  }

  @override
  void didUpdateWidget(BrowseTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.selectedCategory != null &&
        widget.selectedCategory != oldWidget.selectedCategory) {
      final newIndex = _categories.indexWhere(
        (c) => c.toLowerCase() == widget.selectedCategory!.toLowerCase(),
      );
      if (newIndex != -1 && newIndex != _tabController.index) {
        _tabController.animateTo(newIndex);
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TabBar (Categories)
              SizedBox(
                height: 50,
                child: TabBar(
                  controller: _tabController,
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  indicatorColor: Colors.transparent,
                  dividerColor: Colors.transparent,
                  labelColor: Colors.black,
                  unselectedLabelColor: AppColors.gold,
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                  tabs: _categories.asMap().entries.map((entry) {
                    final index = entry.key;
                    final category = entry.value;
                    return Tab(
                      child: AnimatedBuilder(
                        animation: _tabController,
                        builder: (context, child) {
                          final isSelected = _tabController.index == index;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.gold
                                  : Colors.transparent,
                              border: Border.all(
                                color: AppColors.gold,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                category,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.black
                                      : AppColors.gold,
                                  fontSize: 16,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 16),

              // TabBarView (Podcasts Grid)
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: _categories.map((category) {
                    return CategoryPodcastsGrid(category: category);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}