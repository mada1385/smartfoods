import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smartfoods/components/customtextfield.dart';
import 'package:smartfoods/components/snackbutton.dart';
import 'package:smartfoods/components/texts.dart';
import 'package:smartfoods/config/colors.dart';
import 'package:smartfoods/config/mediaqueryconfig.dart';
import 'package:smartfoods/config/provider.dart';
import 'package:smartfoods/models/user.dart';
import 'package:smartfoods/screens/resturantsscreen.dart';

class Signinscreen extends StatefulWidget {
  @override
  _SigninscreenState createState() => _SigninscreenState();
}

class _SigninscreenState extends State<Signinscreen> {
  final mailcontroller = TextEditingController(),
      passwordcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isobsecurepass = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: 40,
                ),
                child: Container(
                  // height: 149,
                  width: double.infinity,
                  child: Center(
                    child: Image.asset(
                      'assets/Group 119.png',
                      height: 243,
                      width: 148,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 35, start: 16),
                child: Row(
                  children: [
                    Normaltext(
                      string: "تسجيل الدخول",
                      fontsize: 25,
                      color: maintextcolor,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 35),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // SizedBox(
                      //   height: SizeConfig.blockSizeVertical * 5,
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 5),
                        child: CustomTextfield(
                            controller: mailcontroller,
                            hint: "رقم الهاتف",
                            isobscure: false,
                            label: "رقم الهاتف",
                            // priffix: Icons.local_phone,
                            validator: 0),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: Container(
                          child: CustomTextfield(
                            suffix: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isobsecurepass = !isobsecurepass;
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 20),
                                child: Icon(
                                  Icons.remove_red_eye,
                                  color: maintextcolor.withOpacity(.6),
                                  size: 20,
                                ),
                              ),
                            ),
                            controller: passwordcontroller,
                            hint: "كلمة المرور",
                            isobscure: isobsecurepass,
                            // label: "كلمة المرور",
                            // priffix: Icons.lock_outline,
                            validator: 0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(top: 20),
                        child: Center(
                          child: Snackbutton(
                              formKey: _formKey,
                              mailcontroller: mailcontroller,
                              passwordcontroller: passwordcontroller),
                        ),
                      ),

                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
