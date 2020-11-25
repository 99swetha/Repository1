import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'note.dart';
import 'note_screen.dart';

class ListViewNote extends StatefulWidget {
  @override
  _ListViewNoteState createState() => new _ListViewNoteState();
}

class _ListViewNoteState extends State<ListViewNote> {
  List<Note> items;
  StreamSubscription<Event> _onNoteAddedSubscription;
  StreamSubscription<Event> _onNoteChangedSubscription;
  final notesReference = FirebaseDatabase.instance.reference().child('notes');

  @override
  void initState() {
    super.initState();
    items = new List();

    _onNoteAddedSubscription = notesReference.onChildAdded.listen(_onNoteAdded);
    _onNoteChangedSubscription =
        notesReference.onChildChanged.listen(_onNoteUpdated);
  }

  @override
  void dispose() {
    _onNoteAddedSubscription.cancel();
    _onNoteChangedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Take Notes',
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(
            'Take Notes',
            style: TextStyle(
              color: Colors.black,
            ),
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
                padding: EdgeInsets.all(15.0),
                itemBuilder: (context, position) {
                  return Column(children: <Widget>[
                    Divider(height: 5.0),
                    ListTile(
                      title: Text(
                        '${items[position].title}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        '${items[position].description}',
                        style: TextStyle(
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
                                  _deleteNote(
                                      context, items[position], position);
                                },
                                color: Colors.lightBlue[200],
                              ),
                            ),
                          ]),
                      onTap: () {
                        _navigateToNote(context, items[position]);
                      },
                    )
                  ]);
                })),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _createNewNote(context);
          },
        ),
      ),
    );
  }

  void _onNoteAdded(Event event) {
    setState(() {
      items.add(new Note.fromSnapshot(event.snapshot));
    });
  }

  void _onNoteUpdated(Event event) {
    var oldNoteValue =
        items.singleWhere((note) => note.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldNoteValue)] = Note.fromSnapshot(event.snapshot);
    });
  }

  void _deleteNote(BuildContext context, Note note, int position) async {
    await notesReference.child(note.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToNote(BuildContext context, Note note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(note)),
    );
  }

  void _createNewNote(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(Note(null, '', ''))),
    );
  }
}
