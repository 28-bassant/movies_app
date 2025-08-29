import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_model/movie.dart';

class MovieService {
  static const String baseUrl = "https://yts.mx/api/v2/list_movies.json";

  static Future<List<Movie>> fetchMovies() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);


        final List moviesJson = data['data']['movies'];

        return moviesJson.map((movieJson) => Movie.fromJson(movieJson)).toList();
      } else {
        throw Exception("Failed to load movies. Status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching movies: $e");
    }
  }
}
