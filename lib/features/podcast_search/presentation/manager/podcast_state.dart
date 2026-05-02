import 'package:equatable/equatable.dart';
import '../../domain/entities/podcast.dart';

abstract class PodcastState extends Equatable {
  const PodcastState();

  @override
  List<Object?> get props => [];
}

class PodcastInitial extends PodcastState {}

class PodcastLoading extends PodcastState {}

class PodcastSuccess extends PodcastState {
  final List<Podcast> podcasts;
  final int nextOffset;
  final bool hasReachedMax;

  const PodcastSuccess({
    required this.podcasts,
    required this.nextOffset,
    this.hasReachedMax = false,
  });

  @override
  List<Object?> get props => [podcasts, nextOffset, hasReachedMax];
}

class PodcastPaginationLoading extends PodcastState {
  final List<Podcast> podcasts;

  const PodcastPaginationLoading(this.podcasts);

  @override
  List<Object?> get props => [podcasts];
}

class PodcastPaginationError extends PodcastState {
  final List<Podcast> podcasts;
  final String message;

  const PodcastPaginationError(this.podcasts, this.message);

  @override
  List<Object?> get props => [podcasts, message];
}

class PodcastError extends PodcastState {
  final String message;

  const PodcastError(this.message);

  @override
  List<Object?> get props => [message];
}

class PodcastEmpty extends PodcastState {}
