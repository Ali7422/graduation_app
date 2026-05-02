import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/podcast.dart';
import '../entities/podcast_search_result.dart';

abstract class PodcastRepository {
  Future<Either<Failure, PodcastSearchResult>> searchPodcasts(String query, {int offset = 0, String language = 'Arabic'});
  Future<Either<Failure, List<Podcast>>> getTrendingPodcasts();
  Future<Either<Failure, Podcast>> getPodcastDetails(String id);
}
