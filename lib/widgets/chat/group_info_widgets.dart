import 'package:bloc/bloc.dart';
import 'package:chat_app/Bloc/Chat/bloc/chatpage_bloc.dart';
import 'package:chat_app/shared/colors.dart';
import 'package:chat_app/shared/scale.dart';
import 'package:chat_app/widgets/chat/search_page_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget AppBGroupInfo(
    BuildContext context,
    double width,
    double height,
    double textScaleFactor,
    Bloc groupBloc,
    String groupName,
    String groupID) {
  return AppBar(
    automaticallyImplyLeading: false,
    leading: IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
        size: responsiveContainerSize(24, width, height),
      ),
    ),
    toolbarHeight: responsiveContainerSize(70, width, height),
    elevation: 0,
    backgroundColor: Colors.black,
    centerTitle: true,
    title: Text(
      "Group Info",
      style: TextStyle(
          color: Colors.white,
          fontFamily: "Manrope",
          fontSize: responsiveFontSize(30, width, height, textScaleFactor),
          fontWeight: FontWeight.bold),
    ),
    actions: [
      IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      "Exit",
                      style: TextStyle(
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.bold,
                          fontSize: responsiveFontSize(
                              22, width, height, textScaleFactor)),
                    ),
                    content: Text(
                      "Are you sure you want to leave the group?",
                      style: TextStyle(
                          fontFamily: "Manrope",
                          fontSize: responsiveFontSize(
                              16, width, height, textScaleFactor),
                          fontWeight: FontWeight.w500),
                    ),
                    actions: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          groupBloc.add(exit_group_event(
                              groupID: groupID,
                              groupName: groupName,
                              userID: FirebaseAuth.instance.currentUser!.uid,
                              userName: search_name));
                        },
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: responsiveContainerSize(28, width, height),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: responsiveContainerSize(28, width, height),
                        ),
                      )
                    ],
                  );
                });
          },
          icon: Icon(
            Icons.exit_to_app,
            size: responsiveContainerSize(30, width, height),
            color: Colors.white,
          ))
    ],
  );
}

Widget AdminBox(double width, double height, double textScaleFactor,
    String admin, String GroupName) {
  return Container(
    padding: EdgeInsets.symmetric(
        vertical: 10 * verticalPaddingFactor(height),
        horizontal: 5 * horizontalPaddingFactor(width)),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          responsiveBorderRadius(12, width, height),
        ),
        color: Colors.orangeAccent.shade100),
    child: ListTile(
      leading: CircleAvatar(
        radius: responsiveBorderRadius(25, width, height),
        backgroundColor: Color.fromARGB(255, 205, 191, 67),
        child: Center(
          child: Text(
            GroupName.substring(0, 1).toUpperCase(),
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Manrope",
                fontWeight: FontWeight.bold,
                fontSize:
                    responsiveFontSize(22, width, height, textScaleFactor)),
          ),
        ),
      ),
      title: Text(
        "Group : ${GroupName}",
        style: TextStyle(
            color: Colors.black,
            fontFamily: "Manrope",
            fontWeight: FontWeight.bold,
            fontSize: responsiveFontSize(18, width, height, textScaleFactor)),
      ),
      subtitle: Text(
        "Admin : ${admin}",
        style: TextStyle(
            color: Colors.grey.shade800,
            fontFamily: "Manrope",
            fontWeight: FontWeight.bold,
            fontSize: responsiveFontSize(18, width, height, textScaleFactor)),
      ),
    ),
  );
}

Widget MemberBox(double width, double height, double textScaleFactor,
    Stream members, BuildContext context, String admin) {
  return StreamBuilder(
      stream: members,
      builder: (context, AsyncSnapshot snapshots) {
        if (snapshots.connectionState == ConnectionState.active) {
          if (snapshots.hasData) {
            if (snapshots.data["members"].length != 0) {
              return Container(
                height: 400,
                child: ListView.builder(
                    itemCount: snapshots.data["members"].length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10 * verticalPaddingFactor(height),
                            horizontal: 5 * horizontalPaddingFactor(width)),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: responsiveBorderRadius(25, width, height),
                            backgroundColor: Color.fromARGB(255, 205, 191, 67),
                            child: Center(
                              child: Text(
                                snapshots.data["members"][index]
                                    .substring(29, 30)
                                    .toUpperCase(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Manrope",
                                    fontWeight: FontWeight.bold,
                                    fontSize: responsiveFontSize(
                                        22, width, height, textScaleFactor)),
                              ),
                            ),
                          ),
                          title: Text(
                            snapshots.data["members"][index].substring(
                                snapshots.data["members"][index].indexOf("_") +
                                    1),
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Manrope",
                                fontWeight: FontWeight.bold,
                                fontSize: responsiveFontSize(
                                    20, width, height, textScaleFactor)),
                          ),
                          subtitle: Text(
                            snapshots.data["members"][index].substring(0,
                                snapshots.data["members"][index].indexOf("_")),
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontFamily: "Manrope",
                                fontWeight: FontWeight.bold,
                                fontSize: responsiveFontSize(
                                    15, width, height, textScaleFactor)),
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return Text("No members found");
            }
          } else {
            return Text("No data found");
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: OrangeColor,
            ),
          );
        }
      });
}
