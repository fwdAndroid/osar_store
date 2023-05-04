import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  String uid;
  String address;
  String email;
  String name;
  String phoneNumber;
  bool blocked;
  String? dob;
  String photoUrl;

  StoreModel({
    required this.uid,
    required this.blocked,
    required this.email,
    required this.address,
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
        'uid': uid,
        'email': email,
        'phoneNumber': phoneNumber,
        'address': address,
        'blocked': blocked,
      };

  ///
  static StoreModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return StoreModel(
        name: snapshot['name'],
        uid: snapshot['uid'],
        photoUrl: snapshot['photoUrl'],
        email: snapshot['email'],
        dob: snapshot['dob'],
        phoneNumber: snapshot['phoneNumber'],
        blocked: snapshot['blocked'],
        address: snapshot['address']);
  }
}
