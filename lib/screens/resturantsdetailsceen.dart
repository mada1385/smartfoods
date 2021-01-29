import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:smartfoods/components/texts.dart';
import 'package:smartfoods/components/productcard.dart';
import 'package:smartfoods/config/colors.dart';
import 'package:smartfoods/models/resturant.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Resturantdetailscreen extends StatelessWidget {
  final Resturant resturant;
  final bool open;
  final String address;

  const Resturantdetailscreen(
      {Key key, this.resturant, this.open = true, this.address = ""})
      : super(key: key);
  double sort() {
    double hight;
    String number = (resturant.products.length / 2).toStringAsFixed(0);
    print("number $number");
    hight = double.parse(number) * 200;
    print(" hight $hight");

    return hight;
  }

  String convert(String usertime) {
    var arr = usertime.split(' ');
    if (arr[1] == "AM") {
      return usertime.replaceAll(RegExp('AM'), 'ص');
    } else {
      return usertime.replaceAll(RegExp('PM'), 'م');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: NestedScrollView(headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverPersistentHeader(
              delegate: DemoHeader(resturant),
              pinned: true,
            ),
          ),
        ];
      }, body: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            slivers: [
              SliverOverlapInjector(
                // This is the flip side of the SliverOverlapAbsorber above.
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: 16, top: 20, end: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Normaltext(
                            padding: 0,
                            string: resturant.type,
                            fontsize: 22,
                            color: detailscolor,
                            fontWeight: FontWeight.bold,
                          ),
                          Row(
                            children: address == ""
                                ? []
                                : [
                                    Icon(
                                      Icons.location_on,
                                      color: redtextcolor,
                                      size: 20,
                                    ),
                                    Normaltext(
                                      padding: 8,
                                      string: address,
                                      fontsize: 19,
                                      color: detailscolor,
                                    ),
                                  ],
                          ),
                          Divider(
                            color: Colors.black12,
                            endIndent: 36,
                            indent: 20,
                            height: 50,
                            thickness: 2,
                          ),
                          Row(
                            children: open
                                ? [
                                    Icon(
                                      Icons.circle,
                                      color: statuscolor,
                                      size: 20,
                                    ),
                                    Normaltext(
                                      padding: 8,
                                      string: "مفتوح - من",
                                      fontsize: 19,
                                      color: detailscolor,
                                    ),
                                    Normaltext(
                                      padding: 0,
                                      string: convert(resturant.open),
                                      fontsize: 19,
                                      color: detailscolor,
                                    ),
                                    Normaltext(
                                      padding: 8,
                                      string: " الى",
                                      fontsize: 19,
                                      color: detailscolor,
                                    ),
                                    Normaltext(
                                      padding: 0,
                                      string: convert(resturant.close),
                                      fontsize: 19,
                                      color: detailscolor,
                                    ),
                                  ]
                                : [
                                    Icon(
                                      Icons.circle,
                                      color: redtextcolor,
                                      size: 20,
                                    ),
                                    Normaltext(
                                      padding: 8,
                                      string: "مغلق - سيفتح من",
                                      fontsize: 19,
                                      color: detailscolor,
                                    ),
                                    Normaltext(
                                      padding: 0,
                                      string: convert(resturant.open),
                                      fontsize: 19,
                                      color: detailscolor,
                                    ),
                                    Normaltext(
                                      padding: 8,
                                      string: " الى",
                                      fontsize: 19,
                                      color: detailscolor,
                                    ),
                                    Normaltext(
                                      padding: 0,
                                      string: convert(resturant.close),
                                      fontsize: 19,
                                      color: detailscolor,
                                    ),
                                  ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: resturant.delivery == 0
                                ? []
                                : [
                                    Icon(
                                      Icons.delivery_dining,
                                      color: detailscolor,
                                      size: 25,
                                    ),
                                    Normaltext(
                                      padding: 8,
                                      string: "متاح للتوصبل",
                                      fontsize: 18,
                                      color: detailscolor,
                                    ),
                                  ],
                          ),
                          Divider(
                            color: Colors.black12,
                            endIndent: 36,
                            indent: 20,
                            height: 50,
                            thickness: 2,
                          ),
                          Normaltext(
                            padding: 0,
                            string: "الاصناف",
                            fontsize: 25,
                            color: maintextcolor,
                          ),
                          Container(
                            height: sort(),
                            child: GridView.count(
                                // crossAxisSpacing: 20,
                                // shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                children: resturant.products.map((w) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Productcard(
                                        product: w,
                                      );
                                    },
                                  );
                                }).toList()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ))),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class DemoHeader extends SliverPersistentHeaderDelegate {
  final Resturant resturant;

  DemoHeader(this.resturant);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    debugPrint(shrinkOffset.toString());
    return Stack(
      children: [
        Container(
            constraints: new BoxConstraints.expand(
              height: 212,
            ),
            alignment: Alignment.bottomRight,
            padding: new EdgeInsets.symmetric(horizontal: 34, vertical: 13),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new NetworkImageWithRetry(
                  resturant.image,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 39),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Normaltext(
                    string: resturant.title,
                    fontsize: 25,
                    color: backgroundcolor,
                  ),
                  SmoothStarRating(
                      allowHalfRating: true,
                      starCount: 5,
                      rating: resturant.rate,
                      size: 12,
                      isReadOnly: true,
                      color: accentcolor,
                      borderColor: accentcolor,
                      spacing: 0.0),
                ],
              ),
            )),
        // SizedBox(
        //   height: 50,
        // ),
        Positioned(
          bottom: 0,
          child: Container(
            height: 20,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: backgroundcolor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 200;

  @override
  double get minExtent => 120;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
