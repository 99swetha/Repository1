import 'package:flutter/material.dart';

class frontpage extends StatefulWidget {
  @override
  _frontpageState createState() => _frontpageState();
}

class _frontpageState extends State<frontpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // multiple properties separated by ,
        title: Text('Welcome ...', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.lightBlue[200],
        centerTitle: true,
      ),

      // actions used for multiple widgets
      body: Center(
          child: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  Divider(),
                  Text(
                    'User Credentials',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.lightBlue[400],
                    ),
                  ),
                  Divider(
                    height: 90,
                  ),
                  Row(
                    children: [
                      RaisedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text('Sign in'),
                        color: Colors.blueAccent,
                      ),
                      Spacer(),
                      RaisedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text('Login'),
                        color: Colors.blueAccent,
                      ),
                    ],
                  )
                ],
              ))),
    );
  }
}
