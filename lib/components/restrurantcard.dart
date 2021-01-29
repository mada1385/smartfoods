import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:smartfoods/components/texts.dart';
import 'package:smartfoods/config/colors.dart';
import 'package:smartfoods/config/mediaqueryconfig.dart';
import 'package:smartfoods/models/resturant.dart';

import 'package:smartfoods/screens/resturantsdetailsceen.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Resturantcard extends StatefulWidget {
  final Resturant resturant;
// create this variable

  const Resturantcard({Key key, this.resturant}) : super(key: key);

  @override
  _ResturantcardState createState() => _ResturantcardState();
}

class _ResturantcardState extends State<Resturantcard> {
  String _address = "";
  bool isopened = true;

  void format() {
    DateTime now = new DateTime.now();
    DateFormat formatter = DateFormat("h a");
    String hours;
    String close = widget.resturant.close;
    String open = widget.resturant.open;

    print(now);
    setState(() {
      hours = formatter.format(now);
    });
    print(hours);
    if (convert(hours) >= convert(open) && convert(hours) < convert(close)) {
      setState(() {
        isopened = true;
      });
    } else {
      isopened = false;
    }
  }

  double convert(String stringtime) {
    double time;
    var arr = stringtime.split(' ');
    if (arr[1] == "PM") {
      setState(() {
        time = double.parse(arr[0]) + 12;
      });
    } else {
      setState(() {
        time = double.parse(arr[0]);
      });
    }
    return time;
  }

  void _getPlace() async {
    var arr = widget.resturant.location.split(',');
    print(arr);

    print(arr);
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          double.parse(arr[0]), double.parse(arr[1]),
          localeIdentifier: 'ar');

      // this is all you need
      Placemark placeMark = placemarks[0];
      String name = placeMark.name;
      String subLocality = placeMark.subLocality;
      String locality = placeMark.locality;
      String administrativeArea = placeMark.administrativeArea;
      String postalCode = placeMark.postalCode;
      String country = placeMark.country;
      String address = "${name}, ${country}";

      print(address);

      setState(() {
        _address = address; // update _address
      });
    } on Exception catch (e) {
      setState(() {
        _address = ""; // update _address
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _getPlace();
    format();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new Resturantdetailscreen(
                      address: _address,
                      open: isopened,
                      resturant: widget.resturant,
                    )));
      },
      child: Container(
          height: 125,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Colors.white,
            // boxShadow: [
            //   BoxShadow(
            //     blurRadius: 2,
            //     color: Colors.black12,
            //     offset: Offset(0, .75),
            //   )
            // ]
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    child: new Image(
                      image: new NetworkImageWithRetry(
                        widget.resturant.image,
                      ),
                      fit: BoxFit.cover,
                      height: 79,
                      width: SizeConfig.blockSizeHorizontal * 27,
                    )),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.85,
                      child: Cardtitle(
                        news: widget.resturant.title,
                        fontsize: 20,
                      ),
                    ),
                    SmoothStarRating(
                        allowHalfRating: true,
                        starCount: 5,
                        rating: widget.resturant.rate,
                        size: 12,
                        isReadOnly: true,
                        color: accentcolor,
                        borderColor: accentcolor,
                        spacing: 0.0),
                    Normaltext(
                      padding: 0,
                      string: widget.resturant.type,
                      fontsize: 12,
                      color: detailscolor,
                    ),
                    Row(
                      children: _address == ""
                          ? []
                          : [
                              Icon(
                                Icons.location_on,
                                color: detailscolor,
                                size: 15,
                              ),
                              Normaltext(
                                padding: 0,
                                string: _address,
                                fontsize: 12,
                                color: detailscolor,
                              ),
                            ],
                    ),
                    Row(
                      children: widget.resturant.delivery == 0
                          ? []
                          : [
                              Icon(
                                Icons.delivery_dining,
                                color: detailscolor,
                                size: 15,
                              ),
                              Normaltext(
                                padding: 0,
                                string: "متاح للتوصبل",
                                fontsize: 12,
                                color: detailscolor,
                              ),
                            ],
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
