import 'package:cloud_firestore/cloud_firestore.dart';

class SellProduct {
  String productID;
  int soldQuantity;
  String sellerName;
  String sellerID;
  String time;
  String docId;
  String productTitle;
  double unitPrice;

  SellProduct(this.productID, this.soldQuantity, this.sellerName, this.sellerID,
      this.unitPrice, this.productTitle);

  Map<String, dynamic> toMap() => {
        'product-id': this.productID,
        'sold-quantity': this.soldQuantity,
        'seller-name': this.sellerName,
        'seller-id': this.sellerID,
        'product-title': this.productTitle,
        'time': DateTime.now().toString(),
        'unit-price': this.unitPrice,
      };

  SellProduct.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        docId = snapshot.id,
        productID = snapshot.data()['product-id'],
        soldQuantity = snapshot.data()['sold-quantity'].toInt(),
        sellerName = snapshot.data()['seller-name'],
        sellerID = snapshot.data()['seller-id'],
        unitPrice = snapshot.data()['unit-price'],
        productTitle = snapshot.data()['product-title'],
        time = snapshot.data()['time'];
}
