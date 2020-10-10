import 'package:flutter/material.dart';
import 'package:inventory_management/src/Models/product.dart';
import 'package:inventory_management/src/Services/firestore.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ItemPage extends StatefulWidget {
  final Product product;
  final bool isAdmin;

  ItemPage({Key key, @required this.product, @required this.isAdmin})
      : super(key: key);

  _ItemPage createState() => _ItemPage();
}

class _ItemPage extends State<ItemPage> {
  Product product;
  double price = 0;
  bool _pendingInc = false;
  bool _pendingDec = false;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    product = widget.product;
  }

  Future<void> _inc(String docID) async {
    await _firestoreService.incQuantity(docID);
    product = await _firestoreService.getDoc(docID);
    setState(() {});
  }

  Future<void> _dec(String docID) async {
    await _firestoreService.decQuantity(docID);
    product = await _firestoreService.getDoc(docID);
    setState(() {});
  }

  Future<void> _changePrice(String docID) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter new Price'),
          content: SingleChildScrollView(
            child: TextField(
              autofocus: true,
              onChanged: (value) => {
                price = double.parse(value),
              },
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter new price'),
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
              child: Text('Change Price'),
              onPressed: () async {
                print(price);
                _firestoreService.updatePrice(docID, price);
                product = await _firestoreService.getDoc(docID);
                setState(() {});
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Techshop'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: product.imageUrl,
              width: double.infinity,
              fit: BoxFit.fitWidth,
              placeholder: (context, url) => Container(
                width: double.infinity,
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
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
                            width: 50,
                            height: 50,
                            margin: EdgeInsets.all(3),
                            decoration: new BoxDecoration(
                              color: Theme.of(context).bottomAppBarColor,
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                child: !_pendingInc
                                    ? Icon(Icons.arrow_upward)
                                    : Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1,
                                        ),
                                      ),
                                onTap: () async {
                                  setState(() {
                                    _pendingInc = true;
                                  });
                                  await _inc(product.id);
                                  setState(() {
                                    _pendingInc = false;
                                  });
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            margin: EdgeInsets.all(3),
                            decoration: new BoxDecoration(
                              color: Theme.of(context).bottomAppBarColor,
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                child: !_pendingDec
                                    ? Icon(Icons.arrow_downward)
                                    : Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1,
                                        ),
                                      ),
                                onTap: () async {
                                  setState(() {
                                    _pendingDec = true;
                                  });
                                  await _dec(product.id);
                                  setState(() {
                                    _pendingDec = false;
                                  });
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
                              'Rs. ' + product.price.toStringAsFixed(2),
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                _changePrice(product.id);
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: new BoxDecoration(
                                  color: Theme.of(context).bottomAppBarColor,
                                  borderRadius: new BorderRadius.all(
                                      Radius.circular(8.0)),
                                ),
                                child: Text('Change Price'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                        Text(
                          ('Product added on ' +
                              new DateFormat.yMMMd().format(
                                DateTime.parse(product.time),
                              )),
                        ),
                        Spacer(),
                        Text(
                          'Total Price = ' +
                              (product.price * product.quantity)
                                  .toStringAsFixed(2),
                          style: Theme.of(context).textTheme.subtitle2,
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
