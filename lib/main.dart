import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_login_app/Blocs/Movie/AllMovie/movie_bloc.dart';
import 'Blocs/Movie/AddMovie/addmovie_bloc.dart';
import 'Blocs/Profile/profile_bloc.dart';
import 'Blocs/Register/register_bloc.dart';
import 'package:flutter_login_app/Blocs/Sign_In/sign_in_bloc.dart';
import 'Widget/home_page.dart';
import 'Widget/login_widget/login_page.dart';
import 'locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<SignInBloc>(
          builder: (context) => SignInBloc(),
        ),
        BlocProvider<RegisterBloc>(
          builder: (context) => RegisterBloc(),
        ),
        BlocProvider<MovieBloc>(
          builder: (context) => MovieBloc(),
        ),
        BlocProvider<AddmovieBloc>(
          builder: (context) => AddmovieBloc(),
        ),
        BlocProvider<ProfileBloc>(
          builder: (context) => ProfileBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
