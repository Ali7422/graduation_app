import '../../domain/entities/podcast.dart';
import 'episode_model.dart';

class PodcastModel extends Podcast {
  const PodcastModel({
    required super.id,
    required super.title,
    required super.publisher,
    required super.image,
    super.thumbnail,
    super.description,
    super.totalEpisodes,
    super.episodes,
  });

  factory PodcastModel.fromJson(Map<String, dynamic> json) {
    return PodcastModel(
      id: json['id'] as String? ?? '',
      title: (json['title'] ?? json['title_original']) as String? ?? 'No Title',
      publisher: (json['publisher'] ?? json['publisher_original']) as String? ?? 'Unknown Publisher',
      image: json['image'] as String? ?? '',
      thumbnail: (json['thumbnail'] ?? json['thumbnail_original']) as String?,
      description: (json['description'] ?? json['description_original']) as String? ?? '',
      totalEpisodes: json['total_episodes'] as int? ?? 0,
      episodes: (json['episodes'] as List?)
          ?.map((e) => EpisodeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SearchResponseModel {
  final List<PodcastModel> results;
  final int total;
  final int nextOffset;

  SearchResponseModel({
    required this.results,
    required this.total,
    required this.nextOffset,
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) {
    return SearchResponseModel(
      results: (json['results'] as List?)
              ?.map((e) => PodcastModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      total: json['total'] as int? ?? 0,
      nextOffset: json['next_offset'] as int? ?? 0,
    );
  }
}
