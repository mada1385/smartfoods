import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smartfoods/components/texts.dart';
import 'package:smartfoods/config/colors.dart';
import 'package:smartfoods/config/provider.dart';
import 'package:smartfoods/models/news.dart';

class Categorylist extends StatefulWidget {
  const Categorylist({
    Key key,
    @required this.notliveleague,
  }) : super(key: key);

  final List<Category> notliveleague;

  @override
  _CategorylistState createState() => _CategorylistState();
}

class _CategorylistState extends State<Categorylist> {
  List<Category> addlist() {
    List<Category> categories = [Category("الجميع", 0)];
    for (var i in widget.notliveleague) {
      categories.add(i);
    }
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        // reverse: true,
        scrollDirection: Axis.horizontal,
        itemCount: addlist().length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              setState(() {
                Provider.of<Userprovider>(context, listen: false)
                    .setcategoryindex(index);
                Provider.of<Userprovider>(context, listen: false)
                    .loadresturantDetails(addlist()[
                            Provider.of<Userprovider>(context, listen: false)
                                .categoryindex]
                        .id);
              });
            },
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Container(
                width: 110,
                height: 35,
                // padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: redtextcolor),
                  color:
                      Provider.of<Userprovider>(context).categoryindex == index
                          ? redtextcolor
                          : Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Normaltext(
                      string: addlist()[index].title,
                      fontsize: 10,
                      fontWeight: FontWeight.w500,
                      color: Provider.of<Userprovider>(context).categoryindex ==
                              index
                          ? Colors.white
                          : redtextcolor,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
