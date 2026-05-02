import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/helper/responsive.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/shared/custom_rating_card.dart';

import 'package:movies/features/podcast_search/domain/entities/podcast.dart';
import 'package:movies/features/movies_details/presentation/screen/movies_details_screen.dart';

Widget buildCardPodcast(BuildContext context, Podcast podcast) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PodcastDetailsScreen(podcastId: podcast.id),
        ),
      );
    },
    child: Container(
    width: context.width * 0.32,
    margin: const EdgeInsets.only(right: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Podcast Cover
        Expanded(
          child: Stack(
            children: [
              // Cover Image
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

              buildCustomRatingCard(
                horizontal: 8.0,
                vertical: 6.0,
                podcast: podcast
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
}
