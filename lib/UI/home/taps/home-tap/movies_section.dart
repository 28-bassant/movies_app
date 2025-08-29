import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
import 'api_model/movie.dart';
import 'gener_movie_screen.dart';
import 'movie_service.dart';

class MoviesSection extends StatefulWidget {
  const MoviesSection({super.key});

  @override
  State<MoviesSection> createState() => _MoviesSectionState();
}

class _MoviesSectionState extends State<MoviesSection> {
  final List<String> genresOrder = ["Action", "Comedy", "Drama", "Horror", "Thriller"];
  String currentGenre = "Action";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final random = Random();
    setState(() {
      currentGenre = genresOrder[random.nextInt(genresOrder.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return FutureBuilder<List<Movie>>(
      future: MovieService.fetchMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.yellow),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return  Center(child: Text("No movies found",style:AppStyles.regular20White,));
        }

        final genreMovies = snapshot.data!
            .where((movie) => movie.genres.contains(currentGenre))
            .toList();

        if (genreMovies.isEmpty) {
          return Center(
            child: Text("No movies for $currentGenre"),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      currentGenre,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => GenreMoviesScreen(
                              genre: currentGenre,
                              movies: genreMovies,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "See More →",
                        style: TextStyle(fontSize: 14, color: Colors.yellow),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: genreMovies.length,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemBuilder: (context, index) {
                    final movie = genreMovies[index];
                    return Container(
                      width: 130,
                      margin: const EdgeInsets.only(right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              children:[ Image.network(
                                movie.image,
                                height: 180,
                                width: 130,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  height: 180,
                                  width: 130,
                                  color: Colors.grey.shade800,
                                  child: const Icon(Icons.broken_image, color: Colors.white),
                                ),
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

                            ]),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );

      },
    );
  }
}
