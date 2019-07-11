import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_app/Blocs/Movie/AddMovie/bloc.dart';
import 'package:flutter_login_app/Blocs/Movie/AllMovie/bloc.dart';
import 'package:flutter_login_app/Blocs/Movie/AllMovie/movie_bloc.dart';
import 'package:flutter_login_app/Blocs/Sign_In/sign_in_bloc.dart';
import 'package:flutter_login_app/Models/User/Movie.dart';

class MovieAdd extends StatefulWidget {
  @override
  MovieAddState createState() => new MovieAddState();
}

class MovieAddState extends State<MovieAdd> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var addMovieBloc = BlocProvider.of<AddmovieBloc>(context);
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('Add Movie'),
      ),
      body: BlocBuilder(
          bloc: addMovieBloc,
          builder: (context, state) {
            if (state is InitialAddmovieState) {
              return MyContainer();
            } else if (state is AddMovieLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AddMovieAddedState) {
              return MyContainer(
                  state: "added", function: showInSnackBar, movie: state.movie);
            } else if (state is AddMovieErrorState) {
              return Center(child: Text("hata"));
            } else if (state is AddMovieNotBeAdded) {
              return Center(
                child: Text("Eklenemedi"),
              );
            }
          }),
    );
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }
}

class MyContainer extends StatefulWidget {
  String state;
  Function function;
  Movie movie;

  MyContainer({this.state, this.function, this.movie});

  @override
  _MyContainerState createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {
  var controllerTitle = TextEditingController();
  var controllerCategory = TextEditingController();
  var controllerCountry = TextEditingController();
  var controllerYear = TextEditingController();
  var controllerimdb = TextEditingController();
  var controllerDirector = TextEditingController();



  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var addMovieBloc = BlocProvider.of<AddmovieBloc>(context);
      var movieBloc = BlocProvider.of<MovieBloc>(context);
      if (widget.state == null) {
        debugPrint("initial add movie page");
      } else if (widget.state == "added") {
        debugPrint("added..");
        widget.function("Film başarıyla eklendi");
        debugPrint("added movie");
        addMovieBloc.dispatch(AddMovieInitialPage());
        movieBloc.dispatch(AddMovie(widget.movie));

      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var signinBloc = BlocProvider.of<SignInBloc>(context);
    var addMovieBloc = BlocProvider.of<AddmovieBloc>(context);

    return Container(
      child: SingleChildScrollView(
        child: Form(
            autovalidate: true,
            child: Column(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      controller: controllerTitle,
                      decoration: InputDecoration(
                          labelText: "Title",
                          border: OutlineInputBorder(),
                          helperText: "Bu alan boş geçilemez."),
                      validator: (title) {
                        if (title.length < 2) {
                          return "Title 2 karakterden fazla olmalıdır.";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      controller: controllerCategory,
                      decoration: InputDecoration(
                        labelText: "Category",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      controller: controllerCountry,
                      decoration: InputDecoration(
                        labelText: "Country",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      controller: controllerYear,
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        labelText: "Year",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      controller: controllerimdb,
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        labelText: "Imdb Score",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: TextFormField(
                      controller: controllerDirector,
                      decoration: InputDecoration(
                        labelText: "Director",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    height: 50,
                    width: 200,
                    child: RaisedButton(
                      onPressed: () {
                        if (controllerTitle.text.length >= 2) {
                          debugPrint("add movie click");
                          Movie addMovie = new Movie();
                          //addMovie.year = controllerYear.text as int;
                          addMovie.title = controllerTitle.text;
                          debugPrint("my title" + addMovie.title);
                          //addMovie.imdbScore = controllerCategory.text as int;
                          addMovie.category = controllerCategory.text;
                          addMovie.country = controllerCountry.text;
                          addMovie.author = signinBloc.user.user.username;
                          addMovieBloc.dispatch(AddMovieEvent(movie: addMovie));
                        }
                      },
                      child: Text(
                        "Kaydet",
                        style: TextStyle(fontSize: 24),
                      ),
                      color: Colors.green,
                      elevation: 16,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
