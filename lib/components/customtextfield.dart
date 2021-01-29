import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:smartfoods/config/colors.dart';

import 'package:provider/provider.dart';
import 'package:smartfoods/config/fonts.dart';

class CustomTextfield extends StatelessWidget {
  final String hint, label;
  final Widget suffix;
  final IconData priffix;
  final TextEditingController controller;
  final bool isobscure, borderd;
  final int validator;
  final Function customvalidator;

  CustomTextfield(
      {Key key,
      this.hint,
      this.label,
      this.priffix = null,
      this.suffix = null,
      this.controller,
      this.isobscure = false,
      this.validator = null,
      this.customvalidator = null,
      this.borderd = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MultiValidator> validators = [
      MultiValidator([
        RequiredValidator(
          errorText: "هذا الحقل مطلوب",
        )
      ]),
      MultiValidator([
        RequiredValidator(
          errorText: "هذا الحقل مطلوب",
        ),
        EmailValidator(errorText: "هذا البريد غير صالح")
      ]),
      MultiValidator([
        RequiredValidator(errorText: "هذا الحقل مطلوب"),
        MinLengthValidator(8,
            errorText: 'يجب ان تتكون كلمة المرور على الاقل من 8 حروف'),
        PatternValidator(r'(?=.*?[#?!@$%^&*-])',
            errorText: "يجب تحتوي كلمة المرور على حرف خاص واحد على الاقل"),
      ]),
    ];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.black12,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 10),
          child: TextFormField(
              controller: controller,
              obscureText: isobscure,
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  // focusedBorder: borderd == true
                  //     ? OutlineInputBorder(
                  //         borderSide: new BorderSide(color: accentcolor))
                  //     : null,
                  // border: borderd == true
                  //     ? OutlineInputBorder(
                  //         borderSide: new BorderSide(color: accentcolor))
                  //     : null,
                  hintText: hint,
                  hintStyle: TextStyle(color: maintextcolor.withOpacity(.6),fontSize: 20),
                  // labelText: label,
                  labelStyle:
                      TextStyle(color: textcolor, fontFamily: arabicfont),
                  // prefixIcon: Icon(
                  //   priffix,
                  //   color: accentcolor,
                  // ),
                  prefixText: ' ',
                  suffix: suffix,
                  suffixStyle:
                      TextStyle(color: accentcolor, fontFamily: arabicfont)),
              validator: validators[validator]),
        ),
      ),
    );
  }
}
