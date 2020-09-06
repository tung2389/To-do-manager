import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../view/widgets/inputDecoration/textInputDecoration.dart';
import '../../view/widgets/loadingIndicator/loadingIndicator.dart';
import '../../controller/auth.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>(); // Unique Form Key

  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  SharedPreferences pref;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-do manager'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[

                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'email'),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20.0),

                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'password'),
                    obscureText: true,
                    validator: (val) => val.length < 8 ? 'Password must be at least 8 characters' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 20.0),

                  SizedBox(
                    width: 100.0,
                    height: 50.0,
                    child: RaisedButton(
                      color: Colors.lightBlue,
                      child: loading ? Loading() : Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          setState(() => loading = true);
                          Map user = await AuthService.loginWithEmailAndPass(
                            email, 
                            password
                          ).whenComplete(() {
                              setState(() => loading = false);
                          });
                          if(user == null) {
                            setState(() {
                              error = 'There is an error while logging in. Make sure that your account was created, your email and password are corrent, and you have verified your email address';
                            });
                          }
                          if(user != null) {
                            pref = await SharedPreferences.getInstance();
                            pref.setString('uid', user['uid']);
                            pref.setString('name', user['name']);
                            Navigator.pushReplacementNamed(context, '/');
                          }
                        }
                      }
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              )
            ),
            Text("Or"),
            SizedBox(height: 10),
            ButtonTheme(
              minWidth: 100.0,
              height: 50.0,
              child: RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Go to register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pushReplacementNamed(context, '/register') 
            
              ),
            ),
          ],
        ),
      ),
    );
  }
}