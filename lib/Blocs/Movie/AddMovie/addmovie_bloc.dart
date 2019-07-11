import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/Models/User/Movie.dart';
import 'package:flutter_login_app/Repository/movie.dart';
import '../../../locator.dart';
import './bloc.dart';

class AddmovieBloc extends Bloc<AddmovieEvent, AddmovieState> {
  Movie _movie;

  Movie get movie => _movie;

  set movie(Movie value) {
    _movie = value;
  }

  @override
  AddmovieState get initialState => InitialAddmovieState();

  @override
  Stream<AddmovieState> mapEventToState(
    AddmovieEvent event,
  ) async* {
    if (event is AddMovieEvent) {
      debugPrint("add movie bloc dart");
      MovieRepository movieRepository = locator<MovieRepository>();
      try {
        yield AddMovieLoadingState();
        Movie myMovie = await movieRepository.addMovie(event.movie);
        debugPrint(myMovie.toString());
        if (myMovie == null) {
          movie = myMovie;
          yield AddMovieNotBeAdded();
        } else {
          yield AddMovieAddedState(myMovie);
        }
      } catch (exception) {
        debugPrint(exception.toString() + "add exception");
        yield AddMovieErrorState();
      }
    }
    if (event is AddMovieInitialPage) {
      yield InitialAddmovieState();
    }
    // TODO: Add Logic
  }
}
