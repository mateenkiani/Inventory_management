import 'package:flutter/material.dart';
import 'package:inventory_management/src/Models/product.dart';
import 'package:inventory_management/src/Services/firestore.dart';

class ProductsListViewModel extends ChangeNotifier {
  List<ProductsViewModel> products = List<ProductsViewModel>();

  Future<void> fetchProducts() async {}
}

class ProductsViewModel {
  final FirestoreService firestoreService = FirestoreService();

  Future<void> addProductToDatabase(Product product, Function onError) async {
    await firestoreService.addRecord(product, onError);
  }
}
