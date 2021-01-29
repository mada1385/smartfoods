import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfoods/config/mediaqueryconfig.dart';
import 'package:smartfoods/config/provider.dart';
import 'package:smartfoods/screens/resturantsscreen.dart';
import 'package:smartfoods/screens/signinscreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> opacity;
  AnimationController controller;
  void logincheck() async {
    SharedPreferences p = await SharedPreferences.getInstance();

    String y = await p.get("username");
    String z = await p.get("id");

    if (z != null) {
      Provider.of<Userprovider>(context, listen: false).setuserID(
        int.parse(z),
      );
      Provider.of<Userprovider>(context, listen: false).setusername(
        y,
      );
    } else {
      Provider.of<Userprovider>(context, listen: false).setusername(null);
    }
    print(
        "provider from token check ${Provider.of<Userprovider>(context, listen: false).username}");
    print(
        "provider from id check ${Provider.of<Userprovider>(context, listen: false).userID}");
  }

  @override
  void initState() {
    logincheck();
    Provider.of<Userprovider>(context, listen: false).loadcategoriesDetails();
    Provider.of<Userprovider>(context, listen: false).loadresturantDetails(0);

    // Provider.of<Userprovider>(context, listen: false).getfav();
    super.initState();

    controller = AnimationController(
        duration: Duration(milliseconds: 2500), vsync: this);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward().then((_) {
      navigationPage();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void navigationPage() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Provider.of<Userprovider>(context, listen: false).username ==
                        null
                    ? Signinscreen()
                    : Resturantsscreen()));
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: new Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage(
                "assets/Splash – 1.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Opacity(
              opacity: opacity.value,
              child: new Image.asset(
                'assets/Group 119@2x.png',
                height: 366,
                width: 223,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
