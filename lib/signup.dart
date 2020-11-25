import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

final FirebaseAuth mAuth = FirebaseAuth.instance;

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // multiple properties separated by ,
        title: Text('Sign Up', style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              icon: Icon(Icons.people),
              label: Text('Login')),
        ],
        backgroundColor: Colors.lightBlue[200],
        centerTitle: true,
      ),
      // actions used for multiple widgets
      body: Center(
          child: Padding(
              padding: EdgeInsets.all(25),
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  TextFormField(
                    controller: emailController,
                    validator: (val) => val.isEmpty ? 'Enter Email' : null,
                    autocorrect: true,
                    autofocus: false,
                    cursorColor: Colors.blue,
                    decoration: new InputDecoration(
                        hintText: 'Email Address',
                        icon: new Icon(
                          Icons.people,
                        )),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: passwordController,
                    validator: (val) => val.length < 6
                        ? 'Enter Password: Length greater than 6'
                        : null,
                    autocorrect: true,
                    autofocus: false,
                    cursorColor: Colors.blue,
                    decoration: new InputDecoration(
                        hintText: 'Password',
                        icon: new Icon(
                          Icons.mail,
                        )),
                    obscureText: true,
                    onChanged: (val) {},
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        signUpWithEmailPassword();
                      }
                    },
                    child: Text('Sign up'),
                    color: Colors.blueAccent[400],
                  )
                ]),
              ))),
    );
  }

  void signUpWithEmailPassword() async {
    UserCredential user;
    try {
      user = await mAuth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.pushNamed(context, '/page1_menu');
    } catch (e) {
      print(e.toString());
    }
  }
}
