import 'package:flutter/material.dart';
import '../../view/widgets/inputDecoration/textInputDecoration.dart';
import '../../view/widgets/loadingIndicator/loadingIndicator.dart';
import '../../controller/auth.dart';


class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); // Unique Form Key

  bool loading = false;

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-do manager'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
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
                      // dynamic result = await _auth.registerWithEmailAndPass(email, password, username);
                      // print(result);
                      // if(result == null) {
                      //   setState(() {
                      //     loading = false;
                      //     error = 'Please supply a valid email';
                      //   });
                      // }
                    }
                  }
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}