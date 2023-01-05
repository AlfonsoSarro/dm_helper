import 'package:firebase_auth/firebase_auth.dart';

class AuthManager {
  static const int err = -1;
  static const int ok = 0;
  static const int errNoExist = 1;
  static const int errWrongPass = 2;
  static const int errPassMissMatch = 3;
  static const int errWeakPass = 4;
  static const int errEmailExist = 5;
  static const int errFieldEmpty = 6;


  static Future<int> login(String? email, String? pass) async{
    if (email == null || pass == null) {
      return errFieldEmpty;
    }
    if (email == "" || pass == "") {
      return errFieldEmpty;
    }
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: pass
      );
      return ok;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return errNoExist;
      } else if (e.code == 'wrong-password') {
        return errWrongPass;
      }
    }
    return err;
  }

  static Future<int> register (String? usr, String? email, String? pass, String? confPass) async{
    if (usr == null || email == null || pass == null || confPass == null) {
      return errFieldEmpty;
    }
    if (usr == "" || email == "" || pass == "" || confPass == "") {
      return errFieldEmpty;
    }
    if (pass != confPass) {
      return errPassMissMatch;
    }
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      await credential.user?.updateDisplayName(usr);
      return ok;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return errWeakPass;
      } else if (e.code == 'email-already-in-use') {
        return errEmailExist;
      }
    } catch (e) {
      print(e);
      return err;
    }
    return err;
  }
}