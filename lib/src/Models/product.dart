import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String title;
  double price;
  int quantity;
  String category;
  String imageUrl;
  String description;
  String id;
  String time;

  Product(this.title, this.price, this.quantity, this.category, this.imageUrl,
      this.description);

  Map<String, dynamic> toMap() => {
        'title': this.title,
        'price': this.price,
        'quantity': this.quantity,
        'category': this.category,
        'imageUrl': this.imageUrl,
        'description': this.description,
        'time': DateTime.now().toString(),
      };

  Product.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        id = snapshot.id,
        title = snapshot.data()['title'],
        price = snapshot.data()['price'].toDouble(),
        quantity = snapshot.data()['quantity'].toInt(),
        category = snapshot.data()['category'],
        imageUrl = snapshot.data()['imageUrl'],
        description = snapshot.data()['description'],
        time = snapshot.data()['time'];
}
