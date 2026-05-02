import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/podcast.dart';
import '../repositories/podcast_repository.dart';

class GetTrendingPodcastsUseCase {
  final PodcastRepository repository;

  GetTrendingPodcastsUseCase(this.repository);

  Future<Either<Failure, List<Podcast>>> call() {
    return repository.getTrendingPodcasts();
  }
}
