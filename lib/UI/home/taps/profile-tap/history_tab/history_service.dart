import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../home-tap/api_model/movie.dart';

class HistoryService {
  static const String historyKey = "movie_history";

  Future<void> addMovie(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(historyKey) ?? [];

    final movieJson = jsonEncode({
      'id': movie.id,
      'title': movie.title,
      'posterPath': movie.posterPath,
      'image': movie.image,
      'rating': movie.rating,
    });

    history.removeWhere((item) {
      final decoded = jsonDecode(item);
      return decoded['id'] == movie.id;
    });

    history.insert(0, movieJson);

    if (history.length > 20) history.removeLast();

    await prefs.setStringList(historyKey, history);
  }

  Future<List<Movie>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(historyKey) ?? [];
    return history.map((item) {
      final decoded = jsonDecode(item);
      return Movie(
        id: decoded['id'],
        title: decoded['title'],
        posterPath: decoded['posterPath'] ?? decoded['image'] ?? "",
        image: decoded['image'] ?? decoded['posterPath'] ?? "",
        rating: decoded['rating'],
        genres: [],
        year: "",
      );
    }).toList();
  }
}
