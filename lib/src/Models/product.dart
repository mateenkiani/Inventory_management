class Product {
  String _title;
  double _price;
  int _quantity;
  String _category;
  String _image;
  String _description;

  Product(this._title, this._price, this._quantity, this._category, this._image,
      this._description);

  Map<String, dynamic> toMap() => {
        'title': this._title,
        'price': this._price,
        'quantity': this._quantity,
        'category': this._category,
        'image': this._image,
        'description': this._description
      };
}
