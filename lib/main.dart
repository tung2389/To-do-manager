import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_manager/model/user.dart';
import './view/routes/home.dart';
import './view/routes/register.dart';
import './view/routes/login.dart';
import './view/routes/verify.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<User>(
      create: (context) => User(
        uid: '',
        name: 'test case'
      ),
      child: MaterialApp(
        title: "To-do manager",
        // home: Home(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/': (context) => Home(),
          '/register': (context) => Register(),
          '/login': (context) => Login(),
          '/verify': (context) => Verify()
        },
      ),
    );
  }
}

