import 'package:flutter/material.dart';
import './view/routes/home.dart';
import './view/routes/register.dart';
import './view/routes/login.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To-do manager",
      // home: Home(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/': (context) => Home(),
        '/register': (context) => Register(),
        '/login': (context) => Login()
      },
    );
  }
}

