import 'package:equatable/equatable.dart';
import 'package:flutter_login_app/Models/User/Movie.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProfileState extends Equatable {
  ProfileState([List props = const []]) : super(props);
}

class InitialProfileState extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class LoadedProfileState extends ProfileState {
  List<Movie> movieList;

  LoadedProfileState({this.movieList});
}

class ErrorProfileState extends ProfileState {}
