 part of 'movice_details_cubit.dart';

abstract class PodcastDetailsState extends Equatable {
  const PodcastDetailsState();

  @override
  List<Object?> get props => [];
}

class PodcastDetailsInitial extends PodcastDetailsState {}

class PodcastDetailsLoading extends PodcastDetailsState {}

class PodcastDetailsLoaded extends PodcastDetailsState {
  final Podcast podcast;
  const PodcastDetailsLoaded({required this.podcast});

  @override
  List<Object?> get props => [podcast];
}

class PodcastDetailsError extends PodcastDetailsState {
  final String message;
  const PodcastDetailsError({required this.message});

  @override
  List<Object?> get props => [message];
}
