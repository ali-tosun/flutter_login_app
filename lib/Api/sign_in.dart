import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/Models/User/User.dart';
import 'package:flutter_login_app/Utils/network.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInApi {
  Future<User> signIn({String username, String password}) async {
    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
//or works once
    var response = await dio.post("${StaticUtils.base_url}/login",
        data: {'username': username, 'password': password},
        options: new Options(
            contentType:
                ContentType.parse("application/x-www-form-urlencoded")));

    if(response.data['status']==true){
      User user = User.fromJson(response.data);
      prefs.setString('user_token', user.token); //user tokenini shared pref ile kaydedilmesi.
      //bu token film ekleme ve sorgulama işlemlerinde işimize yarayacak..
      debugPrint(response.data.toString()+"aliapi");
      return user;
    }else{
      return null;
    }


  }
}
