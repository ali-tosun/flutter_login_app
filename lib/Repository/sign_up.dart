import 'package:flutter_login_app/Api/sign_up.dart';

import '../locator.dart';





class SignUpRepository{


  Future<bool >signUp(String userName,String password) async{
    SignUpApi signUpApi=locator<SignUpApi>();

    var isRegistered =await signUpApi.signUp(username: userName,password: password);
    return isRegistered;

  }

}