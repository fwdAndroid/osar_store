import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osar_store/widgets/textfieldwidget.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _controllerDescrition = TextEditingController();
  TextEditingController _controllerSpecification = TextEditingController();
  TextEditingController _price = TextEditingController();
  List<File> _image = [];
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Add Product",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffFFBF00), shape: BoxShape.circle),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Item Name",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                )),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: TextFormInputField(
                hintText: 'Item Name',
                textInputType: TextInputType.text,
                controller: _controller,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Item Description",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                )),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Description',
                    fillColor: Colors.white,
                    border: inputBorder,
                    focusedBorder: inputBorder,
                    enabledBorder: inputBorder,
                    filled: true,
                    contentPadding: EdgeInsets.all(8),
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 1, // <-- SEE HERE
                  maxLines: 10, // <-- SEE HERE
                )),
            SizedBox(
              height: 15,
            ),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Product Specification",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                )),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: TextFormInputField(
                hintText: 'Specification',
                textInputType: TextInputType.text,
                controller: _controllerSpecification,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Product Images",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                )),
            Container(
              height: 200,
              padding: EdgeInsets.all(4),
              child: GridView.builder(
                  itemCount: _image.length + 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return index == 0
                        ? Center(
                            child: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () => chooseImage()),
                          )
                        : Container(
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: FileImage(_image[index - 1]),
                                    fit: BoxFit.cover)),
                          );
                  }),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Product Price",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                )),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: TextFormInputField(
                hintText: 'Price',
                textInputType: TextInputType.text,
                controller: _price,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: ElevatedButton(
                onPressed: saveProduct,
                child: Text("Save Product"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFFBF00),
                    fixedSize: Size(250, 50)),
              ),
            )
          ],
        ),
      ),
    );
  }

  chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile!.path));
    });
    if (pickedFile!.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  void saveProduct() {}
}
