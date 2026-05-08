 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../podcast_search/domain/entities/podcast.dart';
import '../../../podcast_search/domain/usecases/get_podcast_details_use_case.dart';

part 'movice_details_state.dart';

class PodcastDetailsCubit extends Cubit<PodcastDetailsState> {
  final GetPodcastDetailsUseCase getPodcastDetailsUseCase;

  PodcastDetailsCubit(this.getPodcastDetailsUseCase)
    : super(PodcastDetailsInitial());

  Future<void> getPodcastDetails(String podcastId) async {
    emit(PodcastDetailsLoading());
    final result = await getPodcastDetailsUseCase(podcastId);
    
    result.fold(
      (failure) => emit(PodcastDetailsError(message: failure.message)),
      (podcast) => emit(PodcastDetailsLoaded(podcast: podcast)),
    );
  }
}
