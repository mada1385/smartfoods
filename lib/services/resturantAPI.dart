import 'dart:convert';

import 'package:http/http.dart';
import 'package:smartfoods/models/news.dart';
import 'package:smartfoods/models/resturant.dart';

class ResturantAPI {
  Future<List<Resturant>> getAllresturant(int id) async {
    print("Resturant api activated");
    try {
      Response res = await get(
          "http://otlob.accuragroup-eg.net/api/getResturants?langu=ar&catId=$id");
      var body;
      if (res.statusCode == 200) {
        // this mean that we are connected to the data base
        body = jsonDecode(res.body);
        print(body);
        if (res.body.length > 1) {
          List<dynamic> data = body["return"];
          List<Resturant> resturants =
              data.map((dynamic item) => Resturant.fromJson(item)).toList();
          return resturants;
        } else {
          return null;
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
