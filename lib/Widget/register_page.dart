import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_app/Blocs/Register/bloc.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => new RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  var userNameTextController = TextEditingController();
  var userPasswordTextController = TextEditingController();
  var registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Register'),
      ),
      body: Container(
        child: BlocBuilder(
          bloc: BlocProvider.of<RegisterBloc>(context),
          builder: (context, state) {
            if (state is InitialRegisterState) {
              return new RegisterFormWidget(
                  registerFormKey: registerFormKey,
                  userNameTextController: userNameTextController,
                  userPasswordTextController: userPasswordTextController);
            } else if (state is SignUpLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SignUpErrorState) {
              return ListView(
                children: <Widget>[
                  RegisterFormWidget(
                      registerFormKey: registerFormKey,
                      userNameTextController: userNameTextController,
                      userPasswordTextController: userPasswordTextController),
                  Text("Hatalı işlem",style: TextStyle(color: Colors.red,fontSize: 30),)
                ],
              );
            } else if (state is SignUpSuccessfulState) {
              return ListView(
                children: <Widget>[
                  RegisterFormWidget(
                      registerFormKey: registerFormKey,
                      userNameTextController: userNameTextController,
                      userPasswordTextController: userPasswordTextController),
                  Text("İşlem Başarılı..",style: TextStyle(color: Colors.green,fontSize: 30),)
                ],
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<RegisterBloc>(context).dispatch(SignUpInitial());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(RegisterPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

class RegisterFormWidget extends StatelessWidget {
  const RegisterFormWidget({
    Key key,
    @required this.registerFormKey,
    @required this.userNameTextController,
    @required this.userPasswordTextController,
  }) : super(key: key);

  final GlobalKey<FormState> registerFormKey;
  final TextEditingController userNameTextController;
  final TextEditingController userPasswordTextController;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidate: true,
        child: Column(
      key: registerFormKey,
      children: <Widget>[
        Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
                controller: userNameTextController,
                decoration: InputDecoration(
                    labelText: "Username", border: OutlineInputBorder()),
                validator: (username) {
                  if (username.length < 3) {
                    return "Kullanıcı adınız 3 karakterden büyük olmak zorundadır.";
                  }
                  return null;
                }),
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
        RaisedButton(
          onPressed: () {
            BlocProvider.of<RegisterBloc>(context).dispatch(SignUp(
                userNameTextController.text, userPasswordTextController.text));
          },
          child: Text("Kayıt Ol"),
        )
      ],
    ));
  }
}
