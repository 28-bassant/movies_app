
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/UI/home/taps/home-tap/api_model/movie.dart';
import 'package:movies_app/UI/movies_details/sections/screenshots_section.dart';
import 'package:movies_app/UI/movies_details/sections/watch_section.dart';
import 'package:movies_app/api/api-manager.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

import '../../model/movie_details_response.dart';
import '../../model/movie_details_response.dart' as summary;

class MoviesDetailsScreen extends StatefulWidget {
   MoviesDetailsScreen({super.key});

  @override
  State<MoviesDetailsScreen> createState() => _MoviesDetailsScreenState();
}

class _MoviesDetailsScreenState extends State<MoviesDetailsScreen> {
late var args;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        fetchMovie();
      },
    );
  }
  @override
  Widget build(BuildContext context) {
     args = ModalRoute.of(context)?.settings.arguments as int;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: AppColors.blackBgColor,
      
      body:FutureBuilder<MovieDetailsResponse?>(
          future: ApiManager.getMovieDetailsByMovieId(args),
          builder: (context, snapshot) {
            //todo : Loading
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.orangeColor,
                ),
              );
            }
            //todo: Error from client
                else if(snapshot.hasError){
              print("Movie ID client error: ${args}");
      
              return Center(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: width * .02),
                      child: Column(
                        children: [
                          Center(child: Text(AppLocalizations.of(context)!.something_went_wrong, style:  AppStyles.bold20Orange,)),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.greyColor
                            ),
                              onPressed: () {
                                ApiManager.getMovieDetailsByMovieId(args);
                                setState(() {
      
                                });
      
                              },
                              child: Center(child: Text(AppLocalizations.of(context)!.try_again,style: AppStyles.bold20Orange,))
      
                          ),
      
                        ],
                      ),
                    ),
                  );
                }
            //todo: Error from server
      
            else if(snapshot.data?.status != 'ok'){
              print("Movie ID error server: ${args}");
              return Center(child: Text(snapshot.data!.statusMessage!,style: AppStyles.bold20Orange,));
            }
            //todo: Success
            else{
              print("Movie ID success: ${args}");
              final movie = snapshot.data?.data?.movie;

      
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WatchSection(movieDetails: movie!),
                    SizedBox(height: height * .04,),
                    Padding(
                        padding: EdgeInsetsGeometry.symmetric(
                          horizontal: width * .04
                        ),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (movie.largeScreenshotImage1 != null &&
                        movie.largeScreenshotImage2 != null &&
                        movie.largeScreenshotImage3 != null) ?
                        ScreenshotsSection(movieDetails: movie) :
                        SizedBox(height: height * .04,),

                          ],
                        )
                      ],
                    ),
                    )
                  ],
                ),
              );
      
            }
          },)
      ),
    );
  }
  void fetchMovie() async {
    var response = await ApiManager.getMovieDetailsByMovieId(args);

    // Access the MovieDetails object
    var movieDetails = response?.data?.movie;

    // Print the screenshot URLs
    print("Large Screenshot 1: ${movieDetails?.largeScreenshotImage1}");
    print("Large Screenshot 2: ${movieDetails?.largeScreenshotImage2}");
    print("Large Screenshot 3: ${movieDetails?.largeScreenshotImage3}");

    // Optional: print medium screenshots too
    print("Medium Screenshot 1: ${movieDetails?.mediumScreenshotImage1}");
    print("Medium Screenshot 2: ${movieDetails?.mediumScreenshotImage2}");
    print("Medium Screenshot 3: ${movieDetails?.mediumScreenshotImage3}");
    print("Cast: ${movieDetails?.cast}");
  }

}
