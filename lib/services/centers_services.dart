import 'package:bp/models/beauty_centers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CenterProivder with ChangeNotifier {
  final uid = FirebaseAuth.instance.currentUser.uid;

  String centerId = '';

  final CollectionReference userCollections =
      FirebaseFirestore.instance.collection('user');

  final centers = FirebaseFirestore.instance.collection('centers');

  List<CentersData> _centersDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((snapshot) {
      return CentersData(
          fotoUrl: snapshot.get('fotoUrl'),
          centerId: snapshot.get('centerId'),
          name: snapshot.get('name'));
    }).toList();
  }

  final userid = FirebaseAuth.instance.currentUser.uid;

  get centerIds {
    return userCollections
        .doc(uid)
        .snapshots()
        .map((event) => event['centers']);
  }

  centerData(String centerIds) {
    return centers.doc(centerIds).snapshots().map((event) => event.data());
  }

  addCenter(String centerId) async {
    await centers.where('centerId', isEqualTo: centerId).get().then((center) {
      if (center.docs.length > 0) {
        // loadcenter(centerId);
      } else {
        print('El centor no existe');
      }
    });
  }

  // void loadcenter(centerId) async {
  //   await userCollections.doc(uid).update({
  //     'centers': [centerId],
  //   });
  // }

  centersList() async {
    return await userCollections
        .doc(uid)
        .get()
        .then((value) => value['centers']);
  }
}
