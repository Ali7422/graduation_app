import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/podcast.dart';
import '../repositories/podcast_repository.dart';

class GetPodcastsByCategoryUseCase {
  final PodcastRepository repository;

  GetPodcastsByCategoryUseCase(this.repository);

  Future<Either<Failure, List<Podcast>>> call(String category) async {
    final query = category.toLowerCase().contains('business')
        ? 'business podcast' 
        : category.toLowerCase().contains('technology') 
            ? 'technology podcast' 
            : category;
            
    final result = await repository.searchPodcasts(query);
    return result.fold(
      (failure) => Left(failure),
      (searchResult) => Right(searchResult.podcasts),
    );
  }
}
