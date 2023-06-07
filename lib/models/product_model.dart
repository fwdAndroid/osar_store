import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String uid;
  String productName;
  int prductPrice;
  String productUUid;
  String storeName;
  List<String> productImages;
  String image;
  String productDescription;
  String storeAddress;
  ProductModel({
    required this.uid,
    required this.productImages,
    required this.productName,
    required this.storeAddress,
    required this.storeName,
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
        'productImages': productImages,
        'prductPrice': prductPrice,
        'productDescription': productDescription,
        'productName': productName,
        "storeAddress": storeAddress,
        "storeName": storeName
      };

  ///
  static ProductModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return ProductModel(
      productDescription: snapshot['productDescription'],
      uid: snapshot['uid'],
      productImages: snapshot['productImages'],
      productUUid: snapshot['productUUid'],
      prductPrice: snapshot['prductPrice'],
      image: snapshot['image'],
      storeAddress: snapshot['storeAddress'],
      storeName: snapshot['storeName'],
      productName: snapshot['productName'],
    );
  }
}
