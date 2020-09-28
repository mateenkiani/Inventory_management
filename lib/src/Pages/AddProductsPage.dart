import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_management/src/Models/product.dart';
import 'package:inventory_management/src/Services/firebaseStorage.dart';
import 'package:inventory_management/src/ViewModels/Products.dart';
import 'package:inventory_management/src/ViewModels/captureImage.dart';

class AddProductsPage extends StatefulWidget {
  _AddProductsPage createState() => _AddProductsPage();
}

class _AddProductsPage extends State<AddProductsPage> {
  CaptureImage captureImage;
  FirebaseStorageService storageService;
  final _formKey = GlobalKey<FormState>();

  String _title;
  double _price;
  int _quantity;
  String _category;
  String _imageUrl;
  String _description;

  _AddProductsPage() {
    captureImage = CaptureImage();
    storageService = FirebaseStorageService();
  }

  void _clearImage() {
    setState(() => captureImage.imageFile = null);
  }

  void _cropImage() async {
    File image = await captureImage.cropImage();

    setState(() {
      captureImage.imageFile = image;
    });
  }

  void _pickImage(ImageSource source) async {
    File image = await captureImage.pickImage(source);

    setState(() {
      captureImage.imageFile = image;
    });
  }

  Future<String> _uploadImage(File file) async {
    return await storageService.uploadImage(file);
  }

  void _submitForm(BuildContext context) async {
    _formKey.currentState.save();
    if (captureImage.imageFile != null) {
      _imageUrl = await _uploadImage(captureImage.imageFile);
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select an Image"),
        ),
      );
    }

    Product product = Product(
      _title,
      _price,
      _quantity,
      _category,
      _imageUrl,
      _description,
    );

    ProductsViewModel productsViewModel = ProductsViewModel();
    productsViewModel.addProductToDatabase(product);
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter name of product',
            ),
            onSaved: (value) => {_title = value},
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter price of product',
            ),
            onSaved: (value) => {
              _price = double.parse(value),
              print(value + _price.toString())
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Quantity of product',
            ),
            onSaved: (value) => {_quantity = int.parse(value)},
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Category of product',
            ),
            onSaved: (value) => {_category = value},
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'description of product',
            ),
            onSaved: (value) => {_description = value},
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSelector() {
    return Container(
      decoration: BoxDecoration(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
        child: Row(
          children: <Widget>[
            Text(
              'Choose Image',
              style: TextStyle(
                fontSize: 20,
                wordSpacing: 3,
                letterSpacing: 0.5,
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(7, 2, 7, 2),
          child: Column(
            children: [
              _buildForm(),
              Padding(
                padding: EdgeInsets.only(top: 5),
              ),
              _buildImageSelector(),
              Container(
                child: Row(
                  children: <Widget>[
                    if (captureImage.imageFile != null) ...[
                      Column(
                        children: <Widget>[
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.file(captureImage.imageFile),
                          ),
                          Row(
                            children: <Widget>[
                              FlatButton(
                                child: Icon(Icons.crop),
                                onPressed: _cropImage,
                              ),
                              FlatButton(
                                child: Icon(Icons.refresh),
                                onPressed: _clearImage,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Submit'),
                onPressed: () => _submitForm(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
