import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final databaseReference = FirebaseFirestore.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Inventory App'),
            ),
            body: Center(
              child: Container(
                child: Column(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () => {createRecord()},
                      child: Text('Create Record'),
                    ),
                    RaisedButton(
                      onPressed: () => {getData()},
                      child: Text('Get Data'),
                    ),
                  ],
                ),
              ),
            )));
  }

  void createRecord() async {
    await databaseReference.collection("books").doc("1").set({
      'title': 'Mastering Flutter',
      'description': 'Programming Guide for Dart'
    });

    DocumentReference ref = await databaseReference.collection("books").add({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });
    print(ref.id);
  }

  void getData() {
    databaseReference.collection("books").get().then((QuerySnapshot snapshot) {
      print(snapshot.toString());
      snapshot.docs.forEach((f) => {
            f.data().forEach((key, value) {
              print(value);
            })
          });
    });
  }
}
