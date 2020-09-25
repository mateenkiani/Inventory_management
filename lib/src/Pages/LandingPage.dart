import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart,
                  size: 50,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                ),
                Text(
                  'Inventory Management',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
