import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_app/Models/User/User.dart';
import 'package:flutter_login_app/Repository/sign_in.dart';
import '../../locator.dart';
import 'package:flutter_login_app/Blocs/Sign_In/bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  User _user;

  User get user => _user;

  set user(User value) {
    _user = value;
  }

  @override
  SignInState get initialState => InitialSignInState();

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    SignInRepository signInRepository = locator<SignInRepository>();

    if (event is SignIn) {
      try {
        yield SignInLoadingState();
        User responseUser = await signInRepository.signIn(
            username: event.userName, password: event.password);
        if (responseUser != null) {

          //kimlik doğrulama başarılı ise
          user=responseUser;
          debugPrint(user.toString()+"alix");
          yield SignInSuccessfulState(user);
        } else {
          //kimlik doğrulama başarısız ise başlangıç state.
          yield SignInWrongPasswordState(username: event.userName,password: event.password);
          //kullanıcının username ve passwordunu tekrardan textControllerda göstermek için.
        }
      } catch (exception) {
        yield SignInErrorState();
        throw exception;
      }
    } else if (event is SignOut) {
      yield InitialSignInState();
    }
  }
}
