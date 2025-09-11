import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/UI/home/widgets/movie_type_tab_bar.dart';
import 'package:movies_app/model/movie_details_response.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';

import '../../../../model/browse_movie.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  String selectedCategory = "action"; // default
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchMoviesByGenre(selectedCategory); // load first category
  }

  List<BrowseMovie> movies = [];

  Future<void> fetchMoviesByGenre(String genre) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse("https://yts.mx/api/v2/list_movies.json?genre=$genre"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> moviesJson = data["data"]["movies"] ?? [];

        setState(() {
          movies = moviesJson.map((json) => BrowseMovie.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          movies = [];
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching movies by genre: $e");
      setState(() {
        movies = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blackBgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MovieTypeTabBar(
              onCategorySelected: (String category) {
                setState(() {
                  selectedCategory = category;
                });
                fetchMoviesByGenre(category);
              },
            ),
            Expanded(
              child: isLoading
                  ? const Center(
                child: CircularProgressIndicator(color: AppColors.yellowColor),
              )
                  : movies.isEmpty
                  ? const Center(
                child: Text(
                  "No movies found",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
                  : GridView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: width * .02,
                  vertical: height * .01,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: width * .06,
                  mainAxisSpacing: height * 0.02,
                  childAspectRatio: 0.65,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.movieDetailsScreenRouteName,
                      arguments: movie.id);
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            movie.mediumCoverImage ??'',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Container(

                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            width: 60,
                            decoration: BoxDecoration(
                              color: AppColors.lightBlack,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  movie.rating.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.star,
                                    color: AppColors.yellowColor, size: 16),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
