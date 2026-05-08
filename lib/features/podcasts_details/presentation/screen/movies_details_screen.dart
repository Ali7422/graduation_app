 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/helper/responsive.dart';
import 'package:movies/core/theme/app_colors.dart';
import '../../business_logic/movies_details_cubit/movice_details_cubit.dart';
import '../../business_logic/podcast_player_cubit/podcast_player_cubit.dart';
import '../../../../core/helper/audio_player_service.dart';

import 'package:movies/core/networking/api_service.dart';
import 'package:movies/features/podcast_search/data/data_sources/podcast_remote_data_source.dart';
import 'package:movies/features/podcast_search/data/repositories/podcast_repository_impl.dart';
import 'package:movies/features/podcast_search/domain/usecases/get_podcast_details_use_case.dart';

import '../widget/movies_details_section.dart';
import '../widget/audio_player_widget.dart';

class PodcastDetailsScreen extends StatelessWidget {
  final String podcastId;
  const PodcastDetailsScreen({super.key, required this.podcastId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final apiService = ApiService();
            final dataSource = PodcastRemoteDataSourceImpl(apiService);
            final repository = PodcastRepositoryImpl(dataSource);
            return PodcastDetailsCubit(GetPodcastDetailsUseCase(repository))..getPodcastDetails(podcastId);
          },
        ),
        BlocProvider(
          create: (context) => PodcastPlayerCubit(AudioPlayerService()),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.backGroundColor,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PodcastDetailsSection(),
                    SizedBox(height: context.height * 0.02),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: AudioPlayerWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
