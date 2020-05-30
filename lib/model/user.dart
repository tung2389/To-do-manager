

class User {
  String uid;
  String name;

  User({this.uid, this.name});

  void updateUser(String newuid, String newname) {
    uid = newuid;
    name = newname;
  }
}