import 'package:bp/models/apoiment_model.dart';
import 'package:bp/models/beauty_centers.dart';

import 'package:bp/models/stylists.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CenterProivder with ChangeNotifier {
  final uid = FirebaseAuth.instance.currentUser.uid;

  String centerId = '';
  String chatroomPass = '';
  String stylistName = '';

  final CollectionReference userCollections =
      FirebaseFirestore.instance.collection('user');

  final centersCollection = FirebaseFirestore.instance.collection('centers');
  final stylistsCollection = FirebaseFirestore.instance.collection('stylists');
  final chatRooms = FirebaseFirestore.instance.collection('chatRooms');

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
          availability: event.get('availability'));
    });
  }

  addCenter(String centerId) async {
    return await centersCollection
        .where('centerId', isEqualTo: centerId)
        .get()
        .then((center) {
      if (center.docs.length > 0) {
        loadcenter(centerId);
        return true;
      } else {
        return null;
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
          photoUrl: data.get('photoUrl'),
          availability: data.get('availability'));
      // services: data.get('services'));
    });
  }

  Stream services(String stylistId) {
    return stylistsCollection.doc(stylistId).collection('services').snapshots();
  }

  Stream apoiments(String stylistId) {
    return stylistsCollection
        .doc(stylistId)
        .collection('apoiments')
        .orderBy('hour', descending: false)
        .snapshots();
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return ("$b\_$a");
    } else {
      return ("$a\_$b");
    }
  }

  Future addMessage(
      String chatRoomId, String messageId, Map messageInfoMap) async {
    return await chatRooms
        .doc(chatRoomId)
        .collection('chats')
        .doc(messageId)
        .set(messageInfoMap);
  }

  Future updateLastMessageSent(
      String chatRoomId, Map lastMessageInfoMap) async {
    return await chatRooms.doc(chatRoomId).update(lastMessageInfoMap);
  }

  createChatRoom(String chatRoom, Map chatRoominfoMap) async {
    final snapshot = await chatRooms.doc(chatRoom).get();

    chatroomPass = chatRoom;

    if (snapshot.data == null) {
      return true;
    } else {
      return await chatRooms.doc(chatRoom).set(chatRoominfoMap);
    }
  }

  Stream<QuerySnapshot> getChatRoomMessages(String chatRoomId) {
    return chatRooms
        .doc(chatRoomId)
        .collection('chats')
        .orderBy('ts', descending: true)
        .snapshots();
  }

  Stream defaultAb(String stylistId) {
    return stylistsCollection.doc(stylistId).snapshots();
  }

  makeApoiment(String stylistId, Apoiment apoiment) {
    //save id of the stylist
    print(stylistId);
    userCollections.doc(uid).update({
      'stylistIdCurrentApoiment': stylistId,
    });

    return stylistsCollection.doc(stylistId).collection('apoiments').add({
      'hour': apoiment.startAt,
      'finishAt': apoiment.finishAt,
      'service': apoiment.service,
      'timeInMinutes': apoiment.timeInMinutes,
      'userId': uid,
      'stylistName': apoiment.stylistName,
      'price': apoiment.price,
    });
  }

  Stream currentApoiment(
    String stylistId,
  ) {
    return stylistsCollection
        .doc(stylistId)
        .collection('apoiments')
        .where('userId', isEqualTo: uid.toString())
        .snapshots();

    //   .then((value) {
    // if (value.docs.length > 0) {
    //   print('work');
    //   return value;
    // } else {
    //   return null;
    // }
    // });
  }
}
//  return Apoiment(dateTime: data.docs);
