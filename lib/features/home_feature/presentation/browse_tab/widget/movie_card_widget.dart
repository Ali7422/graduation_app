 import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/shared/custom_rating_card.dart';
import 'package:movies/features/podcast_search/domain/entities/podcast.dart';

import '../../../../podcasts_details/presentation/screen/movies_details_screen.dart';

class PodcastCard extends StatelessWidget {
  final Podcast podcast;

  const PodcastCard({super.key, required this.podcast});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, animation, secondaryAnimation) =>
                PodcastDetailsScreen(podcastId: podcast.id),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Podcast Cover
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: podcast.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[800]!,
                      highlightColor: Colors.grey[700]!,
                      child: Container(
                        color: Colors.grey[850],
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[800],
                      child: const Icon(Icons.podcasts, color: Colors.grey, size: 40),
                    ),
                  ),
                ),
                buildCustomRatingCard(horizontal: 12.0, vertical: 10.0, podcast: podcast)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
