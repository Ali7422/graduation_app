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
      title: json['title'] as String? ?? 'No Title',
      audio: json['audio'] as String? ?? '',
      audioLengthSec: json['audio_length_sec'] as int? ?? 0,
      description: json['description'] as String?,
      image: json['image'] as String?,
      thumbnail: json['thumbnail'] as String?,
    );
  }
}
