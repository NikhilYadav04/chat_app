import 'package:chat_app/pages/auth/register_screen_page.dart';
import 'package:chat_app/shared/scale.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

late String Loginemail;
late String Loginpassword;

Widget HeaderText(double height, double width, double textScaleFactor) {
  return Text(
    "Chat Bot",
    style: TextStyle(
        color: Colors.white,
        fontFamily: "Manrope",
        fontSize: responsiveFontSize(40, width, height, textScaleFactor),
        fontWeight: FontWeight.bold),
  );
}

Widget Text1(double height, double width, double textScaleFactor) {
  return Text(
    "Login now to see what they are talking !!",
    style: TextStyle(
        color: Colors.grey,
        fontSize: responsiveFontSize(19, width, height, textScaleFactor),
        fontFamily: "Manrope"),
  );
}

Widget LoginImage(double height, double width) {
  return Image.asset(
    "assets/login_image.png",
    height: responsiveContainerSize(350, width, height),
    width: responsiveContainerSize(382, width, height),
  );
}

// ignore: must_be_immutable
class PasswordTextField extends StatefulWidget {
  TextEditingController passController;
  double height;
  double width;
  double textScaleFactor;
  PasswordTextField(
      {super.key,
      required this.passController,
      required this.height,
      required this.width,
      required this.textScaleFactor});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool show = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: responsiveContainerSize(70, widget.width, widget.height),
      width: responsiveContainerSize(370, widget.width, widget.height),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        onChanged: (value) {
          Loginpassword = value;
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

Widget EmailTextField(TextEditingController emailController, double height,
    double width, double textScaleFactor) {
  return Container(
      height: responsiveContainerSize(70, width, height),
      width: responsiveContainerSize(370, width, height),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        onChanged: (value) {
          Loginemail = value;
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
        controller: emailController,
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

Widget LoginButton(
    BuildContext context, double height, double width, double textScaleFactor) {
  return Container(
    height: responsiveContainerSize(55, width, height),
    width: responsiveBorderWidth(370, width, height),
    decoration: BoxDecoration(
        color: Colors.yellow.shade800,
        borderRadius:
            BorderRadius.circular(responsiveBorderRadius(20, width, height))),
    child: Center(
      child: Text(
        "Sign In",
        style: TextStyle(
            color: Colors.black,
            fontSize: responsiveFontSize(25, width, height, textScaleFactor),
            fontWeight: FontWeight.bold,
            fontFamily: "Mainrope"),
      ),
    ),
  );
}

Widget Text2(
    BuildContext context, double height, double width, double textScaleFactor) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          PageTransition(
              child: RegisterScreenPage(),
              type: PageTransitionType.rightToLeft));
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?, ",
          style: TextStyle(
              color: Colors.grey,
              fontSize: responsiveFontSize(19, width, height, textScaleFactor),
              fontFamily: "Manrope"),
        ),
        Text(
          "Register Here",
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
