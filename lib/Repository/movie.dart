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

  Future<Movie> addMovie(Movie movie) async{
    MovieApi movieApi = locator<MovieApi>();
    Movie responseMovie = await movieApi.addMovie(movie: movie);
    return responseMovie;
  }
  Future<List<Movie>> fetchUserMovieList(String username) async{
    MovieApi movieApi = locator<MovieApi>();
    List<Movie> myMovieList =  await movieApi.fetchUserMovieList(username);
    return myMovieList;
  }
}
