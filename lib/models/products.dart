class Product {
  String title, image, price;
  int id;

  Product(this.title, this.image, this.price, this.id);
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(json["prod_name"].toString(), json["prod_image"].toString(),
        json["prod_price"].toString(), json["prod_id"]);
  }
}
