import 'package:cloud_firestore/cloud_firestore.dart';

class CentersData {
  String centerId;
  String fotoUrl;
  String name;
  List stylists;
  List availability;

  CentersData(
      {this.centerId,
      this.fotoUrl,
      this.name,
      this.stylists,
      this.availability});
}
