import 'package:flutter/material.dart';
import '../models/moniteur.dart';
import 'package:firebase_database/firebase_database.dart';

class PostePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PostePageState();
  }
}

class PostePageState extends State<PostePage> {
  List<Moniteur> listPostes = List();
  Moniteur mnt;

  DatabaseReference dbref;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mnt = new Moniteur("", "En Marche", "", "");
    dbref = database.reference().child("Moniteurs");
    dbref.onChildAdded.listen(_entryAdded);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(),
      body: new Column(
        children: <Widget>[
          Flexible(
            flex: 0,
            child: Form(
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  new ListTile(
                    leading: new Icon(Icons.web),
                    title: TextFormField(
                      initialValue: "",
                      onSaved: (val) => mnt.ip = val,
                      validator: (val) => val == "" ? val : null,
                      decoration: new InputDecoration(
                          hintText: " 0000.0000.0000.0000",
                          labelText: "Veuillez saisir l'adresse IP  "),
                    ),
                  ),
                  new ListTile(
                    leading: new Icon(Icons.location_on),
                    title: TextFormField(
                      initialValue: "",
                      onSaved: (val) => mnt.emp = val,
                      validator: (val) => val == "" ? val : null,
                      decoration: new InputDecoration(
                          hintText: "Comptoire",
                          labelText: " Veuillez saisir l'emplacement "),
                    ),
                  ),
                  new ListTile(
                    leading: new Icon(Icons.computer),
                    title: TextFormField(
                      initialValue: "",
                      onSaved: (val) => mnt.ref = val,
                      validator: (val) => val == "" ? val : null,
                      decoration: new InputDecoration(
                          hintText: "M15",
                          labelText: "Veuillez saisir la Reference  "),
                    ),
                  ),
                  new FlatButton(
                    onPressed: () {
                      _ajouterUtil();
                    },
                    child: new Text(
                      "Ajouter ",
                      style: new TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                    color: Colors.blueAccent,
                  )
                ],
              ),
              key: formKey,
            ),
          )
        ],
      ),
    );
  }

  void _entryAdded(Event event) {
    setState(() {
      listPostes.add(Moniteur.fromSnapshot(event.snapshot));
    });
  }

  void _ajouterUtil() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();
      // Save to DataBase
      dbref.push().set(mnt.toJson());
    }
  }
}
