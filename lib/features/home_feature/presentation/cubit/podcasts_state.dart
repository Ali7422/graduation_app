 part of 'podcasts_cubit.dart';

abstract class PodcastsState extends Equatable {
  const PodcastsState();

  @override
  List<Object> get props => [];
}

class PodcastsInitial extends PodcastsState {}

class PodcastsLoading extends PodcastsState {}

class PodcastsLoaded extends PodcastsState {
  final List<Podcast> podcastsList;

  const PodcastsLoaded({required this.podcastsList});

  @override
  List<Object> get props => [podcastsList];
}

class PodcastsError extends PodcastsState {
  final String message;

  const PodcastsError({required this.message});

  @override
  List<Object> get props => [message];
}
