import 'package:shared_preferences/shared_preferences.dart';

class LocalData{
  static Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid');
    return uid;
  }

  static Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('name');
    return username;
  }
}