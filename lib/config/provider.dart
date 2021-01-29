import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smartfoods/services/categoryAPI.dart';
import 'package:smartfoods/services/resturantAPI.dart';

class Userprovider extends ChangeNotifier {
  StreamController categoriesstream;
  StreamController resturantstream;
  String username;
  int userID;

  int categoryindex = 0;
  setcategoryindex(int userindex) {
    categoryindex = userindex;
    notifyListeners();
  }

  setuserID(int userindex) {
    userID = userindex;
    notifyListeners();
  }

  setusername(String userindex) {
    username = userindex;
    notifyListeners();
  }

  killresturantstrem() {
    resturantstream.add(null);
    notifyListeners();
  }

  killcategorystrem() {
    categoriesstream.add(null);
    notifyListeners();
  }

  loadcategoriesDetails() {
    categoriesstream = new StreamController();
    CategoryAPI().getAllcategories().then((res) {
      print("favgames updated from provider");
      categoriesstream.add(res);
      notifyListeners();
      return res;
    });
  }

  loadresturantDetails(int id) {
    resturantstream = new StreamController();
    ResturantAPI().getAllresturant(id).then((res) {
      print("favgames updated from provider");
      resturantstream.add(res);
      notifyListeners();
      return res;
    });
  }
}
