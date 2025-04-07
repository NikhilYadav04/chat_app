// ignore_for_file: must_be_immutable

import 'package:chat_app/pages/auth/login_page.dart';
import 'package:chat_app/shared/scale.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

late String email;
late String Password;
late String name;

Widget HeaderTextRegister(double height, double width, double textScaleFactor) {
  return Text(
    "Chat Bot",
    style: TextStyle(
        color: Colors.white,
        fontFamily: "Manrope",
        fontSize: responsiveFontSize(40, width, height, textScaleFactor),
        fontWeight: FontWeight.bold),
  );
}

Widget Text1Register(double height, double width, double textScaleFactor) {
  return Text(
    "Create your account to converse and discover.",
    style: TextStyle(
        color: Colors.grey,
        fontSize: responsiveFontSize(17, width, height, textScaleFactor),
        fontFamily: "Manrope"),
  );
}

Widget ImageRegister(double height, double width, double textScaleFactor) {
  return Image.asset(
    "assets/register_image.png",
    height: responsiveContainerSize(280, width, height),
    width: responsiveContainerSize(385, width, height),
  );
}

Widget NameField(TextEditingController RegisterNamecontroller, double height,
    double width, double textScaleFactor) {
  return Container(
      height: responsiveContainerSize(70, width, height),
      width: responsiveContainerSize(370, width, height),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        onChanged: (val) {
          name = val;
        },
        validator: (value) {
          if (value == null || value.isEmpty || value.length < 3) {
            return 'Please enter a valid name';
          }
          return null;
        },
        controller: RegisterNamecontroller,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefixIcon: Icon(
            Icons.perm_identity,
            color: Colors.yellow.shade800,
          ),
          label: Text(
            "Full Name",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Manrope",
                fontSize:
                    responsiveFontSize(17, width, height, textScaleFactor),
                fontWeight: FontWeight.bold),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  responsiveBorderRadius(4, width, height)),
              borderSide: BorderSide(
                  color: Colors.white,
                  width: responsiveBorderWidth(2, width, height))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  responsiveBorderRadius(4, width, height)),
              borderSide: BorderSide(
                  color: Colors.yellow.shade800,
                  width: responsiveBorderWidth(2, width, height))),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  responsiveBorderRadius(4, width, height)),
              borderSide: BorderSide(
                  color: Colors.red,
                  width: responsiveBorderWidth(2, width, height))),
        ),
      ));
}

Widget EmailField(TextEditingController RegisterEmailcontroller, double height,
    double width, double textScaleFactor) {
  return Container(
      height: responsiveContainerSize(70, width, height),
      width: responsiveContainerSize(370, width, height),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        onChanged: (val) {
          email = val;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter an email';
          }
          final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
          if (!emailRegExp.hasMatch(value)) {
            return 'Please enter a valid email';
          }
          return null;
        },
        controller: RegisterEmailcontroller,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefixIcon: Icon(
            Icons.email,
            color: Colors.yellow.shade800,
          ),
          label: Text(
            "Email",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Manrope",
                fontSize:
                    responsiveFontSize(17, width, height, textScaleFactor),
                fontWeight: FontWeight.bold),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  responsiveBorderRadius(4, width, height)),
              borderSide: BorderSide(
                  color: Colors.white,
                  width: responsiveBorderWidth(2, width, height))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  responsiveBorderRadius(4, width, height)),
              borderSide: BorderSide(
                  color: Colors.yellow.shade800,
                  width: responsiveBorderWidth(2, width, height))),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  responsiveBorderRadius(4, width, height)),
              borderSide: BorderSide(
                  color: Colors.red,
                  width: responsiveBorderWidth(2, width, height))),
        ),
      ));
}

class PasswordField extends StatefulWidget {
  TextEditingController passController;
  double height;
  double width;
  double textScaleFactor;
  PasswordField(
      {super.key,
      required this.passController,
      required this.height,
      required this.width,
      required this.textScaleFactor});

  @override
  State<PasswordField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordField> {
  bool show = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: responsiveContainerSize(70, widget.width, widget.height),
      width: responsiveContainerSize(370, widget.width, widget.height),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        onChanged: (val) {
          Password = val;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a password';
          }
          if (value.length < 6) {
            return 'Enter a longer password';
          }
          return null;
        },
        obscureText: show,
        controller: widget.passController,
        decoration: InputDecoration(
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                show = !show;
              });
            },
            child: show
                ? Icon(
                    Icons.visibility,
                    color: Colors.yellow.shade800,
                  )
                : Icon(
                    Icons.visibility_off,
                    color: Colors.yellow.shade800,
                  ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.yellow.shade800,
          ),
          label: Text(
            "Password",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Manrope",
                fontSize: responsiveFontSize(
                    17, widget.width, widget.height, widget.textScaleFactor),
                fontWeight: FontWeight.bold),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  responsiveBorderRadius(4, widget.width, widget.height)),
              borderSide: BorderSide(
                  color: Colors.white,
                  width:
                      responsiveBorderWidth(2, widget.width, widget.height))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  responsiveBorderRadius(4, widget.width, widget.height)),
              borderSide: BorderSide(
                  color: Colors.yellow.shade800,
                  width:
                      responsiveBorderWidth(2, widget.width, widget.height))),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  responsiveBorderRadius(4, widget.width, widget.height)),
              borderSide: BorderSide(
                  color: Colors.red,
                  width:
                      responsiveBorderWidth(2, widget.width, widget.height))),
        ),
      ),
    );
  }
}

Widget RegisterButton(
    BuildContext context, double height, double width, double textScaleFactor) {
  return Container(
    height: responsiveContainerSize(55, width, height),
    width: responsiveContainerSize(370, width, height),
    decoration: BoxDecoration(
        color: Colors.yellow.shade800,
        borderRadius:
            BorderRadius.circular(responsiveBorderRadius(20, width, height))),
    child: Center(
      child: Text(
        "Register",
        style: TextStyle(
            color: Colors.black,
            fontSize: responsiveFontSize(25, width, height, textScaleFactor),
            fontWeight: FontWeight.bold,
            fontFamily: "Mainrope"),
      ),
    ),
  );
}

Widget Text2Register(
    BuildContext context, double height, double width, double textScaleFactor) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          PageTransition(
              child: LoginPage(), type: PageTransitionType.leftToRight));
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?, ",
          style: TextStyle(
              color: Colors.grey,
              fontSize: responsiveFontSize(18, width, height, textScaleFactor),
              fontFamily: "Manrope"),
        ),
        Text(
          "Login Here",
          style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.grey,
              fontSize: responsiveFontSize(18, width, height, textScaleFactor),
              fontFamily: "Manrope"),
        )
      ],
    ),
  );
}
