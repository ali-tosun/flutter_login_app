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
    String user_token = prefs.getString('user_token') ?? '';
    debugPrint(user_token + "user token fetch movie list");
    Dio dio = Dio();

    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    var response = await dio.get(
      "${StaticUtils.base_url}/api/movies/allfilm",
      options: new Options(
          contentType: ContentType.parse("application/x-www-form-urlencoded"),
          headers: {'x-access-token': user_token}),
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
