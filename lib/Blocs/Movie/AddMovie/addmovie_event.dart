import 'package:equatable/equatable.dart';
import 'package:flutter_login_app/Models/User/Movie.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AddmovieEvent extends Equatable {
  AddmovieEvent([List props = const []]) : super(props);
}

class AddMovieEvent extends AddmovieEvent {
  Movie movie;
  AddMovieEvent({this.movie});
}
class AddMovieInitialPage extends AddMovieEvent{

}
