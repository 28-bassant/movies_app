class BrowseMovie {
  final int id;
  final String title;
  final String mediumCoverImage;
  final double rating;

  BrowseMovie({
    required this.id,
    required this.title,
    required this.mediumCoverImage,
    required this.rating,
  });

  factory BrowseMovie.fromJson(Map<String, dynamic> json) {
    return BrowseMovie(
      id: json['id'],
      title: json['title'],
      mediumCoverImage: json['medium_cover_image'],
      rating: (json['rating'] as num).toDouble(),
    );
  }
}
