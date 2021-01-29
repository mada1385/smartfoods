import 'package:smartfoods/models/products.dart';

class Resturant {
  String title, image, open, close, location, type;
  int delivery, id;
  double rate;
  List<Product> products;

  Resturant(this.title, this.id, this.image, this.location, this.rate,
      this.type, this.open, this.close, this.delivery, this.products);
  factory Resturant.fromJson(Map<String, dynamic> json) {
    return Resturant(
      json["rest_name"].toString(),
      int.parse(json["rest_id"].toString()),
      json["rest_img"].toString(),
      json["rest_location"].toString(),
      double.parse(json["rate"].toString()),
      json["rest_type"].toString(),
      json["open"].toString(),
      json["close"].toString(),
      json["delivery"],
      json["products"].map<Product>((item) => Product.fromJson(item)).toList(),
    );
  }
}
