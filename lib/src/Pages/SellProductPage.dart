import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/src/Models/SellProduct.dart';
import 'package:inventory_management/src/Models/product.dart';
import 'package:inventory_management/src/Services/firestore.dart';
import 'package:inventory_management/src/ViewModels/sellproductViewModel.dart';

class SellProductPage extends StatefulWidget {
  @override
  _SellProductPage createState() => _SellProductPage();
}

class _SellProductPage extends State<SellProductPage> {
  final SellProductViewModel _sellProductViewModel = SellProductViewModel();
  int itemsCount;

  Future<void> _sellProduct(Product product) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('How many pieces you want to sell?'),
          content: SingleChildScrollView(
            child: TextField(
              autofocus: true,
              onChanged: (value) => {
                itemsCount = int.parse(value),
              },
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter number of items'),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Sell product'),
              onPressed: () async {
                User user = FirebaseAuth.instance.currentUser;
                SellProduct sellProduct = SellProduct(product.id, itemsCount,
                    user.displayName, user.uid, product.price, product.title);
                _sellProductViewModel.addRecord(sellProduct);
                FirestoreService service = FirestoreService();
                service.decQuantity(product.id, decCount: itemsCount);
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

                return Container(
                  margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                  padding: EdgeInsets.only(left: 8, right: 8),
                  width: double.infinity,
                  height: 70,
                  decoration: new BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: new BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: product.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.title),
                            Text(
                              product.quantity.toString() + " remaining",
                              style: TextStyle(fontSize: 9),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          _sellProduct(product);
                        },
                      ),
                    ],
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
