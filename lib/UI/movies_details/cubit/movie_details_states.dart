import 'package:movies_app/UI/home/taps/home-tap/api_model/movie.dart';
import 'package:movies_app/model/movie_details_response.dart';

abstract class MovieDetailsStates{}
class MovieDetailsLoadingState extends MovieDetailsStates{}
class MovieDetailsErrorState extends MovieDetailsStates{
  String? errorMessage;
   MovieDetailsErrorState({required this.errorMessage});
}
class MovieDetailsSuccessState extends MovieDetailsStates{
MovieDetails? movieDetails;
MovieDetailsSuccessState({required this.movieDetails});
}