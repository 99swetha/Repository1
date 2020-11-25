import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';


final FirebaseAuth mAuth = FirebaseAuth.instance;

class login extends StatefulWidget{
@override
_loginState createState()=>_loginState();
}

class _loginState extends State<login>{
final _formKey= GlobalKey<FormState>();

TextEditingController emailController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();



@override
Widget build(BuildContext context){
return Scaffold(
    appBar: AppBar( // multiple properties separated by ,
      title:Text('Login',
      style:TextStyle(color:Colors.black )
      ),
      actions:<Widget>[
        FlatButton.icon(onPressed:(){
        Navigator.pushNamed(context,'/signup');
        }
        , icon:Icon(Icons.people), label:Text('Register')),
      ],
      backgroundColor: Colors.lightBlue[200],
      centerTitle:true,
      
    ),
    // actions used for multiple widgets
    body:Center(
      child: Padding(
      padding: EdgeInsets.all(25),
      child: Form(
        key:_formKey,
        child: Column(
        children:<Widget>[
        TextFormField(
          controller: emailController,
          validator:(val)=>val.isEmpty?'Enter Email' :null,
          autocorrect: true,
            autofocus: false,
            cursorColor: Colors.blue,
            decoration: new InputDecoration(
              hintText: 'Email Address',
              icon: new Icon(
                Icons.people,
              )
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged:(val){
              
            },
            
        ),
        SizedBox(height:10.0),
        TextFormField(
          controller: passwordController,
          validator:(val)=>val.length < 6 ?'Enter Password: Length greater than 6' :null,
          autocorrect:true,
            autofocus: false,
            cursorColor: Colors.blue,
            decoration: new InputDecoration(
              hintText: 'Password',
              icon: new Icon(
                Icons.mail,
              )
              ),
            obscureText: true,
            onChanged:(val){
             // password=val;
            },
            
        ),
        SizedBox(height:10.0),
        RaisedButton(onPressed:(){
          if(_formKey.currentState.validate()){ 
          signInWithEmailPassword();
          }
          
        },
        child: Text('Login'),
        color: Colors.blueAccent[400],
        )
        ]
      )
      ),
    )

  ),
 );
}
void signInWithEmailPassword()
async {
  UserCredential user;
  try {
  user = await mAuth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
  Navigator.pushNamed(context,'/page1_menu');
  }catch(e){
  switch(e.errorCode){
    case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
         print("Email already used. Go to login page.");
        break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        print("Wrong email/password combination.");
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return print("No user found with this email.");
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return print("User disabled.");
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return print("Too many requests to log into this account.");
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return print("Server error, please try again later.");
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return print("Email address is invalid.");
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return print("No account found with this email");
        break;
      default:
        return print("Login failed. Please try again.");
        break;
  }
  }
  finally
  {
    if(user != null){
      print('User signed in'); 
    } 
  }

}
}