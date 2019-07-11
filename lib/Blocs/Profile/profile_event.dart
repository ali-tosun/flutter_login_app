import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  ProfileEvent([List props = const []]) : super(props);
}

class FetchUserMovieList extends ProfileEvent {
  String username;
  FetchUserMovieList({this.username});
}
