import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smartfoods/components/texts.dart';
import 'package:smartfoods/config/colors.dart';
import 'package:smartfoods/config/provider.dart';
import 'package:smartfoods/models/user.dart';
import 'package:smartfoods/screens/resturantsscreen.dart';
import 'package:smartfoods/services/loginAPI.dart';

class Snackbutton extends StatelessWidget {
  const Snackbutton({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required this.mailcontroller,
    @required this.passwordcontroller,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController mailcontroller;
  final TextEditingController passwordcontroller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 145,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: greenbuttoncolor,
      ),
      child: FlatButton(
        onPressed: () async {
          Loginapi x = Loginapi();

          // Validate returns true if the form is valid, or false
          // otherwise.
          if (_formKey.currentState.validate()) {
            print(mailcontroller.toString());

            Users user = Users(
              mailcontroller.text,
              passwordcontroller.text,
            );

            var signup = await x.login(user, context);

            if (signup["status"] == 200) {
              HapticFeedback.mediumImpact();
              Provider.of<Userprovider>(context, listen: false)
                  .setcategoryindex(0);

              Provider.of<Userprovider>(context, listen: false)
                  .loadcategoriesDetails();
              Provider.of<Userprovider>(context, listen: false)
                  .loadresturantDetails(0);
              Scaffold.of(context).showSnackBar(SnackBar(
                  elevation: 10,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  backgroundColor: accentcolor,
                  content: Container(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      signup["message"],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ))));

              Future.delayed(Duration(seconds: 2), () {
                // 5s over, navigate to a new page
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Resturantsscreen()));
              });
            } else {
              HapticFeedback.mediumImpact();
              Future.delayed(Duration(milliseconds: 30), () {
                // 5s over, navigate to a new page
                HapticFeedback.mediumImpact();
              });

              Scaffold.of(context).showSnackBar(SnackBar(
                  elevation: 10,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  backgroundColor: accentcolor,
                  content: Container(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      signup["message"],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ))));
            }
          } else {
            HapticFeedback.mediumImpact();
            Future.delayed(Duration(milliseconds: 50), () {
              // 5s over, navigate to a new page
              HapticFeedback.mediumImpact();
            });
          }
        },
        child: Normaltext(
          string: " دخول",
          color: Colors.white,
          fontsize: 20,
        ),
      ),
    );
  }

  AuthAPI() {}
}
