import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProductDetail extends StatefulWidget {
  final ProductName;
  final ProductDescritption;
  final ProductImage;
  final ProductPrice;
  final productUuod;
  ProductDetail(
      {super.key,
      required this.productUuod,
      required this.ProductDescritption,
      required this.ProductImage,
      required this.ProductName,
      required this.ProductPrice});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Product Detail",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffFFBF00), shape: BoxShape.circle),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            child: Image.network(
              widget.ProductImage,
              fit: BoxFit.fitWidth,
            ),
            height: 200,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Text(
                "Product Name",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              )),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Text(widget.ProductName),
          ),
          Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Text(
                "Product Description",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              )),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Text(widget.ProductDescritption),
          ),
          Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Text(
                "Product Price",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              )),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Text(widget.ProductPrice.toString()),
          ),
        ],
      ),
    );
  }
}
