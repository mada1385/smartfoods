import 'dart:convert';
import 'package:http/http.dart';
import 'package:smartfoods/models/news.dart';

class CategoryAPI {
  Future<List<Category>> getAllcategories() async {
    print("cate api activated");
    try {
      Response res =
          await get("http://otlob.accuragroup-eg.net/api/getCategories");
      var body;
      if (res.statusCode == 200) {
        // this mean that we are connected to the data base
        body = jsonDecode(res.body);
        print(body);
        if (res.body.length > 1) {
          List<dynamic> data = body["return"];
          List<Category> categories =
              data.map((dynamic item) => Category.fromJson(item)).toList();
          return categories;
        } else {
          return null;
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
