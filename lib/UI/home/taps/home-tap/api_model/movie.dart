class Movie {
  final String title;
  final String year;
  final String image;
  final double rating;
  final List<String> genres;  

  Movie({
    required this.title,
    required this.year,
    required this.image,
    required this.rating,
    required this.genres,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    List<String> extractedGenres = [];
    if (json['genres'] != null && json['genres'] is List) {
      extractedGenres = List<String>.from(json['genres']);
    }

    return Movie(
      title: json['title'] ?? "No Title",
      year: json['year']?.toString() ?? "N/A",
      image: json['medium_cover_image'] ?? "",
      rating: (json['rating'] is num) ? (json['rating'] as num).toDouble() : 0.0,
      genres: extractedGenres,
    );
  }
}
