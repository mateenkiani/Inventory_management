import 'package:flutter/material.dart';
import 'package:inventory_management/src/Models/product.dart';
import 'package:inventory_management/src/Services/firestore.dart';

class ItemPage extends StatefulWidget {
  final Product product;
  final bool isAdmin;

  ItemPage({Key key, @required this.product, @required this.isAdmin})
      : super(key: key);

  _ItemPage createState() => _ItemPage();
}

class _ItemPage extends State<ItemPage> {
  Product product;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    product = widget.product;
  }

  void _inc(String docID) async {
    await _firestoreService.incQuantity(docID);
    product = await _firestoreService.getDoc(docID);
    setState(() {});
  }

  void _dec(String docID) async {
    await _firestoreService.decQuantity(docID);
    product = await _firestoreService.getDoc(docID);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Techshop'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.imageUrl,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
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
                        Text(product.quantity.toString() + ' remaining'),
                        if (widget.isAdmin) ...[
                          Spacer(),
                          Container(
                            margin: EdgeInsets.all(3),
                            decoration: new BoxDecoration(
                              color: Theme.of(context).bottomAppBarColor,
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: IconButton(
                                icon: Icon(Icons.arrow_upward),
                                onPressed: () {
                                  _inc(product.id);
                                },
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(3),
                            decoration: new BoxDecoration(
                              color: Theme.of(context).bottomAppBarColor,
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: IconButton(
                                icon: Icon(Icons.arrow_downward),
                                onPressed: () {
                                  _dec(product.id);
                                },
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 3),
                    padding: EdgeInsets.all(8),
                    decoration: new BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: new BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 10),
                        Text(
                          product.description,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Rs. ' + product.price.toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Spacer(),
                            Text(
                              'Total Price = ' +
                                  (product.price * product.quantity).toString(),
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
