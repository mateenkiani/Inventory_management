import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'src/ViewModels/ThemeManager.dart';
import 'src/Pages/LandingPage.dart';
import 'src/Widgets/BottomNavBar.dart';
import 'src/Singleton.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Singleton.instance;
  return runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => new ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static bool _fireSignIn = true;

  Future<void> _signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      print('_signInanonumously');
    } catch (e) {
      print(e);
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      theme: theme.getTheme(),
      home: StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (!snapshot.hasData) {
              print('im inside stream builder');
              if (_fireSignIn) {
                _signInAnonymously();
                _fireSignIn = false;
              }
              return LandingPage();
            } else {
              print('inside else');
              return BottomNavBar();
            }
          } else {
            print('snapshot else');
            return LandingPage();
          }
        },
      ),
    );
  }
}
