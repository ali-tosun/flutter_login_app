import 'package:flutter/material.dart';
import 'package:flutter_login_app/Api/sign_in.dart';
import 'package:flutter_login_app/Models/User/User.dart';

import '../locator.dart';

class SignInRepository {
  Future<User> signIn({String username, String password, String token}) async {
    SignInApi signInApi = locator<SignInApi>();
    var user= await signInApi.signIn(username: username,password: password);
    //debugPrint(user.toString()+"repo");
    return user;
  }
}

