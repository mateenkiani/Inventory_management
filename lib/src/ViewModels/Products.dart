import 'package:flutter/material.dart';
import 'package:inventory_management/src/Models/product.dart';
import 'package:inventory_management/src/Services/firestore.dart';

class ProductsListViewModel extends ChangeNotifier {
  List<ProductsViewModel> products = List<ProductsViewModel>();

  Future<void> fetchProducts() async {}
}

class ProductsViewModel {
  final FirestoreService firestoreService = FirestoreService();

  void addProductToDatabase(Product product) {
    firestoreService.addRecord(product);
  }
}
