 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/helper/responsive.dart';
import 'package:movies/core/shared/custom_elveted_button.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/core/theme/app_text_theme.dart';
import '../../business_logic/movies_details_cubit/movice_details_cubit.dart';
import '../../business_logic/podcast_player_cubit/podcast_player_cubit.dart';
import 'header_details_widget.dart';

class PodcastDetailsSection extends StatelessWidget {
  const PodcastDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PodcastDetailsCubit, PodcastDetailsState>(
      builder: (context, state) {
        if (state is PodcastDetailsLoaded) {
          final podcast = state.podcast;
          return Column(
            children: [
              // Header (image-title-publisher)
              buildHeaderPodcastDetails(
                context: context,
                podcastImage: podcast.image,
                podcastTitle: podcast.title,
                podcastPublisher: podcast.publisher,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // Description
                    Text(
                      "Description",
                      style: TextStyleHelper.font18WhiteBold,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      podcast.description ?? "No description available.",
                      style: TextStyleHelper.font14GreyRegular,
                    ),
                    const SizedBox(height: 20),
                    // Information Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildContainerDetails(
                          const Icon(Icons.mic, color: AppColors.gold, size: 20),
                          context: context,
                          title: "${podcast.totalEpisodes} EP",
                        ),
                        _buildContainerDetails(
                          const Icon(Icons.language, color: AppColors.gold, size: 20),
                          context: context,
                          title: "Arabic",
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // Play Episode Button
                    AnimatedGlassButton(
                      colorType: "gold",
                      title: "Play Latest Episode",
                      onPressed: () {
                        if (podcast.episodes != null && podcast.episodes!.isNotEmpty) {
                          context.read<PodcastPlayerCubit>().playEpisode(
                            podcast.episodes!.first, 
                            podcast.image,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("No episodes found for this podcast.")),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
        } else if (state is PodcastDetailsLoading) {
          return Padding(
            padding: EdgeInsets.only(top: context.height * 0.4),
            child: const Center(
              child: CircularProgressIndicator(
                color: AppColors.gold,
                strokeWidth: 2,
              ),
            ),
          );
        } else if (state is PodcastDetailsError) {
          return Center(child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.red)));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildContainerDetails(
    Widget icon, {
    String title = '',
    required BuildContext context,
  }) {
    return Container(
      width: context.width * 0.4,
      height: context.height * 0.05,
      decoration: BoxDecoration(
        color: AppColors.blackFour,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 8),
          Text(title, style: TextStyleHelper.font16WhiteBold),
        ],
      ),
    );
  }
}
