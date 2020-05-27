import 'package:flutter/material.dart';
import './view/widgets/Drawer/drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To-do manager",
      home: Scaffold(
        appBar: AppBar(
          title: Text('To-do manager'),
        ),
        drawer: NavDrawer(),
        body: Center(
          child: Text('Hello world'),
        ),
      ),
    );
  }
}

