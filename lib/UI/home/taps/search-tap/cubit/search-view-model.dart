import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/UI/home/taps/home-tap/api_model/movie.dart';
import 'package:movies_app/UI/home/taps/search-tap/cubit/search-state.dart';
import '../../../../../utils/app_assets.dart';
import '../../home-tap/movie_service.dart';

class SearchViewModel extends Cubit<SearchState> {
  SearchViewModel() : super(SearchInitial());

  /// TODO: Test movies
  final List<Movie> _movies = [
    Movie(
      id: 1,
      title: 'Movie 1',
      image: AppAssets.movieImage,
      year: '1998',
      rating: 5.0,
      genres: ['action'],
    ),
    Movie(
      id: 2,
      title: 'Movie 2',
      image: AppAssets.movieImage,
      year: '1999',
      rating: 6.0,
      genres: ['action', 'comedy'],
    ),
    Movie(
      id: 3,
      title: 'Movie 3',
      image: AppAssets.movieImage,
      year: '1999',
      rating: 5.0,
      genres: ['comedy'],
    ),
    Movie(
      id: 4,
      title: 'Movie 4',
      image: AppAssets.movieImage,
      year: '2005',
      rating: 7.0,
      genres: ['adventure', 'drama'],
    ),
  ];

  Future<void> searchMovies({String? query, String? genre}) async {
    if (query == null) {
      emit(SearchInitial());
      return;
    }
    emit(SearchLoading());
    try {
      ///todo: replace _movies with movies
      final movies = await MovieService.fetchMovies(query: query);
      if (_movies.isEmpty) {
        emit(SearchEmpty());
      } else {
        if (genre == null || genre.isEmpty) {
          emit(SearchLoaded(_movies));
        } else {
          final filteredMovies = _movies.where(
            (movie) => movie.genres.contains(genre),
          ).toList();
          emit(SearchLoaded(filteredMovies));
        }
      }
    } catch (e) {
      emit(SearchError("Error: $e"));
    }
  }
}
