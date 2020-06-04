import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './view/routes/home.dart';
import './view/routes/register.dart';
import './view/routes/login.dart';
import './view/routes/verify.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String defaultWidget;
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  if(user == null) { // Unauthorized
    defaultWidget = '/login';
  }
  else {
    defaultWidget = '/';
  }
  runApp(MyApp(
    defaultPage: defaultWidget
  ));
}

class MyApp extends StatelessWidget {
  final defaultPage;
  MyApp({this.defaultPage});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To-do manager",
      debugShowCheckedModeBanner: false,
      initialRoute: defaultPage,
      routes: {
        '/': (context) => Home(),
        '/register': (context) => Register(),
        '/login': (context) => Login(),
        '/verify': (context) => Verify()
      },
    );
  }
}
