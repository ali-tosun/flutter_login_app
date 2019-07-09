import 'package:flutter/material.dart';
import 'package:flutter_login_app/Api/movie.dart';
import 'package:flutter_login_app/Models/User/Movie.dart';

import '../locator.dart';

class MovieRepository {
  Future<List<Movie>> fetchMovieList() async {
    MovieApi movieApi = locator<MovieApi>();
    List<Movie> movieList = await movieApi.fetchMovieList();
    debugPrint("moviexxx"+movieList.toString());
    return movieList;
  }
}
