import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'users.dart';

class UserList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new UserListState();
  }
}

class UserListState extends State<UserList> {
  //List<User> listUsers = List();
  //User usr;
  DatabaseReference dbref;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //usr = new User("", "", "", "", "");
    dbref = database.reference().child("users");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blue,
      ),
      body: new Column(
        children: <Widget>[
          new Flexible(
              child: new FirebaseAnimatedList(
            query: dbref,
            itemBuilder: (_, DataSnapshot snapshot, Animation<double> animation,
                int index) {
              return new Card(
                child: new ListTile(
                  leading: new CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: new Icon(Icons.person),
                  ),
                  title: Text(snapshot.value["Prenom"].toString()),
                  subtitle: Text(snapshot.value["Nom"].toString()),
                ),
              );
            },
          ))
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserPage()),
          );
        },
        child: new Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
