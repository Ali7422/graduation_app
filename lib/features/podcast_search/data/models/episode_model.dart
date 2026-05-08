import '../../domain/entities/episode.dart';

class EpisodeModel extends Episode {
  const EpisodeModel({
    required super.id,
    required super.title,
    required super.audio,
    required super.audioLengthSec,
    super.description,
    super.image,
    super.thumbnail,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'] as String? ?? '',
      title: (json['title'] ?? json['title_original']) as String? ?? 'No Title',
      audio: json['audio'] as String? ?? '',
      audioLengthSec: json['audio_length_sec'] as int? ?? 0,
      description: (json['description'] ?? json['description_original']) as String?,
      image: (json['image'] ?? json['image_original']) as String?,
      thumbnail: (json['thumbnail'] ?? json['thumbnail_original']) as String?,
    );
  }
}
