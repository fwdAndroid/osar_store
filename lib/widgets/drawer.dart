import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:osar_store/auth/main_auth.dart';
import 'package:osar_store/mainscreen/dashboard/main_dashborad.dart';
import 'package:osar_store/mainscreen/dashboard/pages/order_history.dart';
import 'package:osar_store/mainscreen/dashboard/pages/owner_setting.dart';
import 'package:osar_store/noti/noti.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: 140,
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("storeowners")
                  .snapshots(),
              builder: (_, snapshot) {
                if (snapshot.hasError) return Text('Error = ${snapshot.error}');
                if (snapshot.hasData) {
                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (_, i) {
                      final data = docs[i].data();
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(data['photoUrl']),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Text(
                                data['name'],
                                style: TextStyle(
                                    color: Color(0xff1D1E20),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => MainDashboard()));
            },
            title: Text("Home"),
            leading: Icon(Icons.home),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => OrderHistory()));
            },
            title: Text("Orders"),
            leading: Icon(Icons.production_quantity_limits),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (builder) => Noti()));
            },
            title: Text("Notifications"),
            leading: Icon(Icons.notifications),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => OwnerSetting()));
            },
            title: Text("Setting"),
            leading: Icon(Icons.settings),
          ),
          Divider(),
          ListTile(
            onTap: () {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                          title: const Text('Log Out Alert'),
                          content: const Text(
                              'Are You Sure To Logout From This account'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                FirebaseAuth.instance.signOut().then((value) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => MainAuth()));
                                });
                              },
                              child: const Text('OK'),
                            ),
                          ]));
            },
            title: Text("Logout"),
            leading: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
