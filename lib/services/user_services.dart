import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class UserServices with ChangeNotifier {
  bool smsScreen = false;
  String varId = '';
  String phoneNum = '';
  Future registerUser(String email, String password, String name) async {
    try {
      final creds =
          EmailAuthProvider.credential(email: email, password: password);

      FirebaseAuth auth = FirebaseAuth.instance;

      final User user = auth.currentUser;

      await user.linkWithCredential(creds);

      // save name in FireBase
      await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .set({"name": name, "cellPhone": phoneNum});

      // print(authCrends);
      // return authCrends.credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('Ya esta en uso');
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  Future verifyPhone(String phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential atuhCreds) {
          print(atuhCreds);
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception);
        },
        timeout: Duration(seconds: 60),
        codeSent: (verifyId, rsToken) {
          smsScreen = true;
          notifyListeners();
          varId = verifyId;
          phoneNum = phone;
        },
        codeAutoRetrievalTimeout: (auth) {});
  }
}
