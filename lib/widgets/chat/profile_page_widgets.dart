import 'package:chat_app/shared/scale.dart';
import 'package:chat_app/widgets/chat/search_page_widgets.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget ProfileAppBar(
     double width, double height, double textScaleFactor,BuildContext context) {
  return AppBar(
    backgroundColor: Colors.black,
    automaticallyImplyLeading: false,
    leading: InkWell(
       onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        Icons.arrow_back,
        color: Colors.white,
        size: responsiveFontSize(28, width, height, textScaleFactor),
      ),
    ),
    elevation: 0,
    toolbarHeight: responsiveContainerSize(70, width, height),
    centerTitle: true,
    title: Text(
      "Profile",
      style: TextStyle(
          fontFamily: "Manrope",
          fontSize: responsiveFontSize(36, width, height, textScaleFactor),
          fontWeight: FontWeight.bold,
          color: Colors.white),
    ),
  );
}

Widget IconProfile(double width, double height) {
  return Icon(
    Icons.account_circle,
    size: responsiveContainerSize(180, width, height),
  );
}

Widget Text1(double height, double width, double textScaleFactor, name) {
  search_name = name;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Full Name",
        style: TextStyle(
            color: Colors.grey.shade700,
            fontFamily: "Manrope",
            fontSize: responsiveFontSize(22, width, height, textScaleFactor)),
      ),
      Text(
        "${name}",
        style: TextStyle(
            color: Colors.grey.shade700,
            fontFamily: "Manrope",
            fontSize: responsiveFontSize(22, width, height, textScaleFactor)),
      )
    ],
  );
}

Widget Text2(double height, double width, double textScaleFactor, email) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Email",
        style: TextStyle(
            color: Colors.grey.shade700,
            fontFamily: "Manrope",
            fontSize: responsiveFontSize(22, width, height, textScaleFactor)),
      ),
      Text(
        "${email}",
        style: TextStyle(
            color: Colors.grey.shade700,
            fontFamily: "Manrope",
            fontSize: responsiveFontSize(22, width, height, textScaleFactor)),
      )
    ],
  );
}
