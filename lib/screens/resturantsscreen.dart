import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smartfoods/components/categorylist.dart';
import 'package:smartfoods/components/resturantslist.dart';
import 'package:smartfoods/components/texts.dart';
import 'package:smartfoods/config/colors.dart';
import 'package:smartfoods/config/mediaqueryconfig.dart';
import 'package:smartfoods/config/provider.dart';
import 'package:smartfoods/screens/signinscreen.dart';
import 'package:smartfoods/services/loginAPI.dart';

class Resturantsscreen extends StatefulWidget {
  @override
  _ResturantsscreenState createState() => _ResturantsscreenState();
}

class _ResturantsscreenState extends State<Resturantsscreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () async {
                    HapticFeedback.heavyImpact();
                    Provider.of<Userprovider>(context, listen: false)
                        .killcategorystrem();
                    Provider.of<Userprovider>(context, listen: false)
                        .killresturantstrem();
                    await Loginapi().logout(context).then((value) =>
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signinscreen())));
                  },
                ),
              ),
              Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: textcolor,
                  backgroundImage: AssetImage("assets/nopic.jpg"),
                ),
              ),
              Center(
                child: Normaltext(
                  string: Provider.of<Userprovider>(context).username,
                  fontsize: 25,
                  color: maintextcolor,
                ),
              )
            ],
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(104),
          child: Container(
            decoration: BoxDecoration(
                color: accentcolor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: AppBar(
                elevation: 0,
                flexibleSpace: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Center(child: Icon(Icons.search)),
                    )
                  ],
                ),
                iconTheme: IconThemeData(color: maintextcolor),
                backgroundColor: accentcolor,
                title: Normaltext(
                  string: "الرئيسية",
                  fontsize: 25,
                  fontWeight: FontWeight.bold,
                  color: maintextcolor,
                ),
                centerTitle: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 33),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Normaltext(
                        padding: 0,
                        string: "مرحبا",
                        fontsize: 27,
                        color: maintextcolor,
                      ),
                      Normaltext(
                        padding: 0,
                        string: "عن ماذا تبحث ؟",
                        fontsize: 27,
                        color: maintextcolor,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                    color: Color(0xffFCFCFC),
                    height: 40,
                    //color: Theme.of(context).primaryColor,
                    child: StreamBuilder(
                      stream: Provider.of<Userprovider>(context)
                          .categoriesstream
                          .stream,
                      //Here we will call our getData() method,
                      builder: (context, snapshot) {
                        //the future builder is very intersting to use when you work with api
                        if (snapshot.hasData) {
                          return Categorylist(notliveleague: snapshot.data);
                        } else {
                          return Center(
                              child: Theme(
                            data: Theme.of(context)
                                .copyWith(accentColor: accentcolor),
                            child: new CircularProgressIndicator(
                              backgroundColor: Colors.black26,
                            ),
                          ));
                        }
                      }, // here we will buil the app layout
                    )),
              ),
              Container(
                  color: Color(0xffFCFCFC),
                  // height: 40,
                  //color: Theme.of(context).primaryColor,
                  child: StreamBuilder(
                    stream: Provider.of<Userprovider>(context)
                        .resturantstream
                        .stream,
                    //Here we will call our getData() method,
                    builder: (context, snapshot) {
                      //the future builder is very intersting to use when you work with api
                      if (snapshot.hasData) {
                        return Resturantslist(restrants: snapshot.data);
                      } else {
                        return Center(
                            child: Theme(
                          data: Theme.of(context)
                              .copyWith(accentColor: accentcolor),
                          child: new CircularProgressIndicator(
                            backgroundColor: Colors.black26,
                          ),
                        ));
                      }
                    }, // here we will buil the app layout
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
