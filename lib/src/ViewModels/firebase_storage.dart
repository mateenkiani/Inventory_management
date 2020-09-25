import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseStorage extends StatelessWidget {
  final databaseReference = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ));
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
