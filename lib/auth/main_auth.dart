import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:osar_store/database/database_methods.dart';
import 'package:osar_store/profile/store_owner_profile.dart';

class MainAuth extends StatefulWidget {
  const MainAuth({super.key});

  @override
  State<MainAuth> createState() => _MainAuthState();
}

class _MainAuthState extends State<MainAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Let's Get Started",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
          InkWell(
            onTap: () async {
              await DatabaseMethods().signInWithGoogle().then((value) => {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => StoreOwnerProfile()))
                  });
            },
            child: Container(
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 50),
                child: Image.asset("assets/google.png")),
          )
        ],
      ),
    );
  }
}
