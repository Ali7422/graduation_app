import 'package:equatable/equatable.dart';
import 'episode.dart';

class Podcast extends Equatable {
  final String id;
  final String title;
  final String publisher;
  final String image;
  final String? thumbnail;
  final String? description;
  final int totalEpisodes;
  final List<Episode>? episodes;

  const Podcast({
    required this.id,
    required this.title,
    required this.publisher,
    required this.image,
    this.thumbnail,
    this.description,
    this.totalEpisodes = 0,
    this.episodes,
  });

  @override
  List<Object?> get props => [id, title, publisher, image, thumbnail, description, totalEpisodes, episodes];
}
