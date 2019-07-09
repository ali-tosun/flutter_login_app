import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_app/Blocs/Movie/bloc.dart';
import 'package:flutter_login_app/Blocs/Movie/movie_bloc.dart';
import 'package:flutter_login_app/Blocs/bloc.dart';
import 'package:flutter_login_app/Widget/sign_in.dart';

import 'auth_page.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final signInBloc = BlocProvider.of<SignInBloc>(context);
    final movieBloc= BlocProvider.of<MovieBloc>(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Home Page'),
      ),
      body: Container(
          child: BlocBuilder(
        bloc: signInBloc,
        builder: (context, state) {
          if (state is InitialSignInState) {
            return ListView(
              children: <Widget>[
                SignInWidget()
              ],
            );
          }
          if (state is SignInSuccessfulState) {
            movieBloc.dispatch(FetchMovieData());
            return AuthPage();
          }
          if (state is SignInLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is SignInErrorState) {
            return Center(child: Text("hata.."));
          }
          if (state is SignInWrongPasswordState) {
            return ListView(
              children: <Widget>[
                SignInWidget.name(state.username, state.password),
              ],
            );
          }
        },
      )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
