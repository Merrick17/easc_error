import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';

class HistList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HistListState();
  }
}

class HistListState extends State<HistList> {
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
    dbref = database.reference().child("Historique");
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
                child: new Column(
                  children: <Widget>[
                    Image.asset('images/check.png'),
                    new ListTile(
                      title: new Text("Reference: " +
                          snapshot.value["RefMoniteur"].toString()),
                      subtitle: new Text("Date Reparation: " +
                          snapshot.value["Date"].toString()),
                    ),
                    ButtonTheme.bar(
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text('Details'),
                            onPressed: () {/* ... */},
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
