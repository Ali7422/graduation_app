import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/helper/responsive.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

import '../../cubit/podcasts_cubit.dart';
import '../../../../movies_details/presentation/screen/movies_details_screen.dart';

class SliderPodcast extends StatelessWidget {
  final ValueNotifier<int> currentIndexNotifier;

  const SliderPodcast({super.key, required this.currentIndexNotifier});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PodcastsCubit, PodcastsState>(
      builder: (context, state) {
        if (state is PodcastsLoading) {
          return const Center(child: CircularProgressIndicator(color: AppColors.gold));
        } else if (state is PodcastsLoaded) {
          final podcasts = state.podcastsList;

          if (podcasts.isEmpty) return const SizedBox.shrink();
          
          if (currentIndexNotifier.value >= podcasts.length) {
            currentIndexNotifier.value = 0;
          }
          return CarouselSlider(
            items: podcasts
                .map(
                  (item) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 400),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  PodcastDetailsScreen(podcastId: item.id),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.backGroundColor.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: item.image,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[800]!,
                                highlightColor: Colors.grey[700]!,
                                child: Container(color: Colors.grey[850]),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey[800],
                                child: const Icon(Icons.podcasts, color: Colors.grey, size: 40),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 6.0,
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
                                      "${item.totalEpisodes} EP",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: context.height * 0.35,
              viewportFraction: 0.52,
              initialPage: 0,
              autoPlayInterval: const Duration(seconds: 4),
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              autoPlay: true,
              enlargeFactor: 0.25,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                currentIndexNotifier.value = index;
              },
            ),
          );
        } else if (state is PodcastsError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.message, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => context.read<PodcastsCubit>().getPodcastsList(),
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
