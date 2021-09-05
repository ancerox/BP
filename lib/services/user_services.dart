import 'package:bp/Screens/HomePage/Home_page.dart';
import 'package:bp/Screens/Register/Register_P.dart';

import 'package:bp/colors.dart';
import 'package:bp/models/user_models.dart';
import 'package:bp/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class UserServices with ChangeNotifier {
  bool smsScreen = false;
  String varId = '';
  int token = 0;
  String phoneNum = '';
  String userId = '';
  bool isLoading = false;
  bool isError = false;
  BuildContext verifyContext;
  BuildContext smsContext;

  String smsCode = '';
  final _fireStore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  final CollectionReference userCollections =
      FirebaseFirestore.instance.collection('user');

  Future registerUser(String email, String password, String name) async {
    try {
      final creds =
          EmailAuthProvider.credential(email: email, password: password);

      final user = auth.currentUser;

      await user.linkWithCredential(creds);

      // save user collections

      userCollections.doc(user.uid).set({
        "name": name,
        "cellPhone": phoneNum,
        "stylistIdCurrentApoiment": null,
        "centers": []
      });
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
    return await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential atuhCreds) {
          print(atuhCreds);
        },
        verificationFailed: (FirebaseAuthException exception) {
          ScaffoldMessenger.of(verifyContext).showSnackBar(SnackBar(
            duration: Duration(seconds: 3),
            backgroundColor: kPrimeryColor,
            content: Text(
              'El numero no es valido!',
              style:
                  TextStyle(fontWeight: FontWeight.w600, fontSize: getPSH(16)),
            ),
          ));
        },
        // timeout: Duration(seconds: 60),
        codeSent: (verifyId, rsToken) {
          smsScreen = true;
          notifyListeners();
          varId = verifyId;
          phoneNum = phone;
          token = rsToken;
          // return true;
        },
        codeAutoRetrievalTimeout: (auth) {});
  }

  Future verifyUser() async {
    PhoneAuthCredential phoneAuthCredential =
        PhoneAuthProvider.credential(verificationId: varId, smsCode: smsCode);
    try {
      //log the user in if exist
      await auth.signInWithCredential(phoneAuthCredential);

      userId = auth.currentUser.uid;

      //is user un db?
      return await _fireStore
          .collection('user')
          .where('cellPhone', isEqualTo: phoneNum)
          .get()
          .then((value) {
        if (value.docs.length > 0) {
          Navigator.pushNamedAndRemoveUntil(
              smsContext, HomePage.route, (route) => false);
          ScaffoldMessenger.of(smsContext).showSnackBar(SnackBar(
            duration: Duration(seconds: 3),
            backgroundColor: kPrimeryColor,
            content: Text(
              'Te has logeado correctamente',
              style:
                  TextStyle(fontWeight: FontWeight.w600, fontSize: getPSH(16)),
            ),
          ));
        } else {
          Navigator.pushNamedAndRemoveUntil(
              smsContext, RegisterPage.routeName, (route) => false);
        }
      });
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      if (e.code == 'invalid-verification-code') {
        ScaffoldMessenger.of(smsContext).showSnackBar(SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: kPrimeryColor,
          content: Text(
            'El codigo no es valido!',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: getPSH(16)),
          ),
        ));
        return null;
      }
    }
  }

  // UserData from snapshot

  UserData _userDataFromSnapchot(DocumentSnapshot snaphot) {
    return UserData(
      id: auth.currentUser.uid,
      name: snaphot['name'],
      cellPhone: snaphot['cellPhone'],
      stylistIdCurrentApoiment: snaphot['stylistIdCurrentApoiment'],
      centers: snaphot['centers'],
    );
  }

  // get user creds

  Stream<UserData> get userData {
    return userCollections
        .doc(auth.currentUser.uid)
        .snapshots()
        .map(_userDataFromSnapchot);
  }
}
