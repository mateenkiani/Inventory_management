import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/src/Models/product.dart';

class MyHomePage extends StatelessWidget {
  void myFunc() {
    Product product =
        Product('title', 3, 3, 'category', 'image', 'description');
    FirebaseFirestore.instance
        .collection("products")
        .doc()
        .set(product.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: RaisedButton(onPressed: myFunc, child: Text('homePage'))),
    );
  }
}
