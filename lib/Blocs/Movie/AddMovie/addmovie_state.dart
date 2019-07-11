import 'package:equatable/equatable.dart';
import 'package:flutter_login_app/Models/User/Movie.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AddmovieState extends Equatable {
  AddmovieState([List props = const []]) : super(props);
}

class InitialAddmovieState extends AddmovieState {}

class AddMovieErrorState extends AddmovieState {}

class AddMovieLoadingState extends AddmovieState {}

class AddMovieAddedState extends AddmovieState {
  Movie movie;

  AddMovieAddedState(this.movie);
}

class AddMovieNotBeAdded extends AddmovieState {}
