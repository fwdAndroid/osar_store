import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String uid;
  String productName;
  int prductPrice;
  String productUUid;
  String image;
  String productDescription;
  // List<String>? productImages;

  ProductModel({
    required this.uid,
    required this.productName,
    // required this.productImages,
    required this.prductPrice,
    required this.productUUid,
    required this.productDescription,
    required this.image,
  });

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        "productUUid": productUUid,
        'image': image,
        'uid': uid,
        'prductPrice': prductPrice,
        'productDescription': productDescription,
        'productName': productName,
        // "productImages": "productImages",
      };

  ///
  static ProductModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return ProductModel(
      productDescription: snapshot['productDescription'],
      uid: snapshot['uid'],
      productUUid: snapshot['productUUid'],
      prductPrice: snapshot['prductPrice'],
      image: snapshot['image'],
      // productImages: snapshot['productImages'],
      productName: snapshot['productName'],
    );
  }
}
