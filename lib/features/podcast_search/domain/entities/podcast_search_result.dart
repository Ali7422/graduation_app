import 'package:equatable/equatable.dart';
import 'podcast.dart';

class PodcastSearchResult extends Equatable {
  final List<Podcast> podcasts;
  final int total;
  final int nextOffset;

  const PodcastSearchResult({
    required this.podcasts,
    required this.total,
    required this.nextOffset,
  });

  @override
  List<Object?> get props => [podcasts, total, nextOffset];
}
