import 'package:firebase_database/firebase_database.dart';

class Planner {
  String _id;
  String _date;
  String _description;

  Planner(this._id, this._date, this._description);

  Planner.map(dynamic obj) {
    this._id = obj['id'];
    this._date = obj['date'];
    this._description = obj['description'];
  }

  String get id => _id;
  String get date => _date;
  String get description => _description;

  Planner.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _date = snapshot.value['date'];
    _description = snapshot.value['description'];
  }
}
