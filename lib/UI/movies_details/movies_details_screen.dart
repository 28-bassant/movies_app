
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/UI/home/taps/home-tap/api_model/movie.dart';
import 'package:movies_app/UI/movies_details/cubit/movie_details_states.dart';
import 'package:movies_app/UI/movies_details/cubit/movie_details_view_model.dart';
import 'package:movies_app/UI/movies_details/sections/cast-section.dart';
import 'package:movies_app/UI/movies_details/sections/genres_section.dart';
import 'package:movies_app/UI/movies_details/sections/screenshots_section.dart';
import 'package:movies_app/UI/movies_details/sections/similar_movie_section.dart';
import 'package:movies_app/UI/movies_details/sections/watch_section.dart';
import 'package:movies_app/api/api-manager.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

import '../../model/movie_details_response.dart';
import '../../model/movie_details_response.dart' as summary;
class MoviesDetailsScreen extends StatefulWidget {
  final num movieId;
  MoviesDetailsScreen({super.key , required this.movieId});

  @override
  State<MoviesDetailsScreen> createState() => _MoviesDetailsScreenState();
}

class _MoviesDetailsScreenState extends State<MoviesDetailsScreen> {

  MovieDetailsViewModel viewModel = MovieDetailsViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getMovieDetailsByMovieId(widget.movieId);
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var args = widget.movieId;

    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: AppColors.blackBgColor,
          body:BlocBuilder<MovieDetailsViewModel,MovieDetailsStates>
            (
            bloc: viewModel,
            builder
              :(context, state) {
              if(state is MovieDetailsSuccessState){
                print("Movie ID success: ${args}");
                final movie = state.movieDetails;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WatchSection(movieDetails: movie!),
                      SizedBox(height: height * .04,),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: width * .04),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ScreenshotsSection(movieDetails: movie!),
                                SizedBox(height: height * .02),
                                SimilarMoviesSection(movieId:movie.id!),
                                SizedBox(height: height * .02),

                                Text(
                                    AppLocalizations.of(context)!.summary,
                                    style: AppStyles.bold24White
                                ),
                                SizedBox(height: height * .02),
                                Text(
                                    movie.descriptionFull != null && movie.descriptionFull!.isNotEmpty
                                        ? movie.descriptionIntro!
                                        : AppLocalizations.of(context)!.no_description,
                                    style: AppStyles.regular16White
                                ),
                                SizedBox(height: height * .02),
                                CastSection(castList: movie.cast,),
                                SizedBox(height: height * .02),

                                GenresSection(movieDetails: movie,),
                                SizedBox(height: height * .02),




                              ])
                      )
                    ],
                  ),
                );

              }
              else if(state is MovieDetailsErrorState){
                print("Movie ID client error: ${args}");
                      return Center(
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: width * .02),
                          child: Column(
                            children: [
                              Center(child: Text(state.errorMessage!, style:  AppStyles.bold20Orange,)),
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
              else{
                return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.orangeColor,
                            ),
                          );
              }
            },
          )

      ),
    );
  }
}