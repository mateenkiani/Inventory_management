import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/src/Models/product.dart';
import 'package:inventory_management/src/Pages/ItemPage.dart';
import 'package:inventory_management/src/Services/firestore.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPage createState() => _AdminPage();
}

class _AdminPage extends State<AdminPage> {
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> _deleteItem(String docID) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: SingleChildScrollView(
            child: Text('Tapping delete will remove the whole item'),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Delete'),
              onPressed: () {
                _firestoreService.deleteDocument(docID);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("products").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                semanticsValue: "Loading data ...",
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                Product product =
                    Product.fromSnapshot(snapshot.data.documents[index]);

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemPage(
                          product: product,
                          isAdmin: true,
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    isThreeLine: true,
                    subtitle:
                        Text(product.quantity.toString() + ' items reamining'),
                    leading: Material(
                      elevation: 4.0,
                      shape: CircleBorder(),
                      clipBehavior: Clip.hardEdge,
                      color: Colors.transparent,
                      child: Ink.image(
                        image: NetworkImage(product.imageUrl),
                        fit: BoxFit.cover,
                        width: 50.0,
                        height: 50.0,
                      ),
                    ),
                    title: Text(product.title),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteItem(product.id),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
