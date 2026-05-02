 import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'package:movies/features/podcast_search/domain/entities/podcast.dart';

Widget buildCustomRatingCard({required double horizontal, required double vertical, required Podcast podcast}) {
  return Positioned(
    top: 8,
    left: 8,
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.mic, color: AppColors.gold, size: 12),
          const SizedBox(width: 5),
          Text(
            "${podcast.totalEpisodes ?? 0} EP",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}