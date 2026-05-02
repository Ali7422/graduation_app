import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/podcast.dart';
import '../repositories/podcast_repository.dart';

class GetPodcastDetailsUseCase {
  final PodcastRepository repository;

  GetPodcastDetailsUseCase(this.repository);

  Future<Either<Failure, Podcast>> call(String id) {
    return repository.getPodcastDetails(id);
  }
}
