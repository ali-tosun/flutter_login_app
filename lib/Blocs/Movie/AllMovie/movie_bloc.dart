import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_app/Models/User/Movie.dart';
import 'package:flutter_login_app/Repository/movie.dart';
import 'package:flutter_login_app/Blocs/Movie/AllMovie/bloc.dart';
import '../../../locator.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  List<Movie> _movieList;

  List<Movie> get movieList => _movieList;

  set movieList(List<Movie> value) {
    _movieList = value;
  }

  @override
  MovieState get initialState => InitialMovieState();

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    MovieRepository movieRepository = locator<MovieRepository>();
    if (event is FetchMovieData) {
      try {
        yield MovieLoadingState(); //lo

        List<Movie> responseMovieList = await movieRepository.fetchMovieList();
        debugPrint(responseMovieList.toString() + "ccxx");
        movieList = responseMovieList;

        if (movieList == null) {
          debugPrint("movie bloc null");
          yield MovieErrorState();
        } else {
          debugPrint("movie bloc calisti");
          yield MovieLoadedState(movieList);
        }
      } catch (exception) {
        debugPrint(exception.toString());
        yield MovieErrorState();
      }
    }
    if (event is AddMovie) {
      movieList.add(event.movie);
      yield MovieLoadedState(movieList);
    }
  }
}
