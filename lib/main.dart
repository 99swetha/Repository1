import 'package:flutter/material.dart';
import 'package:students_companion_demo/set_reminder_page2.dart';
import 'login.dart';
import 'page1_menu.dart';
import 'frontpage.dart';
import 'signup.dart';
import 'set_reminder_page1.dart';
//import 'take_notes_page1.dart';
import 'ListViewNote.dart';
import 'listview_planner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // invokes
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MyApp()); // pass the object whose class we want to create, coz each widget has a class associated with it
}

// not writing separte class for stateless widget
class MyApp extends StatefulWidget {
  // specify the logic for state full widget
// define what that state will do
  _State createState() => new _State(); // overwriting, now set that _State

}

class _State extends State<MyApp> {
  // <> specify for which we are creating the state
// class to declare state of widget
// declare _State variable as private
  @override
  Widget build(BuildContext context) {
    // overwriting(build) the one available in State
    return new MaterialApp(
      debugShowCheckedModeBanner:
          false, // materialapp is imp for navigation between pages
      home: frontpage(),
      routes: {
        '/login': (_) => login(),
        '/signup': (_) => signup(),
        '/page1_menu': (_) => page1_menu(),
        '/set_reminder_page1': (_) => set_reminder_page1(),
        //'/take_notes_page1':(_)=>take_notes_page1(),
        '/ListViewNote': (_) => ListViewNote(),
        '/frontpage': (_) => frontpage(),
        '/ListViewPlanner': (_) => ListViewPlanner(),
        '/set_reminder_page2': (_) => set_reminder_page2(),
      },
    ); // ; for the end of the widget
  }
}
