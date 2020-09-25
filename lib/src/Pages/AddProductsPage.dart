import 'package:flutter/material.dart';

class AddProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.fromLTRB(7, 2, 7, 2),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter name of product',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter price of product',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
