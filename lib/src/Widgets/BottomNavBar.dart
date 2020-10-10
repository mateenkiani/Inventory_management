import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/src/Pages/SellProductPage.dart';
import 'package:inventory_management/src/Pages/SoldHistory.dart';
import 'package:inventory_management/src/ViewModels/ThemeManager.dart';
import 'package:inventory_management/src/Widgets/Search.dart';
import 'package:provider/provider.dart';
import 'package:inventory_management/src/Pages/MyHomePage.dart';
import 'package:inventory_management/src/Pages/SettingsPage.dart';
import 'package:inventory_management/src/Pages/AdminPage.dart';
import 'package:inventory_management/src/Pages/AddProductsPage.dart';
import 'package:inventory_management/src/Singleton.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBar createState() => new _BottomNavBar();
}

class _BottomNavBar extends State<BottomNavBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  User user;
  int i = Singleton.instance.activeItem;
  var pages = [
    MyHomePage(),
    AdminPage(),
    AddProductsPage(),
    SellProductPage(),
  ];

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  void _signOut() {
    Singleton.instance.setActiveNavItem(0);
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeNotifier>(context);

    Widget _buildDrawer(BuildContext context) {
      return Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(user.photoURL), fit: BoxFit.cover)),
              child: Text(user.displayName),
            ),
            InkWell(
              onTap: () => theme.setLightMode(),
              child: ListTile(
                title: Text("Light Mode"),
                trailing: Icon(Icons.lightbulb_outline),
              ),
            ),
            InkWell(
              onTap: () => theme.setDarkMode(),
              child: ListTile(
                title: Text("Dark Mode"),
                trailing: Icon(Icons.highlight_off),
              ),
            ),
            InkWell(
              onTap: _signOut,
              child: ListTile(
                title: Text("Sign out"),
                leading: Icon(Icons.exit_to_app),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: Text('Seller History'),
                        ),
                        body: SoldHistory()),
                  ),
                );
              },
              child: ListTile(
                title: Text("Seller Logs"),
                leading: Icon(Icons.shopping_basket),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: Text('Settings'),
                        ),
                        body: SettingsPage()),
                  ),
                );
              },
              child: ListTile(
                title: Text("Settings"),
                leading: Icon(Icons.settings),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildBottomNav(BuildContext context) {
      return BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.account_box),
              title: new Text('Admin'),
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.add_circle),
              title: new Text('Add Product'),
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.shopping_cart),
              title: new Text('Shop'),
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor),
        ],
        currentIndex: i,
        type: BottomNavigationBarType.shifting,
        onTap: (index) {
          setState(() {
            i = index;
          });
          Singleton.instance.setActiveNavItem(index);
        },
      );
    }

    return WillPopScope(
      onWillPop: () async {
        if (Singleton.instance.activeItem != 0) {
          Singleton.instance.setActiveNavItem(0);
          setState(() {
            i = Singleton.instance.activeItem;
          });
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: _buildDrawer(context),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => {
              _scaffoldKey.currentState.openDrawer(),
            },
          ),
          title: Text('Techshop'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                ),
              },
            )
          ],
        ),
        body: pages[i],
        bottomNavigationBar: _buildBottomNav(context),
      ),
    );
  }
}
