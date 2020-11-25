import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:students_companion_demo/note_screen.dart';
//import 'package:firebaseapp/model/planner.dart';
import 'planner_screen.dart';
import 'planner.dart';

class ListViewPlanner extends StatefulWidget {
  @override
  _ListViewPlannerState createState() => new _ListViewPlannerState();
}

final plannerReference = FirebaseDatabase.instance.reference().child('planner');

class _ListViewPlannerState extends State<ListViewPlanner> {
  List<Planner> items;
  StreamSubscription<Event> _onPlannerAddedSubscription;
  StreamSubscription<Event> _onPlannerChangedSubscription;

  @override
  void initState() {
    super.initState();

    items = new List();

    _onPlannerAddedSubscription =
        plannerReference.onChildAdded.listen(_onPlannerAdded);
    _onPlannerChangedSubscription =
        plannerReference.onChildAdded.listen(_onPlannerUpdated);
  }

  @override
  void dispose() {
    _onPlannerAddedSubscription.cancel();
    _onPlannerChangedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date of Scheduled Day',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(
            'Schedule Planner',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.lightBlue[200],
          actions: [
            IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
        drawer: Drawer(
            child: ListView(children: <Widget>[
          DrawerHeader(
            child: UserAccountsDrawerHeader(
              accountName: Text('Name', style: TextStyle(color: Colors.black)),
              accountEmail:
                  Text('Email', style: TextStyle(color: Colors.black)),
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
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(height: 5.0),
                    ListTile(
                      title: Text(
                        '${items[position].date}',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        '${items[position].description}',
                        style: new TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      leading: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            height: 35.0,
                            child: CircleAvatar(
                              backgroundColor: Colors.lightBlue[400],
                              radius: 15.0,
                              child: Text(
                                '${position + 1}',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 20.0,
                            child: RaisedButton(
                              child: Text('Delete Note'),
                              onPressed: () {
                                _deletePlanner(
                                    context, items[position], position);
                              },
                              color: Colors.lightBlue[200],
                            ),
                          )
                        ],
                      ),
                      onTap: () => _navigateToPlanner(context, items[position]),
                    )
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewPlanner(context),
          backgroundColor: Colors.lightBlue[400],
        ),
      ),
    );
  }

  void _onPlannerAdded(Event event) {
    setState(() {
      items.add(new Planner.fromSnapshot(event.snapshot));
    });
  }

  void _onPlannerUpdated(Event event) {
    var oldPlannerValue =
        items.singleWhere((planner) => planner.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldPlannerValue)] =
          new Planner.fromSnapshot(event.snapshot);
    });
  }

  void _navigateToPlanner(BuildContext context, Planner planner) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlannerScreen(planner)),
    );
  }

  void _createNewPlanner(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PlannerScreen(Planner(null, '', ''))),
    );
  }

  void _deletePlanner(
      BuildContext context, Planner planner, int position) async {
    await plannerReference.child(planner.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
      });
    });
  }
}
