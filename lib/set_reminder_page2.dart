import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class set_reminder_page2 extends StatefulWidget {
  @override
  _set_reminder_page2State createState() => _set_reminder_page2State();
}

class _set_reminder_page2State extends State<set_reminder_page2> {
  DateTime pickedDate;
  TimeOfDay time;
  @override
  void initState() {
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
  }

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
      body: Padding(
          padding: EdgeInsets.all(25.0),
          child: Center(
              child: Column(children: [
            Text('Set Remainder'),
            TextField(
              autocorrect: true,
              autofocus: false,
              cursorColor: Colors.lightBlue[400],
              decoration: InputDecoration(
                hintText: 'Event name',
              ),
            ),
// date and time picker here
            ListTile(
              title: Text(
                  'Date : ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}'),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: _pickDate,
            ),
            ListTile(
              title: Text('Time: ${time.hour} : ${time.minute}'),
              trailing: Icon(Icons.keyboard_arrow_down),
              onTap: _pickTime,
            ),
            TextField(
              autocorrect: true,
              autofocus: false,
              cursorColor: Colors.lightBlue[400],
              decoration: InputDecoration(
                hintText: 'Any Note...',
              ),
            ),
            Divider(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Done'),
            ),
          ]))),
    );
  }

  void _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 3),
    );
    if (date != null)
      setState(() {
        pickedDate = date;
      });
  }

  void _pickTime() async {
    TimeOfDay t = await showTimePicker(context: context, initialTime: time);
    if (t != null) {
      setState(() {
        time = t;
      });
    }
  }
}
