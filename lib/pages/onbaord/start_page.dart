import 'package:chat_app/pages/auth/login_page.dart';
import 'package:chat_app/shared/scale.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Center(
                child: Image.asset(
              "assets/chat_image.png",
              height: responsiveContainerSize(430, width, height),
              width: responsiveContainerSize(430, width, height),
            )),
            SizedBox(
              height: responsiveContainerSize(30, width, height),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 25 * horizontalPaddingFactor(width)),
              alignment: Alignment.bottomLeft,
              child: Text(
                "It's easy talking to \nyour friends with \nChat Bot",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Manrope",
                    fontSize:
                        responsiveFontSize(34, width, height, textScaleFactor)),
              ),
            ),
            SizedBox(
              height: responsiveContainerSize(25, width, height),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 25 * horizontalPaddingFactor(width)),
              alignment: Alignment.bottomLeft,
              child: Text(
                "Make Groups Easily With your Friends \nAnd Chat",
                style: TextStyle(
                    color: Colors.grey,
                    fontFamily: "Manrope",
                    fontSize:
                        responsiveFontSize(18, width, height, textScaleFactor)),
              ),
            ),
            SizedBox(
              height: responsiveContainerSize(40, width, height),
            ),
            button(width, height, textScaleFactor)
          ],
        ),
      ),
    ));
  }

  Widget button(double width, double height, double textScaleFactor) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: LoginPage(), type: PageTransitionType.bottomToTop));
      },
      child: Container(
        width: responsiveContainerSize(380, width, height),
        height: responsiveContainerSize(70, width, height),
        decoration: BoxDecoration(
            color: Color.fromARGB(253, 228, 218, 184),
            borderRadius: BorderRadius.circular(
                responsiveBorderRadius(30, width, height))),
        child: Center(
          child: Text(
            "Get Started",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Manrope",
                fontWeight: FontWeight.bold,
                fontSize:
                    responsiveFontSize(28, width, height, textScaleFactor)),
          ),
        ),
      ),
    );
  }
}
