import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_app/Blocs/Movie/AllMovie/bloc.dart';
import 'package:flutter_login_app/Blocs/Profile/bloc.dart';
import 'package:flutter_login_app/Blocs/Profile/profile_bloc.dart';
import 'package:flutter_login_app/Blocs/Sign_In/bloc.dart';
import 'package:flutter_login_app/Models/User/User.dart';
import 'package:flutter_login_app/Widget/profile.dart';

import 'card_widget/movie_row.dart';

class AuthPage extends StatefulWidget {
  User user;
  String isProfileLoading;

  AuthPage({this.isProfileLoading});

  @override
  AuthPageState createState() => new AuthPageState();
}

class AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  int bottomNavigationBarIndex = 0;
  TabController controller;
  bool firstLoading=true;


  @override
  void initState() {

    // TODO: implement initState

    super.initState();

    if(firstLoading){
      var movieBloc = BlocProvider.of<MovieBloc>(context);
      movieBloc.dispatch(FetchMovieData());
      debugPrint("profile datası indiriliyor...");
      /// TODO BURAYA BAK
     firstLoading=false;
    }
    debugPrint("auth page init state");
  }

  @override
  Widget build(BuildContext context) {
    var signInBloc = BlocProvider.of<SignInBloc>(context);
    var movieBloc = BlocProvider.of<MovieBloc>(context);

    return new Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), title: Text("Account")),
        ],
        onTap: (index) {
          setState(() {
            bottomNavigationBarIndex = index;
          });
        },
        currentIndex: bottomNavigationBarIndex,
      ),
      body: selectedWidget(bottomNavigationBarIndex),
    );
  }

  Widget _buildAboutDialog() {
    return new AlertDialog(
      title: const Text('About Pop up'),
      content: SingleChildScrollView(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Kullanıcı Adı", border: OutlineInputBorder()),
                  validator: (userName) {
                    if (userName.length < 3) {
                      return "Kullanıcı adınız 3 karakterden fazla olmalıdır.";
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Okay, got it!'),
        ),
      ],
    );
  }

  selectedWidget(int bottomNavigationBarIndex) {
    switch (bottomNavigationBarIndex) {
      case 0:
        return MyAuthBody();
        break;
      case 1:
        return Profile();
        break;
    }
  }
}

class MyAuthBody extends StatefulWidget {
  @override
  MyAuthBodyState createState() => new MyAuthBodyState();
}

class MyAuthBodyState extends State<MyAuthBody> {
  @override
  Widget build(BuildContext context) {
    var movieBloc = BlocProvider.of<MovieBloc>(context);
    return Container(
      child: BlocBuilder(
          bloc: movieBloc,
          builder: (context, state) {
            if (state is InitialMovieState) {
              return Center(child: Text("Filmler yüklenilcek.."));
            } else if (state is MovieLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieErrorState) {
              return Center(
                child: Text("Filmler yüklenirken bir problem oluştu"),
              );
            } else if (state is MovieLoadedState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return MovieRow(
                    movie: state.movieList[index],
                  );
                },
                itemCount: state.movieList.length,
              );
            }
          }),
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
  void didUpdateWidget(MyAuthBody oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
