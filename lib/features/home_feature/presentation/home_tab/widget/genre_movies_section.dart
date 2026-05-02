 import 'package:flutter/material.dart';
import 'package:movies/core/helper/responsive.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_text_theme.dart';
import 'package:movies/features/podcast_search/domain/entities/podcast.dart';
import 'movies_card.dart';

class CategoryPodcastsSection extends StatelessWidget {
  final String title;
  final Future<List<Podcast>> podcastsFuture;
  final VoidCallback onSeeMorePressed;

  const CategoryPodcastsSection({
    super.key,
    required this.title,
    required this.podcastsFuture,
    required this.onSeeMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header (Title + See More)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyleHelper.font17WhiteRegular
                ),
                GestureDetector(
                  onTap: onSeeMorePressed,
                  child: Row(
                    children: [
                      Text(
                        "See More",
                        style: TextStyleHelper.font10goldBold
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward,
                        color: AppColors.gold,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Podcasts List
          SizedBox(
            height: context.height * 0.25,
            child: FutureBuilder<List<Podcast>>(
              future: podcastsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.gold),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error loading $title podcasts',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'No $title podcasts found',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  );
                }

                final podcasts = snapshot.data!;

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: podcasts.length,
                  itemBuilder: (context, index) {
                    final podcast = podcasts[index];
                    return buildCardPodcast(context, podcast);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
