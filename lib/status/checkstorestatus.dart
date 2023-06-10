import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:osar_store/mainscreen/dashboard/main_dashborad.dart';
import 'package:osar_store/mainscreen/store_main_screen.dart';

class CheckStoreStatus extends StatefulWidget {
  const CheckStoreStatus({super.key});

  @override
  State<CheckStoreStatus> createState() => _CheckStoreStatusState();
}

class _CheckStoreStatusState extends State<CheckStoreStatus> {
  @override
  void initState() {
    // TODO: implement initState
    checkresult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void checkresult() async {
    final doc = await FirebaseFirestore.instance
        .collection('storesList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final bool doesDocExist = doc.exists;

    if (doesDocExist) {
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => MainDashboard()));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (builder) => StoreMainScreen(
                    uid: FirebaseAuth.instance.currentUser!.uid,
                  )));
    }
  }
}
