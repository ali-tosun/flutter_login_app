import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_app/Blocs/Profile/bloc.dart';
import 'package:flutter_login_app/Blocs/Sign_In/sign_in_bloc.dart';

import 'add_movie_page.dart';
import 'card_widget/movie_row.dart';
class Profile extends StatefulWidget {
  @override
  ProfileState createState() => new ProfileState();
}

class ProfileState extends State<Profile> {
  bool firstLoading = true;

  @override
  Widget build(BuildContext context) {
    var profileBloc = BlocProvider.of<ProfileBloc>(context);
    return new Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MovieAdd()));
      },child: Icon(Icons.add),),
      body: Container(
        child: BlocBuilder(
            bloc: profileBloc,
            builder: (context, state) {
              if (state is InitialProfileState) {
                return Center(child: Text("Filmler yüklenilcek.."));
              } else if (state is LoadingProfileState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ErrorProfileState) {
                return Center(
                  child: Text("Filmler yüklenirken bir problem oluştu"),
                );
              } else if (state is LoadedProfileState) {
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
      ),
      appBar: AppBar(
        title: Text("Profile Page"),
      ),
    );
  }
  @override
  void initState() {
    super.initState();

    var profileBloc = BlocProvider.of<ProfileBloc>(context);
    if(!profileBloc.isLoadingData){
      var signInBloc = BlocProvider.of<SignInBloc>(context);
      profileBloc.dispatch(FetchUserMovieList(username: signInBloc.user.user.username));
    }
    debugPrint("profile init state");

    // TODO: implement initState

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(Profile oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

}