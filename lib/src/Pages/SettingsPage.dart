import 'package:flutter/material.dart';
import 'package:inventory_management/src/ViewModels/ThemeManager.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Consumer<ThemeNotifier>(
          builder: (context, theme, child) => Column(
            children: [
              Container(
                child: FlatButton(
                  onPressed: () => {
                    print('Set Light Theme'),
                    theme.setLightMode(),
                  },
                  child: Text('Set Light Theme'),
                ),
              ),
              Container(
                child: FlatButton(
                  onPressed: () => {
                    print('Set Dark theme'),
                    theme.setDarkMode(),
                  },
                  child: Text('Set Dark theme'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
