import 'package:flutter/material.dart';
import './usersList.dart';
import './pannesList.dart';
import './historyList.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
        title: new Text(
          "Home",
          style:
              new TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: new Container(
        margin: const EdgeInsets.only(left: 90.0, top: 100.0),
        alignment: Alignment.center,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
                child: new Row(
              children: <Widget>[
                new Center(
                  child: Ink.image(
                    image: AssetImage('images/1.png'),
                    fit: BoxFit.cover,
                    width: 100.0,
                    height: 100.0,
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PanneList()),
                          );
                        },
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(55.0),
                          ),
                        )),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.all(15.0),
                  child: Ink.image(
                    image: AssetImage('images/2.png'),
                    fit: BoxFit.cover,
                    width: 100.0,
                    height: 100.0,
                    child: InkWell(
                        onTap: () {/* ... */},
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(55.0),
                          ),
                        )),
                  ),
                )
              ],
            )),
            new Row(
              children: <Widget>[
                new Center(
                  child: Ink.image(
                    image: AssetImage('images/3.png'),
                    fit: BoxFit.cover,
                    width: 100.0,
                    height: 100.0,
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HistList()),
                          );
                        },
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(55.0),
                          ),
                        )),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.all(15.0),
                  child: Ink.image(
                    image: AssetImage('images/4.png'),
                    fit: BoxFit.cover,
                    width: 100.0,
                    height: 100.0,
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserList()),
                          );
                        },
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(55.0),
                          ),
                        )),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
