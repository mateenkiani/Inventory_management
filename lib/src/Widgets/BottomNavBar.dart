import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  void _signOut() {
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
                trailing: Icon(Icons.exit_to_app),
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
      );
    }

    return Scaffold(
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
    );
  }
}
