import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/UI/movies_details/cubit/movie_details_states.dart';
import 'package:movies_app/api/api-manager.dart';

class MovieDetailsViewModel extends Cubit<MovieDetailsStates>{
  MovieDetailsViewModel():super(MovieDetailsLoadingState());
  
  void getMovieDetailsByMovieId(num movieId)async {
    try{
      emit(MovieDetailsLoadingState());
      var response  = await ApiManager.getMovieDetailsByMovieId(movieId);
      if(response?.status == 'error'){
        emit(MovieDetailsErrorState(errorMessage:response!.statusMessage));
      }
      else if (response?.status == 'ok'){
        emit(MovieDetailsSuccessState(movieDetails: response!.data!.movie));
      }
    }
    catch(e){
      emit(MovieDetailsErrorState(errorMessage: e.toString()));
    }
  }
}