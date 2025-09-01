import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/UI/home/taps/search-tap/cubit/search-state.dart';
import '../../home-tap/movie_service.dart';


class SearchViewModel extends Cubit<SearchState> {
  SearchViewModel() : super(SearchInitial());

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }
    emit(SearchLoading());
    try {
      final movies = await MovieService.fetchMovies(query: query);
      if (movies.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(SearchLoaded(movies));
      }
    } catch (e) {
      emit(SearchError("Error: $e"));
    }
  }
}