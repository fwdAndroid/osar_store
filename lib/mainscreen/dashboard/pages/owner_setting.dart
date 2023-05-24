import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:osar_store/auth/main_auth.dart';

class OwnerSetting extends StatefulWidget {
  const OwnerSetting({super.key});

  @override
  State<OwnerSetting> createState() => _OwnerSettingState();
}

class _OwnerSettingState extends State<OwnerSetting> {
  zisttile(String text, IconData icon, VoidCallback function) {
    return ListTile(
        onTap: function,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: Color(0xffFFBF00).withOpacity(.1),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: Color(0xffFFBF00),
            ),
          ),
        ),
        title: Text(
          text,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
        ),
        trailing: IconButton(
          onPressed: function,
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Color(0xffFFBF00),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("storeowners")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return new CircularProgressIndicator();
                }
                var document = snapshot.data;
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(document['photoUrl']),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      document['name'],
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ],
                );
              }),

          SizedBox(
            height: 20,
          ),
          Divider(
            color: Colors.grey,
            thickness: 0.5,
            indent: 15,
            endIndent: 15,
          ),
          // ListTile()
          zisttile('Setting', Icons.settings, () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (builder) => Edit_Setting()));
          }),
          Divider(
            color: Colors.grey,
            thickness: 0.5,
            indent: 15,
            endIndent: 15,
          ),
          zisttile('Account Information', Icons.person, () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (builder) => Notifications()));
          }),

          Divider(
            color: Colors.grey,
            thickness: 0.5,
            indent: 15,
            endIndent: 15,
          ),

          zisttile('Orders', Icons.online_prediction_rounded, () {}),

          Divider(
            color: Colors.grey,
            thickness: 0.5,
            indent: 15,
            endIndent: 15,
          ),
          zisttile('Logout', Icons.logout, () {
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (builder) => MainAuth()));
            });
          })
        ],
      ),
    );
  }
}
