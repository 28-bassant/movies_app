import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'api_model/movie.dart';

class GenreMoviesScreen extends StatelessWidget {
  final String genre;
  final List<Movie> movies;

  const GenreMoviesScreen({
    super.key,
    required this.genre,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.blackBgColor,
      appBar: AppBar(
        title: Text(
          "$genre Movies",
          style: const TextStyle(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.blackBgColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.movieDetailsScreenRouteName,
              arguments: movie.id);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Image.network(
                      movie.image,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 200,
                        color: Colors.grey.shade800,
                        child: const Icon(Icons.broken_image, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(
                      vertical: height * .01,
                      horizontal: width * .02
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              movie.year,
                              style: const TextStyle(
                                  fontSize: 12, color: AppColors.greyColor),
                            ),
                            Row(
                              children: [
                                Text(
                                  movie.rating.toString(),
                                  style: const TextStyle(
                                      fontSize: 12, color: AppColors.yellowColor),
                                ),
                                const Icon(Icons.star,
                                    size: 14, color: AppColors.yellowColor),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
