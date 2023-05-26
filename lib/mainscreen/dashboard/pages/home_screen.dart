import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:osar_store/product/add_product.dart';
import 'package:osar_store/product/product_detail.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/menu.png"),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection("storeowners")
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasError)
                        return Text('Error = ${snapshot.error}');
                      if (snapshot.hasData) {
                        final docs = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: docs.length,
                          itemBuilder: (_, i) {
                            final data = docs[i].data();
                            return Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Text(
                                data['name'],
                                style: TextStyle(
                                    color: Color(0xff1D1E20),
                                    fontSize: 29,
                                    fontWeight: FontWeight.w800),
                              ),
                            );
                          },
                        );
                      }

                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
                Text(
                  "  Welcome to Osar Store.",
                  style: TextStyle(
                      color: Color(0xff8F959E),
                      fontSize: 15,
                      fontWeight: FontWeight.w800),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: CupertinoSearchTextField(
                      controller: _controller,
                      onChanged: (value) {},
                      onSubmitted: (value) {},
                      autocorrect: true,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Product"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => AddProduct()));
                          },
                          child: Text(
                            "Add Product",
                            style: TextStyle(color: Color(0xffFFBF00)),
                          )),
                    ],
                  ),
                ),
                Container(
                  height: 400,
                  child: StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance
                          .collection("products")
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;

                        return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8),
                            itemCount: documents.length,
                            itemBuilder: (BuildContext ctx, index) {
                              final Map<String, dynamic> data = documents[index]
                                  .data() as Map<String, dynamic>;

                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 340,
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  ProductDetail(
                                                    productUuod:
                                                        data['productUUid'],
                                                    ProductDescritption: data[
                                                        'productDescription'],
                                                    ProductImage: data['image'],
                                                    ProductName:
                                                        data['productName'],
                                                    ProductPrice:
                                                        data['prductPrice'],
                                                  )));
                                    },
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            data["image"],
                                            height: 78,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Product Name",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              data['productName'],
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
