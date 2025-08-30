import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import '../../../../utils/app_assets.dart';

import 'api_model/movie.dart';
import 'movies_carousel.dart';
import 'movies_section.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Movie? selectedMovie;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.blackBgColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            
            Positioned.fill(
              child: selectedMovie != null
                  ? Image.network(
                selectedMovie!.image,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                AppAssets.homeTabImage,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.9),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(height: height * 0.01),
            
            
                      Image.asset(
                        AppAssets.availableNow,
                        height: height * 0.1,
                        fit: BoxFit.fitWidth,
                      ),
            
                      // Movies Carousel + callback
                      MoviesCarousel(
                        onMovieSelected: (movie) {
                          setState(() {
                            selectedMovie = movie;
                          });
                        },
                      ),
            
                      SizedBox(height: height * 0.02),
            
            
                      Image.asset(
                        AppAssets.watchNow,
                        height: height * 0.15,
                        fit: BoxFit.fitWidth,
                      ),
                      MoviesSection(),
                      SizedBox(height: height * .1,)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
