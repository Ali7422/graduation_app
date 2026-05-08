 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../podcast_search/domain/entities/podcast.dart';
import '../../../podcast_search/domain/usecases/get_trending_podcasts_use_case.dart';
import '../../../podcast_search/domain/usecases/get_podcasts_by_category_use_case.dart';
import '../../../podcast_search/domain/usecases/search_podcasts_use_case.dart';

part 'podcasts_state.dart';

class PodcastsCubit extends Cubit<PodcastsState> {
  final GetTrendingPodcastsUseCase getTrendingPodcastsUseCase;
  final GetPodcastsByCategoryUseCase getPodcastsByCategoryUseCase;

  PodcastsCubit({
    required this.getTrendingPodcastsUseCase,
    required this.getPodcastsByCategoryUseCase,
  }) : super(PodcastsInitial());

  Future<void> getPodcastsList() async {
    emit(PodcastsLoading());
    final result = await getTrendingPodcastsUseCase();
    result.fold(
      (failure) => emit(PodcastsError(message: failure.message)),
      (podcasts) => emit(PodcastsLoaded(podcastsList: podcasts)),
    );
  }

  Future<List<Podcast>> getPodcastsByCategory(String category) async {
    final result = await getPodcastsByCategoryUseCase(category);
    return result.fold(
      (failure) => [],
      (podcasts) => podcasts,
    );
  }
}
