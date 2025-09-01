import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/l10n/app_localizations.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../movies_details_screen.dart';

class SimilarMoviesSection extends StatefulWidget {
  final int movieId;

  const SimilarMoviesSection({super.key, required this.movieId});

  @override
  State<SimilarMoviesSection> createState() => _SimilarMoviesSectionState();
}

class _SimilarMoviesSectionState extends State<SimilarMoviesSection> {
  List<dynamic> similarMovies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSimilarMovies();
  }

  Future<void> fetchSimilarMovies() async {
    final url = "https://yts.mx/api/v2/movie_suggestions.json?movie_id=${widget.movieId}";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          similarMovies = data['data']['movies'] ?? [];
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Error: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.yellow));
    }

    if (similarMovies.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("No similar movies found", style: TextStyle(color: Colors.white)),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.similar,
            style: AppStyles.bold24White
        ),
        SizedBox(height: height*0.02,),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 14,
            childAspectRatio: 0.85,
          ),
          itemCount: similarMovies.length,
          itemBuilder: (context, index) {
            final movie = similarMovies[index];
           return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MoviesDetailsScreen(movieId: movie['id']),
                    ),
                  );
                },
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Image.network(
                        movie['medium_cover_image'],
                        height: height * 0.25,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: height * 0.25,
                          color: Colors.grey.shade800,
                          child: const Icon(Icons.broken_image, color: AppColors.whiteColor),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${movie['rating'] ?? 'N/A'}",
                                style: AppStyles.bold12White,
                              ),
                               SizedBox(width:width*0.02 ),
                              const Icon(Icons.star, color:AppColors.yellowColor , size: 16),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                ),
              ],
            ));
          },
        ),
      ],
    );
  }
}
