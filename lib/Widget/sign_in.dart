import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_app/Blocs/Sign_In/sign_in_bloc.dart';
import 'package:flutter_login_app/Blocs/Sign_In/sign_in_event.dart';
import 'package:flutter_login_app/Blocs/Sign_In/sign_in_state.dart';

import 'register_page.dart';

class SignInWidget extends StatefulWidget {
  String username, password;

  SignInWidget();

  SignInWidget.name(this.username, this.password);

  @override
  SignInWidgetState createState() => new SignInWidgetState();
}

class SignInWidgetState extends State<SignInWidget> {
  var formKey = GlobalKey<FormState>();
  var userNameTextController = TextEditingController();
  var userPasswordTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.password != null && widget.username != null) {
      userPasswordTextController.text = widget.password;
      userNameTextController.text = widget.username;
    }
  }

  @override
  Widget build(BuildContext context) {
    final signInBloc = BlocProvider.of<SignInBloc>(context);

    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: Form(
        autovalidate: true,
        key: formKey,
        child: Column(
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  controller: userNameTextController,
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
            Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                    controller: userPasswordTextController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Password", border: OutlineInputBorder()),
                    validator: (password) {
                      if (password.length < 3) {
                        return "Parolanız 3 karakterden büyük olmak zorundadır.";
                      }
                      return null;
                    }),
              ),
            ),
            Center(
              child: RaisedButton(
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    BlocProvider.of<SignInBloc>(context).dispatch(SignIn(
                        userName: userNameTextController.text,
                        password: userPasswordTextController.text));
                  }
                },
                child: Text("Giriş Yap"),
                color:
                    widget.username == null ? Colors.green : Colors.redAccent,
              ),
            ),
            Center(
              child: Text(
                widget.username == null
                    ? ""
                    : "Yanlış Parola veya Kullanıcı Adı girdiniz",
                style: TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.42,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [Colors.red, Colors.blue],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.5, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Kayıt Olmak İçin Tıklayınız",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
