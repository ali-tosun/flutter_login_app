import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_login_app/Models/User/Movie.dart';
import 'package:flutter_login_app/Repository/movie.dart';
import '../../locator.dart';
import './bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  List<Movie> _movieList;


  bool get isLoadingData => _isLoadingData;

  set isLoadingData(bool value) {
    _isLoadingData = value;
  }

  List<Movie> get movieList => _movieList;

  set movieList(List<Movie> value) {
    _movieList = value;
  }

  @override
  ProfileState get initialState => InitialProfileState();
  bool _isLoadingData = false;
  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is FetchUserMovieList) {
      try {
        yield LoadingProfileState();
        MovieRepository movieRepository = locator<MovieRepository>();
        List<Movie> userMovieList =
            await movieRepository.fetchUserMovieList(event.username);
        if (userMovieList == null) {
          yield ErrorProfileState();
        } else {
          movieList = userMovieList;
          yield LoadedProfileState(movieList: movieList);
          isLoadingData = true;
        }
      } catch (exception) {
        yield ErrorProfileState();
      }
    }
  }
}
