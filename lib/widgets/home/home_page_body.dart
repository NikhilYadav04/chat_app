import 'package:chat_app/shared/colors.dart';
import 'package:chat_app/shared/scale.dart';
import 'package:chat_app/widgets/chat/group_tile.dart';
import 'package:flutter/material.dart';

Widget groupList(
    Stream? groups, double width, double height, double textScaleFactor) {
  return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshots) {
        if (snapshots.connectionState == ConnectionState.active) {
          if (snapshots.hasData) {
            if (snapshots.data["groups"].length != 0) {
              return ListView.builder(
                  itemCount: snapshots.data["groups"].length,
                  itemBuilder: (context, index) {
                    int newIndex = snapshots.data["groups"].length - index - 1;
                    return GroupTile(
                        groupID: getID(snapshots.data["groups"][newIndex]),
                        groupName: getName(snapshots.data["groups"][newIndex]),
                        userName: snapshots.data["fullName"]);
                  });

              // return Text("hello");
            } else {
              return Empty(width, height, textScaleFactor);
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: OrangeColor,
              ),
            );
          }
        } else {
          return Center(
              child: CircularProgressIndicator(
            color: OrangeColor,
          ));
        }
      });
}

Widget Empty(double width, double height, double textScaleFactor) {
  return Container(
    padding: EdgeInsets.symmetric(
        vertical: 230 * verticalPaddingFactor(height),
        horizontal: 10 * horizontalPaddingFactor(width)),
    child: Center(
      child: Column(
        children: [
          Icon(
            Icons.add_circle,
            color: Colors.grey.shade700,
            size: responsiveContainerSize(80, width, height),
          ),
          SizedBox(
            height: responsiveContainerSize(18, width, height),
          ),
          Text(
            "You've not joined any groups, tap on the add icon to now create a group or also search from the top search button.",
            style: TextStyle(
                color: Colors.grey.shade700,
                fontFamily: "Manrope",
                fontWeight: FontWeight.bold,
                fontSize:
                    responsiveFontSize(14, width, height, textScaleFactor)),
          )
        ],
      ),
    ),
  );
}

// to separate id from group ID
String getID(String id) {
  return id.substring(0, id.indexOf("_"));
}

// to separate name from group ID
String getName(String id) {
  return id.substring(id.indexOf("_") + 1);
}
