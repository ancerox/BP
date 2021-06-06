import 'package:bp/models/beauty_centers.dart';
import 'package:bp/models/stylists.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CenterProivder with ChangeNotifier {
  final uid = FirebaseAuth.instance.currentUser.uid;

  String centerId = '';

  final CollectionReference userCollections =
      FirebaseFirestore.instance.collection('user');

  final centersCollection = FirebaseFirestore.instance.collection('centers');
  final stylistsCollection = FirebaseFirestore.instance.collection('stylists');

  final userid = FirebaseAuth.instance.currentUser.uid;

  Stream get centerIds {
    return userCollections
        .doc(uid)
        .snapshots()
        .map((event) => event['centers']);
  }

  Stream<CentersData> centerData(String centerIds) {
    return centersCollection.doc(centerIds).snapshots().map((event) {
      return CentersData(
        fotoUrl: event.get('fotoUrl'),
        centerId: event.get('centerId'),
        name: event.get('name'),
        stylists: event.get('stylists'),
      );
    });
  }

  addCenter(String centerId) async {
    await centersCollection
        .where('centerId', isEqualTo: centerId)
        .get()
        .then((center) {
      if (center.docs.length > 0) {
        loadcenter(centerId);
        return true;
      } else {
        print('El centor no existe');
        return false;
      }
    });
  }

  void loadcenter(centerId) async {
    await userCollections.doc(uid).update({
      'centers': FieldValue.arrayUnion([centerId])
    });
  }

  Stream<StylistData> stylitys(String stylistId) {
    return stylistsCollection.doc(stylistId).snapshots().map((data) {
      return StylistData(
          name: data.get('name'),
          isActive: data.get('isActive'),
          photoUrl: data.get('photoUrl'));
    });
  }
}
