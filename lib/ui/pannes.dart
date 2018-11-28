import 'package:flutter/material.dart';
import '../models/panne.dart';
import 'package:firebase_database/firebase_database.dart';

class PannePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PannePageState();
  }
}

class PannePageState extends State<PannePage> {
  List _types = ["Alimentation", "Erreur Systeme", "Reseaux"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  List<Panne> listUsers = List();
  Panne pne;
  String _post;
  DatabaseReference dbref;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pne = new Panne(new DateTime.now().toString(), "", "", "", "");
    dbref = database.reference().child("Pannes");
    dbref.onChildAdded.listen(_entryAdded);
    _dropDownMenuItems = getDropDownMenuItems();
    _post = _dropDownMenuItems[0].value;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String t in _types) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(value: t, child: new Text(t)));
    }
    return items;
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
                    leading: new Icon(Icons.text_fields),
                    title: TextFormField(
                      initialValue: "",
                      onSaved: (val) => pne.desc = val,
                      validator: (val) => val == "" ? val : null,
                      decoration: new InputDecoration(
                          hintText: " Description",
                          labelText: "Decrivez la panne "),
                    ),
                  ),
                  new ListTile(
                    leading: new Icon(Icons.computer),
                    title: TextFormField(
                      initialValue: "",
                      onSaved: (val) => pne.ref = val,
                      validator: (val) => val == "" ? val : null,
                      decoration: new InputDecoration(
                          hintText: "First Name",
                          labelText: " Veuillez saisir la Reference de pc  "),
                    ),
                  ),
                  new ListTile(
                    leading: new Icon(Icons.error),
                    title: new DropdownButton(
                      items: _dropDownMenuItems,
                      onChanged: changedDropDownItem,
                      value: _post,
                    ),
                    subtitle: new Text("Type de panne "),
                  ),
                  new FlatButton(
                    onPressed: () {
                      _ajouterPanne();
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

  void changedDropDownItem(String selectedPost) {
    setState(() {
      _post = selectedPost;
    });
  }

  void _entryAdded(Event event) {
    setState(() {
      listUsers.add(Panne.fromSnapshot(event.snapshot));
    });
  }

  void _ajouterPanne() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();
      // Save to DataBase
      dbref.push().set(pne.toJson());
    }
  }
}
