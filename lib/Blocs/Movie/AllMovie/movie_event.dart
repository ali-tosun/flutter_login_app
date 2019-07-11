import 'package:equatable/equatable.dart';
import 'package:flutter_login_app/Models/User/Movie.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MovieEvent extends Equatable {
  MovieEvent([List props = const []]) : super(props);
}

class FetchMovieData extends MovieEvent{}
class AddMovie extends MovieEvent{
  Movie movie;
  AddMovie(this.movie);
}
class RemoveMovie extends MovieEvent{
  Movie movie;
  RemoveMovie(this.movie);
}
