import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:inventory_management/src/Models/SellProduct.dart';

class SellProductViewModel {
  final _productsRef = FirebaseFirestore.instance.collection('sellers');

  Future<void> addRecord(SellProduct product) async {
    try {
      _productsRef
          .add(product.toMap())
          .then((value) => print("value" + value.toString()))
          .catchError((err) => print(err));
    } on PlatformException catch (e) {
      print("error selling product" + e.toString());
    }
  }
}
