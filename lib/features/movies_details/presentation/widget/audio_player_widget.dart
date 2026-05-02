import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helper/audio_player_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_theme.dart';
import '../../business_logic/podcast_player_cubit/podcast_player_cubit.dart';

class AudioPlayerWidget extends StatelessWidget {
  const AudioPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final audioPlayerService = AudioPlayerService();
    
    return BlocBuilder<PodcastPlayerCubit, PodcastPlayerState>(
      builder: (context, state) {
        if (state is PodcastPlayerInitial || state is PodcastPlayerCompleted) {
          return const SizedBox.shrink();
        }

        String imageUrl = '';
        String title = '';
        bool isPlaying = false;
        bool isLoading = false;

        if (state is PodcastPlayerLoading) {
          imageUrl = state.podcastImage;
          title = state.episode.title;
          isLoading = true;
        } else if (state is PodcastPlayerPlaying) {
          imageUrl = state.podcastImage;
          title = state.episode.title;
          isPlaying = true;
        } else if (state is PodcastPlayerPaused) {
          imageUrl = state.podcastImage;
          title = state.episode.title;
          isPlaying = false;
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.blackFour.withOpacity(0.95),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyleHelper.font16WhiteBold,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (isPlaying)
                           const AudioAnimation(),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                      color: AppColors.gold,
                      size: 40,
                    ),
                    onPressed: () {
                      if (isPlaying) {
                        context.read<PodcastPlayerCubit>().pause();
                      } else {
                        context.read<PodcastPlayerCubit>().resume();
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => context.read<PodcastPlayerCubit>().stop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              StreamBuilder<Duration?>(
                stream: audioPlayerService.durationStream,
                builder: (context, snapshot) {
                  final duration = snapshot.data ?? Duration.zero;
                  return StreamBuilder<Duration>(
                    stream: audioPlayerService.positionStream,
                    builder: (context, snapshot) {
                      var position = snapshot.data ?? Duration.zero;
                      if (position > duration) {
                        position = duration;
                      }
                      return ProgressBar(
                        progress: position,
                        total: duration,
                        buffered: audioPlayerService.player.bufferedPosition,
                        onSeek: (duration) {
                          audioPlayerService.seek(duration);
                        },
                        progressBarColor: AppColors.gold,
                        baseBarColor: Colors.grey[800],
                        bufferedBarColor: Colors.grey[600],
                        thumbColor: AppColors.gold,
                        timeLabelTextStyle: const TextStyle(color: Colors.white, fontSize: 12),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class AudioAnimation extends StatefulWidget {
  const AudioAnimation({super.key});

  @override
  State<AudioAnimation> createState() => _AudioAnimationState();
}

class _AudioAnimationState extends State<AudioAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(4, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            double value = (index % 2 == 0) 
                ? (0.2 + 0.8 * _controller.value) 
                : (1.0 - 0.8 * _controller.value);
            // Add some phase shift
            value = (value + (index * 0.2)) % 1.0;
            
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 3,
              height: 10 + (20 * value),
              decoration: BoxDecoration(
                color: AppColors.gold,
                borderRadius: BorderRadius.circular(2),
              ),
            );
          },
        );
      }),
    );
  }
}
