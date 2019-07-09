import 'package:flutter_login_app/Models/User/User.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SignInState {}

class InitialSignInState extends SignInState {}
class SignInLoadingState extends SignInState {}
class SignInSuccessfulState extends SignInState{
  User user;

  SignInSuccessfulState(this.user);

}
class SignInWrongPasswordState extends SignInState{
  String username,password;

  SignInWrongPasswordState({this.username, this.password});

}
class SignInErrorState extends SignInState {}
