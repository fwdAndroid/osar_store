import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:osar_store/status/user_status.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  String googleApikey = "AIzaSyAXlAJ4VBgBIle9-nP-XYcmcL2APpuHN2U";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(27.6602292, 85.308027);
  String location = "Search Location";
  TextEditingController _addrController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      GoogleMap(
        //Map widget from google_maps_flutter package
        zoomGesturesEnabled: true, //enable Zoom in, out on map
        initialCameraPosition: CameraPosition(
          //innital position in map
          target: startLocation, //initial position
          zoom: 14.0, //initial zoom level
        ),
        mapType: MapType.normal, //map type
        onMapCreated: (controller) {
          //method called when map is created
          setState(() {
            mapController = controller;
          });
        },
        // onCameraIdle: () async {
        //   //when map drag stops
        //   List<Placemark> placemarks = await placemarkFromCoordinates(
        //       cameraPosition!.target.latitude,
        //       cameraPosition!.target.longitude);
        //   setState(() {
        //     //get place name from lat and lang
        //     location = placemarks.first.administrativeArea.toString() +
        //         ", " +
        //         placemarks.first.street.toString();
        //     _addrController.text = location;
        //   });
        // },
      ),

      //search autoconplete input
      Positioned(
        //search input bar
        top: 10,
        child: InkWell(
          onTap: () async {
            var place = await PlacesAutocomplete.show(
                context: context,
                apiKey: googleApikey,
                mode: Mode.overlay,
                types: [],
                strictbounds: false,
                components: [Component(Component.country, 'pk')],
                //google_map_webservice package
                onError: (err) {
                  print(err);
                });

            if (place != null) {
              setState(() {
                location = place.description.toString();
                _addrController.text = location;
              });

              //form google_maps_webservice package
              final plist = GoogleMapsPlaces(
                apiKey: googleApikey,
                apiHeaders: await GoogleApiHeaders().getHeaders(),
                //from google_api_headers package
              );
              String placeid = place.placeId ?? "0";
              final detail = await plist.getDetailsByPlaceId(placeid);
              final geometry = detail.result.geometry!;
              final lat = geometry.location.lat;
              final lang = geometry.location.lng;
              var newlatlang = LatLng(lat, lang);

              //move map camera to selected place with animation
              mapController?.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: newlatlang, zoom: 17)));
            }
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Card(
              child: Container(
                  padding: EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width - 40,
                  child: ListTile(
                    // onTap: () {
                    //   print(_addrController.text);
                    // },
                    title: Text(
                      location,
                      style: TextStyle(fontSize: 18),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        print(_addrController);
                      },
                    ),
                    dense: true,
                  )),
            ),
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xfffFFBF00).withOpacity(.6),
                fixedSize: const Size(250, 60),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("storeowners")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({"address": _addrController.text}).then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => UserStatus()));
                });
              },
              child: Text("Create Profile")),
        ),
      )
    ]));
  }
}
