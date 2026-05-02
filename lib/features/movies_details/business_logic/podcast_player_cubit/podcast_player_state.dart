part of 'podcast_player_cubit.dart';

abstract class PodcastPlayerState extends Equatable {
  const PodcastPlayerState();

  @override
  List<Object?> get props => [];
}

class PodcastPlayerInitial extends PodcastPlayerState {}

class PodcastPlayerLoading extends PodcastPlayerState {
  final Episode episode;
  final String podcastImage;

  const PodcastPlayerLoading({required this.episode, required this.podcastImage});

  @override
  List<Object?> get props => [episode, podcastImage];
}

class PodcastPlayerPlaying extends PodcastPlayerState {
  final Episode episode;
  final String podcastImage;

  const PodcastPlayerPlaying({required this.episode, required this.podcastImage});

  @override
  List<Object?> get props => [episode, podcastImage];
}

class PodcastPlayerPaused extends PodcastPlayerState {
  final Episode episode;
  final String podcastImage;

  const PodcastPlayerPaused({required this.episode, required this.podcastImage});

  @override
  List<Object?> get props => [episode, podcastImage];
}

class PodcastPlayerCompleted extends PodcastPlayerState {}

class PodcastPlayerError extends PodcastPlayerState {
  final String message;

  const PodcastPlayerError({required this.message});

  @override
  List<Object?> get props => [message];
}
