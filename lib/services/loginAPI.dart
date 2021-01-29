import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfoods/config/provider.dart';
import 'package:smartfoods/models/user.dart';

class Loginapi {
  Future login(Users x, BuildContext context) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final msg = jsonEncode({
      "mobile": x.phone,
      "password": x.password,
      "access_key": "Gdka52DASWE3DSasWE742Wq",
      "access_password": "yH52dDDF85sddEWqPNV7D12sW5e"
    });
    try {
      final signup = await post("http://otlob.accuragroup-eg.net/api/login",
          body: msg, headers: headers);
      var body = jsonDecode(signup.body);
      print(body);
      if (body["status"] == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString("username", body["return"]["mobile"]);
        await preferences.setString("id", body["return"]["id"].toString());

        Provider.of<Userprovider>(context, listen: false)
            .setusername(body["return"]["mobile"]);
        Provider.of<Userprovider>(context, listen: false)
            .setuserID(body["return"]["id"]);

        return body;
      } else {
        return body;
      }
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString("username", null);
    preferences.setString("id", null);

    Provider.of<Userprovider>(context, listen: false).setuserID(null);
  }
}
