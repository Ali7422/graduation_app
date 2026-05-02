import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/podcast_search_result.dart';
import '../repositories/podcast_repository.dart';

class SearchPodcastsUseCase {
  final PodcastRepository repository;

  SearchPodcastsUseCase(this.repository);

  Future<Either<Failure, PodcastSearchResult>> call(String query, {int offset = 0, String language = 'Arabic'}) {
    return repository.searchPodcasts(query, offset: offset, language: language);
  }
}
