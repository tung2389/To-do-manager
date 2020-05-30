import 'package:flutter/material.dart';

class Verify extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-do manager'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have registered successfully. Please open your email and verify your account. After verifying, click login button to login to your account'),
            SizedBox(
              height: 20.0,
            ),
            ButtonTheme(
                minWidth: 100.0,
                height: 50.0,
                child: RaisedButton(
                  color: Colors.lightBlue,
                  child: Text(
                    'Go to Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => Navigator.pushReplacementNamed(context, '/login') 
              
                ),
              ),
          ]
        )
      ),
    );
  }
}