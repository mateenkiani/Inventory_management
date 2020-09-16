import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.collections,
              color: Colors.orange,
            ),
            Text(
              'Inventory Management',
              style: TextStyle(color: Colors.orange),
            )
          ],
        ),
      ),
    );
  }
}
