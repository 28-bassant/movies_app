import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_model/movie.dart';
class MovieService {
  static const String baseUrl = "https://yts.mx/api/v2/list_movies.json";
  static Future<List<Movie>> fetchMovies({String? query}) async {
    try {
      Uri url;
      if (query != null && query.isNotEmpty) {
        url = Uri.parse("$baseUrl?query_term=$query");
      } else {
        url = Uri.parse(baseUrl);
      }
      final response = await http.get(url).timeout(const Duration(seconds: 40));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List moviesJson = data['data']['movies'] ?? [];

        return moviesJson.map((json) {
          try {
            return Movie.fromJson(json);
          } catch (_) {
            return null;
          }
        }).where((m) => m != null).cast<Movie>().toList();
      } else {
        throw Exception("Failed to load movies. Status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching movies: $e");
    }
  }
}