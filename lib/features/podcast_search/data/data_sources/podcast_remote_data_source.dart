import '../../../../core/networking/api_service.dart';
import '../models/podcast_model.dart';

abstract class PodcastRemoteDataSource {
  Future<SearchResponseModel> searchPodcasts(String query, {int offset = 0, String language = 'Arabic'});
  Future<PodcastModel> getPodcastDetails(String id);
}

class PodcastRemoteDataSourceImpl implements PodcastRemoteDataSource {
  final ApiService apiService;

  PodcastRemoteDataSourceImpl(this.apiService);

  @override
  Future<SearchResponseModel> searchPodcasts(String query, {int offset = 0, String language = 'Arabic'}) async {
    final data = await apiService.get(
      '/search',
      queryParameters: {
        'q': query,
        'type': 'podcast',
        'offset': offset,
        'language': language,
      },
    );
    return SearchResponseModel.fromJson(data);
  }

  @override
  Future<PodcastModel> getPodcastDetails(String id) async {
    final data = await apiService.get('/podcasts/$id');
    return PodcastModel.fromJson(data);
  }
}
