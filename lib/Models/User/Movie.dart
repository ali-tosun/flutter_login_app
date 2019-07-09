// To parse this JSON data, do
//
//     final movie = movieFromJson(jsonString);

import 'dart:convert';

List<Movie> movieFromJson(String str) => new List<Movie>.from(json.decode(str).map((x) => Movie.fromJson(x)));

String movieToJson(List<Movie> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Movie {
  String id;
  String title;
  String category;
  String country;
  int year;
  int imdbScore;
  String directorId;
  String author;
  DateTime date;
  int v;

  Movie({
    this.id,
    this.title,
    this.category,
    this.country,
    this.year,
    this.imdbScore,
    this.directorId,
    this.author,
    this.date,
    this.v,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => new Movie(
    id: json["_id"],
    title: json["title"],
    category: json["category"],
    country: json["country"],
    year: json["year"],
    imdbScore: json["imdb_score"],
    directorId: json["director_id"],
    author: json["author"],
    date: DateTime.parse(json["date"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "category": category,
    "country": country,
    "year": year,
    "imdb_score": imdbScore,
    "director_id": directorId,
    "author": author,
    "date": date.toIso8601String(),
    "__v": v,
  };
}