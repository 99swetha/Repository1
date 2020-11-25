import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'note.dart';

class NoteScreen extends StatefulWidget {
  final Note note;
  NoteScreen(this.note);

  @override
  State<StatefulWidget> createState() => _NoteScreenState();
}

final notesReference = FirebaseDatabase.instance.reference().child('notes');

class _NoteScreenState extends State<NoteScreen> {
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  @override
  void initState() {
    super.initState();
    _titleController = new TextEditingController(text: widget.note.title);
    _descriptionController =
        new TextEditingController(text: widget.note.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Note',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.lightBlue[200],
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: ListView(children: <Widget>[
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          Padding(padding: EdgeInsets.all(5.0)),
          TextField(
            controller: _descriptionController,
            maxLines: 25,
            decoration: InputDecoration(
              labelText: 'Description',
              border: null,
            ),
          ),
          Padding(padding: EdgeInsets.all(5.0)),
          RaisedButton(
            child: (widget.note.id != null) ? Text('Update') : Text('Add'),
            onPressed: () {
              if (widget.note.id != null) {
                notesReference.child(widget.note.id).set({
                  'title': _titleController.text,
                  'description': _descriptionController.text
                }).then((_) {
                  Navigator.pop(context);
                });
              } else {
                notesReference.push().set({
                  'title': _titleController.text,
                  'description': _descriptionController.text
                }).then((_) {
                  Navigator.pop(context);
                });
              }
            },
            color: Colors.lightBlue[200],
          )
        ]),
      ),
    );
  }
}
