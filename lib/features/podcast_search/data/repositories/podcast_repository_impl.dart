import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/podcast.dart';
import '../../domain/repositories/podcast_repository.dart';
import '../data_sources/podcast_remote_data_source.dart';
import '../../domain/entities/podcast_search_result.dart';

class PodcastRepositoryImpl implements PodcastRepository {
  final PodcastRemoteDataSource remoteDataSource;

  PodcastRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PodcastSearchResult>> searchPodcasts(String query, {int offset = 0, String language = 'Arabic'}) async {
    try {
      final response = await remoteDataSource.searchPodcasts(query, offset: offset, language: language);
      return Right(PodcastSearchResult(
        podcasts: response.results,
        total: response.total,
        nextOffset: response.nextOffset,
      ));
    } catch (e) {
      if (e.toString().contains('Unauthorized')) {
        return const Left(UnAuthorizedFailure('Invalid API Key. Please check your credentials.'));
      } else if (e.toString().contains('Timeout')) {
        return const Left(NetworkFailure('Connection timed out. Please try again.'));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<Podcast>>> getTrendingPodcasts() async {
    try {
      final response = await remoteDataSource.searchPodcasts('بودكاست', language: 'Arabic');
      return Right(response.results);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Podcast>> getPodcastDetails(String id) async {
    try {
      final podcast = await remoteDataSource.getPodcastDetails(id);
      return Right(podcast);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
