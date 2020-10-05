import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/src/ViewModels/ThemeManager.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, child) => Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 8, left: 8, right: 8),
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: new BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: new BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: 190.0,
                      height: 190.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(user.photoURL),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(user.email),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: new BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: new BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.lightbulb_outline),
                      title: Text('Toggle Theme'),
                      trailing: Switch(
                        value: Theme.of(context).brightness == Brightness.dark,
                        onChanged: (bool value) {
                          value ? theme.setDarkMode() : theme.setLightMode();
                        },
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text('Signout'),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
