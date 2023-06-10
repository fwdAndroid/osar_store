import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:osar_store/status/geo.dart';
import 'package:osar_store/status/user_status.dart';

class AddMapAddress extends StatefulWidget {
  AddMapAddress({
    // this.addr,
    Key? key,
    // required this.lat,
    // required this.long,
    // required this.loc,
  }) : super(key: key);

  @override
  _AddMapAddressState createState() => _AddMapAddressState();
}

class _AddMapAddressState extends State<AddMapAddress> {
  String googleApikey = "AIzaSyBffT8plN_Vdcd308KgmzIfGVQN6q-CkAo";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  bool _isLoading = false;
  List latlong = [];
  String location = 'Please move map to A specific location.';
  TextEditingController _addrController = TextEditingController();

  @override
  void initState() {
    getLatLong();
    super.initState();
  }

  @override
  void dispose() {
    _addrController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LatLng startLocation = _isLoading
        ? const LatLng(25.276987, 55.296249)
        : LatLng(latlong[0], latlong[1]);

    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Column(
              children: [
                Container(
                  height: 680,
                  child: Stack(
                    children: [
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
                        onCameraMove: (CameraPosition cameraPositiona) {
                          cameraPosition =
                              cameraPositiona; //when map is dragging
                        },
                        onCameraIdle: () async {
                          List<Placemark> addresses =
                              await placemarkFromCoordinates(
                                  cameraPosition!.target.latitude,
                                  cameraPosition!.target.longitude);

                          var first = addresses.first;
                          print("${first.name} : ${first..administrativeArea}");

                          List<Placemark> placemarks =
                              await placemarkFromCoordinates(
                                  cameraPosition!.target.latitude,
                                  cameraPosition!.target.longitude);
                          Placemark place = placemarks[0];
                          location =
                              '${place.street},${place.subLocality},${place.locality},${place.thoroughfare},';

                          setState(() {
                            //get place name from lat and lang
                            // print(address);
                            _addrController.text = location;
                          });
                        },
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Positioned(
                          //search input bar
                          top: 10,
                          child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Card(
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: EdgeInsets.all(0),
                                    width:
                                        MediaQuery.of(context).size.width - 40,
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
                                        onPressed: () async {
                                          var place =
                                              await PlacesAutocomplete.show(
                                                  context: context,
                                                  apiKey: googleApikey,
                                                  mode: Mode.overlay,
                                                  types: [],
                                                  strictbounds: false,
                                                  components: [
                                                    Component(
                                                        Component.country, 'ae')
                                                  ],
                                                  //google_map_webservice package
                                                  onError: (err) {
                                                    print(err);
                                                  });

                                          if (place != null) {
                                            setState(() {
                                              location =
                                                  place.description.toString();
                                              _addrController.text = location;
                                            });

                                            //form google_maps_webservice package
                                            final plist = GoogleMapsPlaces(
                                              apiKey: googleApikey,
                                              apiHeaders:
                                                  await GoogleApiHeaders()
                                                      .getHeaders(),
                                              //from google_api_headers package
                                            );
                                            String placeid =
                                                place.placeId ?? "0";
                                            final detail = await plist
                                                .getDetailsByPlaceId(placeid);
                                            final geometry =
                                                detail.result.geometry!;
                                            final lat = geometry.location.lat;
                                            final lang = geometry.location.lng;
                                            var newlatlang = LatLng(lat, lang);

                                            //move map camera to selected place with animation
                                            mapController?.animateCamera(
                                                CameraUpdate.newCameraPosition(
                                                    CameraPosition(
                                                        target: newlatlang,
                                                        zoom: 17)));
                                          }
                                        },
                                      ),
                                      dense: true,
                                    )),
                              ))),
                      Center(
                        //picker image on google map
                        child: Image.asset(
                          "assets/user_loc.png",
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xfffFFBF00).withOpacity(.6),
                        fixedSize: Size(200, 40),
                        shape: StadiumBorder()),
                    onPressed: () async {
                      FirebaseFirestore.instance
                          .collection("storeowners")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({"address": _addrController.text}).then(
                              (value) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => UserStatus(),
                          ),
                        );
                      });
                    },
                    child: const Text('Pick'),
                  ),
                ),
              ],
            ),
    );
  }

  void getLatLong() async {
    setState(() {
      _isLoading = true;
    });
    latlong = await getLocation().getLatLong();
    setState(() {
      latlong;
      _isLoading = false;
    });
  }
}
