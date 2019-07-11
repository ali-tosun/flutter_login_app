import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/Utils/network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter_login_app/Models/User/Movie.dart';

class MovieApi {
  Future<List<Movie>> fetchMovieList() async {
    final prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('user_token') ?? '';
    debugPrint(userToken + "user token fetch movie list");
    Dio dio = Dio();

    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    var response = await dio.get(
      "${StaticUtils.base_url}/api/movies/allfilm",
      options: new Options(
          contentType: ContentType.parse("application/x-www-form-urlencoded"),
          headers: {'x-access-token': userToken}),
    );

    debugPrint(response.data.toString() + "tosun response");

    if (response.data['status'] == false) {
      //eğer bir hata varsa null bir movieList döndür.ve bunu bloc da ayıkla.
      List<Movie> movieList = null;
      debugPrint("film movie hata");
      return movieList;
    }

    List<Movie> movieList = (response.data['data'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();
    return movieList;
  }

  Future<Movie> addMovie({Movie movie}) async {
    final prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('user_token') ?? '';
    Dio dio = Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
//or works once
    var response = await dio.post(
      "${StaticUtils.base_url}/api/movies/add",
      data: {'title':movie.title,'category':movie.category,'author':movie.author},
      options: new Options(
          contentType: ContentType.parse("application/x-www-form-urlencoded"),
          headers: {'x-access-token': userToken}
      ),
    );

    if (response.data['status'] == true) {
      debugPrint("addd movie status true");
      debugPrint(response.data.toString());
      Movie movie = Movie.fromJson(response.data['data']);
      return movie;
    } else {
      return null;
    }
  }

  Future<List<Movie>> fetchUserMovieList(String username) async {
    final prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('user_token') ?? '';
    debugPrint(userToken + "user token fetch movie list");
    Dio dio = Dio();

    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    var response = await dio.get(
      "${StaticUtils.base_url}/api/movies/user_movie/${username}",
      options: new Options(
          contentType: ContentType.parse("application/x-www-form-urlencoded"),
          headers: {'x-access-token': userToken}),
    );

    debugPrint(response.data.toString() + "tosun response");

    if (response.data['status'] == false) {
      //eğer bir hata varsa null bir movieList döndür.ve bunu bloc da ayıkla.
      List<Movie> movieList = null;
      debugPrint("film movie hata");
      return movieList;
    }

    List<Movie> movieList = (response.data['data'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();
    return movieList;
  }
}
