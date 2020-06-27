import 'package:shared_preferences/shared_preferences.dart';

Future<String> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString('uid');
  return uid;
}