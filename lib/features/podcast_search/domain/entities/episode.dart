import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  final String id;
  final String title;
  final String audio;
  final int audioLengthSec;
  final String? description;
  final String? image;
  final String? thumbnail;

  const Episode({
    required this.id,
    required this.title,
    required this.audio,
    required this.audioLengthSec,
    this.description,
    this.image,
    this.thumbnail,
  });

  @override
  List<Object?> get props => [id, title, audio, audioLengthSec, description, image, thumbnail];
}
