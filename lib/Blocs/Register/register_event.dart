import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super(props);
}

class SignUp extends RegisterEvent {
  String userName;
  String password;
  SignUp(this.userName, this.password) : super([userName, password]);
}
class SignUpInitial extends RegisterEvent{

}
