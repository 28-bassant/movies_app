import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
import 'api_model/movie.dart';


class MoviesCarousel extends StatefulWidget {
  final Function(Movie) onMovieSelected;

  const MoviesCarousel({super.key, required this.onMovieSelected});

  @override
  State<MoviesCarousel> createState() => _MoviesCarouselState();
}

class _MoviesCarouselState extends State<MoviesCarousel> {
  int _currentIndex = 0;
  late Future<List<Movie>> _moviesFuture;
  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(
      Uri.parse("https://yts.mx/api/v2/list_movies.json?sort_by=date_added"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List movies = data["data"]["movies"];
      return movies.map((m) => Movie.fromJson(m)).toList();
    } else {
      throw Exception("Failed to load movies");
    }
  }


  @override
  void initState() {
    super.initState();
    _moviesFuture = fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: _moviesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.yellow));
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return  Center(child: Text("No movies found",style:AppStyles.regular20White,));
        }

        final movies = snapshot.data!;

        return CarouselSlider.builder(
          itemCount: movies.length,
          itemBuilder: (context, index, realIdx) {
            final movie = movies[index];

            return GestureDetector(
                onTap: () {
                 // todo: Navigate to details screen
                },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Image.network(
                      movie.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.40,
                    ),

                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.blackBgColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(
                              movie.rating.toString(),
                              style: const TextStyle(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.star, color: AppColors.yellowColor, size: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
          },
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.40,
            enlargeCenterPage: true,
            viewportFraction: () {
              double width = MediaQuery.of(context).size.width;

              if (width < 350) {
                return 0.75;
              } else if (width < 600) {
                return 0.55;
              } else {
                return 0.35;
              }
            }(),
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
              widget.onMovieSelected(movies[index]);
            },

          ),
        );
      },
    );
  }
}
