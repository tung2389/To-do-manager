import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './view/routes/home.dart';
import './view/routes/register.dart';
import './view/routes/login.dart';
import './view/routes/verify.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String defaultWidget;
  if(prefs.getString('uid') == '') {
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
