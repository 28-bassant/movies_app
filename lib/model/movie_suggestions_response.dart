class MovieSuggestionsResponse {
  String? status;
  String? statusMessage;
  SuggestionsData? data;

  MovieSuggestionsResponse({this.status, this.statusMessage, this.data});

  MovieSuggestionsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? SuggestionsData.fromJson(json['data']) : null;
  }
}

class SuggestionsData {
  int? movieCount;
  List<SuggestedMovie>? movies;

  SuggestionsData({this.movieCount, this.movies});

  SuggestionsData.fromJson(Map<String, dynamic> json) {
    movieCount = json['movie_count'];
    if (json['movies'] != null) {
      movies = List<SuggestedMovie>.from(
        json['movies'].map((x) => SuggestedMovie.fromJson(x)),
      );
    }
  }
}

class SuggestedMovie {
  int? id;
  String? title;
  String? mediumCoverImage;

  SuggestedMovie({this.id, this.title, this.mediumCoverImage});

  SuggestedMovie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    mediumCoverImage = json['medium_cover_image'];
  }
}
