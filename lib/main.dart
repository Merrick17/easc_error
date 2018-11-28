import 'package:flutter/material.dart';
import './ui/login.dart';
import './ui/home.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Easc Fail Detector ',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: new Login(),
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => new Home(),
      '/login': (BuildContext context) => new Login(),
    },
  ));
}
