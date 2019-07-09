import 'package:meta/meta.dart';

@immutable
abstract class SignInEvent {}

class SignOut extends SignInEvent{}

class SignIn extends SignInEvent{
  String token;
  String userName;
  String password;

  SignIn({this.token, this.userName, this.password});

}
