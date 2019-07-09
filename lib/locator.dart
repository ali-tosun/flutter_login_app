import 'package:get_it/get_it.dart';

import 'Api/movie.dart';
import 'Api/sign_in.dart';
import 'Api/sign_up.dart';
import 'Repository/movie.dart';
import 'Repository/sign_in.dart';
import 'Repository/sign_up.dart';

GetIt locator = new GetIt();


void setupLocator(){
  locator.registerLazySingleton(()=>SignInRepository());
  locator.registerLazySingleton(()=>SignInApi());
  locator.registerLazySingleton(()=>SignUpApi());
  locator.registerLazySingleton(()=>SignUpRepository());
  locator.registerLazySingleton(()=> MovieRepository());
  locator.registerLazySingleton(()=>MovieApi());
}