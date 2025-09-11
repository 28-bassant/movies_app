class FavouriteMovies {
  final int id;
  final String title;
  String imageURL;
  final double rating;
  final int year;

  FavouriteMovies({
    required this.id,
    required this.title,
    required this.imageURL,
    required this.rating,
    required this.year,
  });

  factory FavouriteMovies.fromJson(Map<String, dynamic> json) {
    return FavouriteMovies(
      id: int.tryParse(json['movieId'].toString()) ?? 0,
      title: json['name'] ?? '',
      imageURL: '', // initially empty
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      year: int.tryParse(json['year'].toString()) ?? 0,
    );
  }
}
