import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String uid;
  String productName;
  int prductPrice;
  String productSpecification;
  String productUUid;
  // var image = [];
  String productDescription;

  ProductModel({
    required this.uid,
    required this.productName,
    required this.prductPrice,
    required this.productSpecification,
    required this.productUUid,
    required this.productDescription,
    // required this.image,
  });

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        "productUUid": productUUid,
        // 'image': image,
        'uid': uid,
        'prductPrice': prductPrice,
        'productDescription': productDescription,
        'productSpecification': productSpecification,
        'productName': productName,
      };

  ///
  static ProductModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return ProductModel(
        productDescription: snapshot['productDescription'],
        uid: snapshot['uid'],
        productUUid: snapshot['productUUid'],
        prductPrice: snapshot['prductPrice'],
        // image: snapshot['image'],
        productName: snapshot['productName'],
        productSpecification: snapshot['productSpecification']);
  }
}
