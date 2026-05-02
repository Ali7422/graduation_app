import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/features/home_feature/presentation/cubit/podcasts_cubit.dart';
import 'package:movies/features/podcast_search/domain/entities/podcast.dart';
import 'movie_card_widget.dart';

class CategoryPodcastsGrid extends StatelessWidget {
  final String category;

  const CategoryPodcastsGrid({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PodcastsCubit>();

    return FutureBuilder<List<Podcast>>(
      future: cubit.getPodcastsByCategory(category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.gold),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error loading $category podcasts',
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    // Force refresh
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => context.widget),
                    );
                  },
                  child: const Text(
                    'Retry',
                    style: TextStyle(color: AppColors.gold),
                  ),
                ),
              ],
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.podcasts,
                  color: Colors.grey,
                  size: 60,
                ),
                const SizedBox(height: 16),
                Text(
                  'No $category podcasts found',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }

        final podcasts = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.55,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: podcasts.length,
            itemBuilder: (context, index) {
              final podcast = podcasts[index];
              return PodcastCard(podcast: podcast);
            },
          ),
        );
      },
    );
  }
}
