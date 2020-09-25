import 'package:flutter/material.dart';
import 'package:inventory_management/src/Models/product.dart';

class ProductsListViewModel extends ChangeNotifier {
  List<ProductsViewModel> products = List<ProductsViewModel>();

  Future<void> fetchProducts() async {
    final results = 3;
  }
}

class ProductsViewModel {
  Product _product;

  ProductsViewModel() {}
}
