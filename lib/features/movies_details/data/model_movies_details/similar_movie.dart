 class SimilarPodcastsResponse {
  String? status;
  String? statusMessage;
  SimilarPodcastData? data;

  SimilarPodcastsResponse({this.status, this.statusMessage, this.data});

  SimilarPodcastsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? SimilarPodcastData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['status_message'] = statusMessage;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SimilarPodcastData {
  int? podcastCount;
  List<SimilarPodcast>? podcasts;

  SimilarPodcastData({this.podcastCount, this.podcasts});

  SimilarPodcastData.fromJson(Map<String, dynamic> json) {
    podcastCount = json['podcast_count'];
    if (json['podcasts'] != null) {
      podcasts = <SimilarPodcast>[];
      json['podcasts'].forEach((v) {
        podcasts!.add(SimilarPodcast.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['podcast_count'] = podcastCount;
    if (podcasts != null) {
      data['podcasts'] = podcasts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SimilarPodcast {
  int? id;
  String? title;
  String? author;
  String? description;
  double? rating;
  int? episodeCount;
  int? duration;
  List<String>? categories;
  String? summary;
  String? language;
  String? coverImage;
  String? largeCoverImage;
  String? datePublished;

  SimilarPodcast({
    this.id,
    this.title,
    this.author,
    this.description,
    this.rating,
    this.episodeCount,
    this.duration,
    this.categories,
    this.summary,
    this.language,
    this.coverImage,
    this.largeCoverImage,
    this.datePublished,
  });

  SimilarPodcast.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    description = json['description'];
    rating = (json['rating'] != null)
        ? (json['rating'] is int
              ? (json['rating'] as int).toDouble()
              : (json['rating'] as double))
        : 0.0;
    episodeCount = json['episode_count'];
    duration = json['duration'];
    categories = json['categories'] != null ? List<String>.from(json['categories']) : [];
    summary = json['summary'];
    language = json['language'];
    coverImage = json['cover_image'];
    largeCoverImage = json['large_cover_image'];
    datePublished = json['date_published'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['author'] = author;
    data['description'] = description;
    data['rating'] = rating;
    data['episode_count'] = episodeCount;
    data['duration'] = duration;
    data['categories'] = categories;
    data['summary'] = summary;
    data['language'] = language;
    data['cover_image'] = coverImage;
    data['large_cover_image'] = largeCoverImage;
    data['date_published'] = datePublished;
    return data;
  }
}
