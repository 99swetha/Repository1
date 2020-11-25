import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'planner.dart';

class PlannerScreen extends StatefulWidget {
  final Planner planner;
  PlannerScreen(this.planner);

  @override
  State<StatefulWidget> createState() => new _PlannerScreenState();
}

final plannerReference = FirebaseDatabase.instance.reference().child('planner');

class _PlannerScreenState extends State<PlannerScreen> {
  TextEditingController _dateController;
  TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();

    _dateController = new TextEditingController(text: widget.planner.date);
    _descriptionController =
        new TextEditingController(text: widget.planner.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Schdeule Planner',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.lightBlue[200],
      ),
      body: Container(
          margin: EdgeInsets.all(15.0),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              TextField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Time'),
              ),
              Padding(padding: new EdgeInsets.all(5.0)),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Task here'),
              ),
              Padding(padding: new EdgeInsets.all(5.0)),
              RaisedButton(
                child:
                    (widget.planner.id != null) ? Text('Update') : Text('Add'),
                onPressed: () {
                  if (widget.planner.id != null) {
                    plannerReference.child(widget.planner.id).set({
                      'date': _dateController.text,
                      'description': _descriptionController.text
                    }).then((_) {
                      Navigator.pop(context);
                    });
                  } else {
                    plannerReference.push().set({
                      'date': _dateController.text,
                      'description': _descriptionController.text
                    }).then((_) {
                      Navigator.pop(context);
                    });
                  }
                },
                color: Colors.lightBlue[200],
              )
            ],
          )),
    );
  }
}
