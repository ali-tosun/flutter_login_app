import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_app/Utils/network.dart';


class SignUpApi{

  Future<bool> signUp({String username, String password}) async {
    Dio dio = Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
//or works once
    var response = await dio
        .post("${StaticUtils.base_url}/register",
        data: {'username': username, 'password': password},
        options: new Options(
            contentType:
            ContentType.parse("application/x-www-form-urlencoded")));
    debugPrint(response.data.toString());

    return (response.data['status'] as bool);
  }

}