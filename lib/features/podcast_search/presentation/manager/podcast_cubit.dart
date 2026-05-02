import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/search_podcasts_use_case.dart';
import 'podcast_state.dart';

class PodcastCubit extends Cubit<PodcastState> {
  final SearchPodcastsUseCase searchPodcastsUseCase;

  PodcastCubit(this.searchPodcastsUseCase) : super(PodcastInitial());

  String _currentQuery = '';

  Future<void> search(String query, {bool isLoadMore = false}) async {
    if (query.isEmpty) {
      _currentQuery = '';
      emit(PodcastInitial());
      return;
    }

    if (isLoadMore) {
      if (state is PodcastSuccess) {
        final currentState = state as PodcastSuccess;
        if (currentState.hasReachedMax) return;

        emit(PodcastPaginationLoading(currentState.podcasts));
        
        final result = await searchPodcastsUseCase(_currentQuery, offset: currentState.nextOffset);
        
        result.fold(
          (failure) => emit(PodcastPaginationError(currentState.podcasts, failure.message)),
          (searchResult) {
            if (searchResult.podcasts.isEmpty) {
              emit(PodcastSuccess(
                podcasts: currentState.podcasts,
                nextOffset: currentState.nextOffset,
                hasReachedMax: true,
              ));
            } else {
              emit(PodcastSuccess(
                podcasts: currentState.podcasts + searchResult.podcasts,
                nextOffset: searchResult.nextOffset,
                hasReachedMax: searchResult.nextOffset == 0,
              ));
            }
          },
        );
      }
    } else {
      _currentQuery = query;
      emit(PodcastLoading());

      final result = await searchPodcastsUseCase(query);

      result.fold(
        (failure) => emit(PodcastError(failure.message)),
        (searchResult) {
          if (searchResult.podcasts.isEmpty) {
            emit(PodcastEmpty());
          } else {
            emit(PodcastSuccess(
              podcasts: searchResult.podcasts,
              nextOffset: searchResult.nextOffset,
              hasReachedMax: searchResult.nextOffset == 0,
            ));
          }
        },
      );
    }
  }
}
