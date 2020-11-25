import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'set_reminder_page2.dart';

class set_reminder_page1 extends StatefulWidget {
  @override
  _set_reminder_page1State createState() => _set_reminder_page1State();
}

class _set_reminder_page1State extends State<set_reminder_page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // multiple properties separated by ,
        title: Text('Set Reminder',
            style: TextStyle(
              color: Colors.black,
            )),
        backgroundColor: Colors.lightBlue[200],
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
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
        ListTile(
          onTap: () {},
          leading: Icon(Icons.info, color: Colors.lightBlue[200]),
          //hoverColor: Colors.lightBlue[200],
          title: Text('About Us'),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(Icons.help, color: Colors.lightBlue[200]),
          //hoverColor: Colors.lightBlue[200],
          title: Text('Help'),
        ),
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/set_reminder_page2');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
