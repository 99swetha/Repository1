// Just UI
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class page1_menu extends StatefulWidget {
  // This widget is the root of your application.
  _page1_menuState createState() => new _page1_menuState();
}

class _page1_menuState extends State<page1_menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // multiple properties separated by ,
        title: Text('Your Companion',
            style: TextStyle(
              color: Colors.black,
            )),
        backgroundColor: Colors.lightBlue[200],
        centerTitle: true,
      ),
      drawer: Drawer(
          child: ListView(children: <Widget>[
        DrawerHeader(
          child: UserAccountsDrawerHeader(
            accountName: Text('Name', style: TextStyle(color: Colors.black)),
            accountEmail: Text('Email', style: TextStyle(color: Colors.black)),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Colors.lightBlue[400],
                Colors.lightBlue[200]
              ]),
            ),
          ),
        ),
      ])),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue[400],
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 70.0,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/frontpage');
        },
        backgroundColor: Colors.lightBlue[400],
        label: Text('Exit'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
          child: Center(
              child: Padding(
                  padding: EdgeInsets.all(50.0),
                  child: Column(
                    children: [
                      RaisedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/ListViewPlanner');
                        },
                        child: Center(
                          child: Text(
                            "Schedule Planner",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        color: Colors.lightBlue[400],
                      ),
                      Divider(),
                      RaisedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/set_reminder_page1');
                        },
                        child: Center(
                          child: Text(
                            "Set Reminder",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        color: Colors.lightBlue[400],
                      ),
                      Divider(),
                      RaisedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/ListViewNote');
                        },
                        child: Center(
                          child: Text(
                            "Take Notes",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        color: Colors.lightBlue[400],
                      ),
                    ],
                  )))),
    );
  }
}
