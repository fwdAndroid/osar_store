import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class BlockUser extends StatefulWidget {
  const BlockUser({super.key});

  @override
  State<BlockUser> createState() => _BlockUserState();
}

class _BlockUserState extends State<BlockUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text("Your Account is not Verified By the Admin"),
      ),
    );
  }
}
