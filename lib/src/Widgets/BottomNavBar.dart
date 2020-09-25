import 'package:flutter/material.dart';
import '../Pages/MyHomePage.dart';
import '../Pages/SettingsPage.dart';
import '../Pages/AdminPage.dart';
import 'package:inventory_management/src/Pages/AddProductsPage.dart';
import 'package:inventory_management/src/Singleton.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBar createState() => new _BottomNavBar();
}

class _BottomNavBar extends State<BottomNavBar> {
  int i = Singleton.instance.activeItem;
  var pages = [
    MyHomePage(),
    AdminPage(),
    AddProductsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[i],
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            backgroundColor: Colors.green,
            title: new Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.account_box),
            backgroundColor: Colors.cyan,
            title: new Text('Admin'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.add_circle),
            backgroundColor: Colors.orange,
            title: new Text('Add Product'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.settings),
            backgroundColor: Colors.redAccent,
            title: new Text('Settings'),
          ),
        ],
        currentIndex: i,
        type: BottomNavigationBarType.shifting,
        onTap: (index) {
          setState(() {
            i = index;
          });
          Singleton.instance.setActiveNavItem(index);
        },
      ),
    );
  }
}
