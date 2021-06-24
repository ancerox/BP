import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String message;
  String sendBy;
  Timestamp ts;

  ChatModel({this.message, this.sendBy, this.ts});
}
