// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  bool status;
  String token;
  UserClass user;

  User({
    this.status,
    this.token,
    this.user,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
    status: json["status"],
    token: json["token"],
    user: UserClass.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "token": token,
    "user": user.toJson(),
  };
}

class UserClass {
  String id;
  String username;
  String password;
  int v;

  UserClass({
    this.id,
    this.username,
    this.password,
    this.v,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) => new UserClass(
    id: json["_id"],
    username: json["username"],
    password: json["password"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "password": password,
    "__v": v,
  };
}
