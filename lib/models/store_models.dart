import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  String uid;
  String type;
  String? address;
  String email;
  String name;
  String phoneNumber;
  bool verified;
  String? dob;
  String photoUrl;

  StoreModel({
    required this.uid,
    required this.verified,
    required this.email,
    required this.type,
    this.address,
    required this.photoUrl,
    required this.name,
    required this.phoneNumber,
    this.dob,
  });

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'name': name,
        "photoUrl": photoUrl,
        'dob': dob,
        'type': type,
        'uid': uid,
        'email': email,
        'phoneNumber': phoneNumber,
        'address': address,
        'verified': verified,
      };

  ///
  static StoreModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return StoreModel(
        name: snapshot['name'],
        type: snapshot['type'],
        uid: snapshot['uid'],
        photoUrl: snapshot['photoUrl'],
        email: snapshot['email'],
        dob: snapshot['dob'],
        phoneNumber: snapshot['phoneNumber'],
        verified: snapshot['verified'],
        address: snapshot['address']);
  }
}
