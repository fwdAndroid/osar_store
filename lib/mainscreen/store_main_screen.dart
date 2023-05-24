import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osar_store/database/database_methods.dart';
import 'package:osar_store/mainscreen/dashboard/main_dashborad.dart';
import 'package:osar_store/widgets/textfieldwidget.dart';
import 'package:osar_store/widgets/utils.dart';

class StoreMainScreen extends StatefulWidget {
  const StoreMainScreen({Key? key}) : super(key: key);

  @override
  _StoreMainScreenState createState() => _StoreMainScreenState();
}

class _StoreMainScreenState extends State<StoreMainScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Uint8List? _image;

  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();
  File? imageUrl;
  String imageLink = "";
  void getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageUrl = File(image!.path);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.clear();
    _emailController.clear();
    _addressController.clear();
    _phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Store Address",
                    style: TextStyle(
                        color: Color(0xff1D1E20),
                        fontWeight: FontWeight.w800,
                        fontSize: 22),
                  )),
            ),
            Center(
              child: InkWell(
                onTap: () => selectImage(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 204,
                    height: 107,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Color(0xffD2D2D2),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 39,
                                backgroundImage: MemoryImage(_image!))
                            : Image.asset(
                                "assets/cam.png",
                                width: 51,
                                height: 39,
                              ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: RichText(
                            text: TextSpan(
                              text: 'Upload Store  Photo',
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '*',
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red,
                                      fontStyle: FontStyle.normal,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: RichText(
                  text: TextSpan(
                    text: 'Enter Store Name',
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: '*',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: TextFormInputField(
                hintText: 'Enter Store Email',
                textInputType: TextInputType.text,
                controller: _nameController,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: RichText(
                  text: TextSpan(
                    text: 'Enter Email',
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: '*',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: TextFormInputField(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: RichText(
                  text: TextSpan(
                    text: 'Enter Address',
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: '*',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: TextFormInputField(
                hintText: 'Enter Address',
                textInputType: TextInputType.text,
                controller: _addressController,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: RichText(
                  text: TextSpan(
                    text: 'Enter Phone Number',
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: '*',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: TextFormInputField(
                hintText: 'Enter Phone Number',
                textInputType: TextInputType.text,
                controller: _phoneController,
              ),
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xfffFFBF00).withOpacity(.6),
                  fixedSize: const Size(350, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: StoreMainScreen,
                child: _isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : Text(
                        'Create Store',
                        style: GoogleFonts.getFont('Montserrat',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 15,
                            fontStyle: FontStyle.normal),
                      ),
              ),
            ),
          ]),
    );
  }

  // Select Image From Gallery
  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }

  StoreMainScreen() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _addressController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("All Fields are required")));
    } else {
      setState(() {
        _isLoading = true;
      });
      String rse = await DatabaseMethods().store(
          type: "StoreOwners",
          email: _emailController.text,
          name: _nameController.text,
          address: _addressController.text,
          phoneNumber: _phoneController.text,
          file: _image!,
          uid: FirebaseAuth.instance.currentUser!.uid,
          verified: false);

      print(rse);
      setState(() {
        _isLoading = false;
      });
      if (rse == 'success') {
        showSnakBar(rse, context);
        Navigator.push(
            context, MaterialPageRoute(builder: (builder) => MainDashboard()));
      } else {
        showSnakBar(rse, context);
      }
    }
  }
}
