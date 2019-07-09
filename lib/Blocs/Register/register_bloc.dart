import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_login_app/Repository/sign_up.dart';
import '../../locator.dart';
import './bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  @override
  RegisterState get initialState => InitialRegisterState();
  SignUpRepository signUpRepository = locator<SignUpRepository>();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is SignUp) {
      try {
        yield SignUpLoadingState();

        bool isRegistered =
            await signUpRepository.signUp(event.userName, event.password);

        if (isRegistered) {
          yield SignUpSuccessfulState();
        } else {
          yield SignUpErrorState();
        }
      } catch (exception) {
        yield SignUpErrorState();

        /// catch için ayrı bir exception sayfası hazırlanacak
      }
    } else if (event is SignUpInitial) {
      //sayfa ilk açıldığında..
      yield InitialRegisterState();
    }
  }
}
