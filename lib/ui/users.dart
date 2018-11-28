import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:firebase_database/firebase_database.dart';

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserPageState();
  }
}

class UserPageState extends State<UserPage> {
  List _types = ["Technicien", "Administrateur", "Employer"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  List<User> listUsers = List();
  User usr;
  String _post;
  DatabaseReference dbref;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usr = new User("", "", "", "", "");
    dbref = database.reference().child("users");
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
                    leading: new Icon(Icons.person_outline),
                    title: TextFormField(
                      initialValue: "",
                      onSaved: (val) => usr.nom = val,
                      validator: (val) => val == "" ? val : null,
                      decoration: new InputDecoration(
                          hintText: " Name",
                          labelText: "Veuillez saisir le nom "),
                    ),
                  ),
                  new ListTile(
                    leading: new Icon(Icons.person_outline),
                    title: TextFormField(
                      initialValue: "",
                      onSaved: (val) => usr.prenom = val,
                      validator: (val) => val == "" ? val : null,
                      decoration: new InputDecoration(
                          hintText: "First Name",
                          labelText: " Veuillez saisir le prenom "),
                    ),
                  ),
                  new ListTile(
                    leading: new Icon(Icons.email),
                    title: TextFormField(
                      initialValue: "",
                      onSaved: (val) => usr.email = val,
                      validator: (val) => val == "" ? val : null,
                      decoration: new InputDecoration(
                          hintText: "Email",
                          labelText: "Veuillez saisir l'email "),
                    ),
                  ),
                  new ListTile(
                    leading: new Icon(Icons.lock),
                    title: TextFormField(
                      initialValue: "",
                      onSaved: (val) => usr.password = val,
                      validator: (val) => val == "" ? val : null,
                      decoration: new InputDecoration(
                          hintText: "password",
                          labelText: "Veuillez saisir le mot de passe "),
                    ),
                  ),
                  new ListTile(
                      leading: new Icon(Icons.settings),
                      title: new DropdownButton(
                        items: _dropDownMenuItems,
                        onChanged: changedDropDownItem,
                        value: _post,
                      )),
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

  void changedDropDownItem(String selectedPost) {
    setState(() {
      _post = selectedPost;
    });
  }

  void _entryAdded(Event event) {
    setState(() {
      listUsers.add(User.fromSnapshot(event.snapshot));
    });
  }

  void _ajouterUtil() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();
      // Save to DataBase
      dbref.push().set(usr.toJson());
    }
  }
}
