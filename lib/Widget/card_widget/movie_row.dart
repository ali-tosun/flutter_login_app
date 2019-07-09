import 'package:flutter/material.dart';
import 'package:flutter_login_app/Models/User/Movie.dart';

class CardSimple extends StatefulWidget {
  @override
  CardSimpleState createState() => new CardSimpleState();
}

class CardSimpleState extends State<CardSimple> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MovieRow(),
            MovieRow(),
            MovieRow(),
          ],
        ),
      ),
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
  void didUpdateWidget(CardSimple oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

class MovieRow extends StatelessWidget {
  Movie movie;

  MovieRow({this.movie});

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: Stack(
        children: <Widget>[
        MovieCardItem(movie: movie,),
        MovieImageItem(movie: movie,),
        ],
      ),
    );
  }
}

class MovieImageItem extends StatelessWidget {
  Movie movie;

  MovieImageItem({this.movie});

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: new Image(
        image: new AssetImage("assets/img/film.png"),
        height: 130.0,
        width: 130.0,
      ),
    );
  }
}

class MovieCardItem extends StatelessWidget {
  Movie movie;

  MovieCardItem({this.movie});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 124.0,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.15),
        padding: EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: <Widget>[
            Text(
              "${movie.title ?? "The Matrix"}",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircleAvatar(
                  child: Text("${movie.imdbScore ?? "7.5"}"),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "${movie.category ?? "Dram"}",
                  style: TextStyle(color: Colors.red, fontSize: 20),
                )
              ],
            ),
            Text(
              "${movie.year ?? "1999"}",
              style: TextStyle(color: Colors.green, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}

/*
final planetCard = new Container(
  height: 124.0,
  margin: new EdgeInsets.only(left: 46.0),
  decoration: new BoxDecoration(
    color: new Color(0xFF333366),
    shape: BoxShape.rectangle,
    borderRadius: new BorderRadius.circular(8.0),
    boxShadow: <BoxShadow>[
      new BoxShadow(
        color: Colors.black12,
        blurRadius: 10.0,
        offset: new Offset(0.0, 10.0),
      ),
    ],
  ),
);
*/
