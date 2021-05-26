import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  String id;

  String name;
  String cellPhone;
  String email;
  String passWord;

  User({this.id, this.name, this.cellPhone, this.email, this.passWord});

  // factory User.fromFirestore(DocumentSnapshot userDoc) {
  //   Map userData = userDoc.data();
  //   return User(
  //       id: userDoc.id,
  //       name: userData['name'],
  //       cellPhone: userData['cellphone'],
  //       email: userData['email'],
  //       passWord: userData['password']);
  // }
}
