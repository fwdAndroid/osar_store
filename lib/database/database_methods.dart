import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:osar_store/database/storage_methods.dart';
import 'package:osar_store/models/store_models.dart';
import 'package:uuid/uuid.dart';

class DatabaseMethods {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // Future checkDocuement(String docID) async {
  //   final snapShot = await FirebaseFirestore.instance
  //       .collection('storeowners')
  //       .doc(FirebaseAuth.instance.currentUser!.uid) // varuId in your case
  //       .get();

  //   if (snapShot == null || !snapShot.exists) {
  //     // docuement is not exist
  //     print('id is not exist');
  //   } else {
  //     print("id is really exist");
  //   }
  // }

//OTP Number Add
  Future<String> numberAdd() async {
    String res = 'Some error occured';
    try {
      //Add User to the database with modal
      StoreModel userModel = StoreModel(
        photoUrl: "",
        blocked: false,
        name: '',
        uid: FirebaseAuth.instance.currentUser!.uid,
        email: "",
        address: '',
        phoneNumber: FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
      );
      await firebaseFirestore
          .collection('storeowners')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(
            userModel.toJson(),
          );
      res = 'success';
      debugPrint(res);
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Profile Details
  Future<String> profileDetail({
    required String email,
    required String uid,
    required String name,
    required String address,
    required bool blocked,
    required String dob,
    required String phoneNumber,
    required Uint8List file,
  }) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty || name.isNotEmpty) {
        //Add User to the database with modal
        String photoURL = await StorageMethods()
            .uploadImageToStorage('StoreOwnerPics', file, false);
        StoreModel userModel = StoreModel(
          blocked: blocked,
          name: name,
          address: address,
          uid: FirebaseAuth.instance.currentUser!.uid,
          email: email,
          photoUrl: photoURL,
          phoneNumber:
              FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
        );
        await firebaseFirestore
            .collection('storeowners')
            .doc(uid)
            .update(userModel.toJson());

        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
