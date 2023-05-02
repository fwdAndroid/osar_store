import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class StoreOwnerProfile extends StatefulWidget {
  const StoreOwnerProfile({super.key});

  @override
  State<StoreOwnerProfile> createState() => _StoreOwnerProfileState();
}

class _StoreOwnerProfileState extends State<StoreOwnerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Working")],
      ),
    );
  }
}
