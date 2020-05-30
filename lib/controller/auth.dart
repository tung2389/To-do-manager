import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register with email and password
  Future registerWithEmailAndPass(String email, String password, String username) async {
    try{
      AuthResult res = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      FirebaseUser user = res.user;
      await user.sendEmailVerification();
      await UserService(uid: user.uid).createUser(username);
      return user;
    } catch(e) {
      return null;
    }
  }

  // Signin with email and password
  Future loginWithEmailAndPass(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser authUser = result.user;
      if(authUser.isEmailVerified) {
        dynamic user = await Firestore.instance.collection('user')
                                                    .document(authUser.uid)
                                                    .get();
        user.data['uid'] = authUser.uid;
        return user.data;
      }
      else {
        return null;
      }
    } catch (e) {
        return null;
    }
  }
}