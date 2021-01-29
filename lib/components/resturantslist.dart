import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfoods/components/restrurantcard.dart';
import 'package:smartfoods/components/productcard.dart';
import 'package:smartfoods/models/resturant.dart';

class Resturantslist extends StatefulWidget {
  final List<Resturant> restrants;

  const Resturantslist({Key key, this.restrants}) : super(key: key);

  @override
  _ResturantslistState createState() => _ResturantslistState();
}

class _ResturantslistState extends State<Resturantslist> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.restrants.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Resturantcard(
              resturant: i,
            );
          },
        );
      }).toList(),
    );
  }
}
