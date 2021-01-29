import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:smartfoods/components/texts.dart';
import 'package:smartfoods/config/colors.dart';

import 'package:smartfoods/config/mediaqueryconfig.dart';
import 'package:smartfoods/models/products.dart';

class Productcard extends StatelessWidget {
  final Product product;

  const Productcard({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: 100,
          height: 200,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  color: Colors.black54,
                  offset: Offset(0, .75),
                )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  decoration: BoxDecoration(
                    image: new DecorationImage(
                        image: new NetworkImageWithRetry(
                          product.image,
                        ),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter),
                  ),
                  // child: Newscarddetails(news: news),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Normaltext(
                    padding: 10,
                    string: product.title,
                    color: maintextcolor,
                    fontsize: 15,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Normaltext(
                        padding: 10,
                        string: product.price,
                        color: detailscolor,
                        fontsize: 15,
                      ),
                      Normaltext(
                        padding: 10,
                        string: "ج.م",
                        color: detailscolor,
                        fontsize: 15,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 10),
                    child: Icon(
                      Icons.shopping_basket,
                      color: redtextcolor,
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
