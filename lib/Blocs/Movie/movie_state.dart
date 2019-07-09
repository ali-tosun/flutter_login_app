import 'package:equatable/equatable.dart';
import 'package:flutter_login_app/Models/User/Movie.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MovieState extends Equatable {
  MovieState([List props = const []]) : super(props);
}

class InitialMovieState extends MovieState {}
class MovieLoadingState extends MovieState{}
class MovieLoadedState extends MovieState{
  List<Movie> movieList;

  MovieLoadedState(this.movieList);

}
class MovieErrorState extends MovieState{}
