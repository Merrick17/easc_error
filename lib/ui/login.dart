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
  DatabaseReference dbref;
  final FirebaseDatabase database = FirebaseDatabase.instance;

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
                        labelText: 'Veuillez saisir votre adresse email',
                      ),
                    ),
                  ),
                  new ListTile(
                    title: new TextField(
                      obscureText: true,
                      controller: _pswcontroller,
                      decoration: new InputDecoration(
                        icon: new Icon(Icons.person_outline),
                        labelText: 'Veuillez saisir votre mot de passe ',
                      ),
                    ),
                  ),
                  new ListTile(
                    title: new MaterialButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(40.0)),
                      onPressed: () {
                        _loginPage();
                      },
                      color: Colors.blue[900],
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

  _loginPage() async {
    bool verif = false;
    List userList = new List();
    DataSnapshot response = await database
        .reference()
        .child('users')
        .once()
        .then((DataSnapshot snapshot) {
      for (var value in snapshot.value.values) {
        userList.add(value);
      }
      for (var us in userList) {
        if (us['Email'] == _emailcontroller.text.toString().trim() &&
            us['Password'] == _pswcontroller.text.toString().trim()) {
          verif = true;
          break;
        }
      }
    });
    if (verif) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Erreur d'authentification"),
            content: new Text("Email ou mot de passe incorrecte "),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
