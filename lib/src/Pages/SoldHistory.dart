import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/src/Models/SellProduct.dart';
import 'package:intl/intl.dart';

class SoldHistory extends StatefulWidget {
  @override
  _SoldHistory createState() => _SoldHistory();
}

class _SoldHistory extends State<SoldHistory> {
  double totalMoney;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("sellers").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                semanticsValue: "Loading data ...",
              ),
            );
          } else {
            totalMoney = 0;
            return ListView.builder(
              itemCount: snapshot.data.documents.length + 1,
              itemBuilder: (context, index) {
                if (index != snapshot.data.documents.length) {
                  SellProduct product =
                      SellProduct.fromSnapshot(snapshot.data.documents[index]);
                  totalMoney = totalMoney +
                      product.unitPrice * product.soldQuantity.toDouble();
                  if (index == snapshot.data.documents.length) {
                    return Card(
                      child: Text('afdfas'),
                    );
                  }

                  return Card(
                    child: InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ItemPage(
                        //       product: product,
                        //       isAdmin: false,
                        //     ),
                        //   ),
                        // );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.sellerName,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 16, bottom: 8),
                                  child: Text(
                                    product.productTitle +
                                        ' sold on ' +
                                        new DateFormat.yMMMd().format(
                                          DateTime.parse(product.time),
                                        ),
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        product.soldQuantity.toString() +
                                            ' items sold',
                                      ),
                                      Spacer(),
                                      Text(
                                        ('Rs. ' +
                                            (product.unitPrice *
                                                    product.soldQuantity)
                                                .toString() +
                                            ' earned'),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Total Money Earned = ' + totalMoney.toStringAsFixed(2),
                      ),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
