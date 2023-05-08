import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:osar_store/product/add_product.dart';

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
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    "Hemendra",
                    style: TextStyle(
                        color: Color(0xff1D1E20),
                        fontSize: 29,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Text(
                  "    Welcome to Osar Store.",
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
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("productlist")
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
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemCount: documents.length,
                            itemBuilder: (BuildContext ctx, index) {
                              final Map<String, dynamic> data = documents[index]
                                  .data() as Map<String, dynamic>;

                              return Container(
                                height: 200,
                                alignment: Alignment.center,
                                child: Text(
                                  data['productName'],
                                  style: TextStyle(color: Colors.black),
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
