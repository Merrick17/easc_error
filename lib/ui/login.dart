import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseDatabase database = FirebaseDatabase.instance;

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final _emailcontroller = new TextEditingController();
  final _pswcontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Stack(
          children: <Widget>[
            new Center(
              child: new Image.asset(
                'images/background.png',
                fit: BoxFit.fill,
                width: 1200.0,
              ),
            ),
            new Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 50.0),
              child: new Image.asset('images/logo.png'),
            ),
            new Container(
              padding: const EdgeInsets.only(top: 130.0),
              child: new ListView(
                children: <Widget>[
                  new ListTile(
                    title: new TextField(
                      controller: _emailcontroller,
                      decoration: new InputDecoration(
                          icon: new Icon(Icons.person_outline),
                          hintText: "Email",
                          labelText: 'Enter your Email',
                          hintStyle: new TextStyle(color: Colors.white)),
                    ),
                  ),
                  new ListTile(
                    title: new TextField(
                      obscureText: true,
                      controller: _pswcontroller,
                      decoration: new InputDecoration(
                          icon: new Icon(Icons.person_outline),
                          labelText: 'Enter your password',
                          hintText: "password",
                          hintStyle: new TextStyle(color: Colors.white)),
                    ),
                  ),
                  new ListTile(
                    title: new RaisedButton(
                      onPressed: () {
                        _LoginPage();
                      },
                      color: Colors.blue,
                      child: new Text(
                        "Login",
                        style: new TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _LoginPage() {
    Navigator.of(context).pushReplacementNamed('/home');
  }
}
