 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import '../../../../core/helper/audio_player_service.dart';
import '../../../podcast_search/domain/entities/episode.dart';

part 'podcast_player_state.dart';

class PodcastPlayerCubit extends Cubit<PodcastPlayerState> {
  final AudioPlayerService _audioPlayerService;

  PodcastPlayerCubit(this._audioPlayerService) : super(PodcastPlayerInitial()) {
    _audioPlayerService.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        emit(PodcastPlayerCompleted());
      }
    });
  }

  Future<void> playEpisode(Episode episode, String podcastImage) async {
    emit(PodcastPlayerLoading(episode: episode, podcastImage: podcastImage));
    await _audioPlayerService.playUrl(episode.audio);
    emit(PodcastPlayerPlaying(episode: episode, podcastImage: podcastImage));
  }

  Future<void> pause() async {
    final currentState = state;
    if (currentState is PodcastPlayerPlaying) {
      await _audioPlayerService.pause();
      emit(PodcastPlayerPaused(episode: currentState.episode, podcastImage: currentState.podcastImage));
    }
  }

  Future<void> resume() async {
    final currentState = state;
    if (currentState is PodcastPlayerPaused) {
      await _audioPlayerService.play();
      emit(PodcastPlayerPlaying(episode: currentState.episode, podcastImage: currentState.podcastImage));
    }
  }

  Future<void> stop() async {
    await _audioPlayerService.stop();
    emit(PodcastPlayerInitial());
  }
}
