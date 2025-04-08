import 'package:bloc/bloc.dart';
import 'package:chat_app/Bloc/Search/bloc/search_bloc.dart';
import 'package:chat_app/services/database_services.dart';
import 'package:chat_app/shared/colors.dart';
import 'package:chat_app/shared/scale.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

bool loading = false;
Map<String, int> groupCheckCounts = {};
String? search_name = "";

PreferredSizeWidget AppBSearch(
  BuildContext context,
  double width,
  double height,
  double textScaleFactor,
) {
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
      "Search",
      style: TextStyle(
          color: Colors.white,
          fontFamily: "Manrope",
          fontSize: responsiveFontSize(30, width, height, textScaleFactor),
          fontWeight: FontWeight.bold),
    ),
  );
}

Widget SearchField(
    double width,
    double height,
    double textScaleFactor,
    TextEditingController searchController,
    Bloc search_bloc,
    BuildContext context) {
  return Container(
    padding:
        EdgeInsets.symmetric(horizontal: 5 * horizontalPaddingFactor(width)),
    color: Colors.black,
    height: responsiveContainerSize(60, width, height),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: TextField(
          controller: searchController,
          style: TextStyle(
              color: Colors.white,
              fontSize: responsiveFontSize(20, width, height, textScaleFactor),
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: "  Search Groups...",
              hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize:
                      responsiveFontSize(20, width, height, textScaleFactor))),
        )),
        IconButton(
            onPressed: () {
              groupCheckCounts = {};
              FocusScope.of(context).unfocus();
              if (searchController.text.isNotEmpty) {
                search_bloc.add(
                    Search_Clicked_Event(groupName: searchController.text));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Enter A Valid Name"),
                  backgroundColor: Colors.red,
                ));
              }
            },
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: responsiveContainerSize(28, width, height),
            )),
      ],
    ),
  );
}

Widget GroupList(QuerySnapshot? groupsnapshot, double width, double height,
    double textScaleFactor, bool hasSearched, Bloc search_bloc) {
  int itemCount = groupsnapshot?.docs.length ?? 0;
  print("GroupSnapshot Length: $itemCount");

  if (itemCount == 0 && hasSearched) {
    return GroupEmpty(width, height, textScaleFactor);
  } else if (itemCount == 0 && !hasSearched) {
    return SearchWelome(width, height, textScaleFactor);
  } else {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: groupsnapshot?.docs.length ?? 0,
          itemBuilder: (context, index) {
            // bool result = true;

            if (groupsnapshot!.docs.isNotEmpty) {
              return Container(
                padding: EdgeInsets.symmetric(
                    vertical: 5 * verticalPaddingFactor(height),
                    horizontal: 5 * horizontalPaddingFactor(width)),
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.yellow.shade800,
                        ),
                      )
                    : SearchTile(width, height, textScaleFactor, groupsnapshot,
                        index, search_bloc),
              );
            }
          }),
    );
  }
}

check(String groupID, String groupName) async {
  bool result =
      await DatabaseServices(userId: FirebaseAuth.instance.currentUser!.uid)
          .checkUserJoined(groupID, groupName);
  return result;
}

Widget GroupEmpty(double width, double height, double textScaleFactor) {
  return Container(
    padding: EdgeInsets.symmetric(
        vertical: 70 * verticalPaddingFactor(height),
        horizontal: 15 * horizontalPaddingFactor(width)),
    child: Center(
      child: Column(
        children: [
          Icon(
            Icons.error,
            color: Colors.grey.shade800,
            size: responsiveContainerSize(78, width, height),
          ),
          Text(
            "No Groups Found",
            style: TextStyle(
                color: Colors.grey.shade800,
                fontFamily: "Manrope",
                fontWeight: FontWeight.bold,
                fontSize:
                    responsiveFontSize(30, width, height, textScaleFactor)),
          )
        ],
      ),
    ),
  );
}

Widget SearchWelome(double width, double height, double textScaleFactor) {
  return Container(
    padding: EdgeInsets.symmetric(
        vertical: 70 * verticalPaddingFactor(height),
        horizontal: 15 * horizontalPaddingFactor(width)),
    child: Center(
      child: Column(
        children: [
          Icon(
            Icons.group,
            color: Colors.grey.shade800,
            size: responsiveContainerSize(88, width, height),
          ),
          Text(
            "Find A Group To Join",
            style: TextStyle(
                color: Colors.grey.shade800,
                fontFamily: "Manrope",
                fontWeight: FontWeight.bold,
                fontSize:
                    responsiveFontSize(32, width, height, textScaleFactor)),
          )
        ],
      ),
    ),
  );
}

SearchTile(double width, double height, double textScaleFactor,
    QuerySnapshot? groupsnapshot, int index, Bloc search_bloc) {
  String groupID = groupsnapshot?.docs[index]["groupId"];
  String groupName = groupsnapshot?.docs[index]["groupName"];

  //* we check for same name groups via a map
  //* if same name group found dont check its status
  if (groupCheckCounts[groupID] == null) {
    groupCheckCounts[groupID] = 0;
  }

  if (groupCheckCounts[groupID]! < 2) {
    search_bloc.add(Check_Group_Event(groupID: groupID, groupName: groupName));
    groupCheckCounts[groupID] = groupCheckCounts[groupID]! + 1;
  }

  return Container(
    padding: EdgeInsets.symmetric(
        vertical: 10 * verticalPaddingFactor(height),
        horizontal: 5 * horizontalPaddingFactor(width)),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        responsiveBorderRadius(12, width, height),
      ),
      color: Colors.orange.shade50,
    ),
    child: ListTile(
      leading: CircleAvatar(
        radius: responsiveBorderRadius(25, width, height),
        backgroundColor: Color.fromARGB(255, 152, 143, 58),
        child: Center(
          child: Text(
            groupsnapshot?.docs[index]["groupName"]
                .substring(0, 1)
                .toUpperCase(),
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Manrope",
                fontWeight: FontWeight.bold,
                fontSize:
                    responsiveFontSize(22, width, height, textScaleFactor)),
          ),
        ),
      ),
      title: Text(
        groupsnapshot?.docs[index]["groupName"],
        style: TextStyle(
            color: Colors.black,
            fontFamily: "Manrope",
            fontWeight: FontWeight.bold,
            fontSize: responsiveFontSize(18, width, height, textScaleFactor)),
      ),
      subtitle: Text(
        "Admin : ${groupsnapshot?.docs[index]["admin"].substring(groupsnapshot?.docs[index]["admin"].indexOf("_") + 1)}",
        style: TextStyle(
            color: Colors.grey.shade800,
            fontFamily: "Manrope",
            fontWeight: FontWeight.bold,
            fontSize: responsiveFontSize(18, width, height, textScaleFactor)),
      ),
      trailing: widget_loading
          ? SizedBox(
              height: responsiveContainerSize(10, width, height),
              width: responsiveContainerSize(10, width, height),
              child: Center(
                child: CircularProgressIndicator(
                  color: OrangeColor,
                ),
              ),
            )
          : InkWell(
              onTap: () {
                // print(search_name);
                search_bloc.add(User_Join_Event(
                    userID: FirebaseAuth.instance.currentUser!.uid,
                    groupID: groupsnapshot?.docs[index]["groupId"],
                    userName: search_name,
                    groupName: groupsnapshot?.docs[index]["groupName"]));
              },
              child: Container(
                height: responsiveContainerSize(45, width, height),
                width: responsiveContainerSize(85, width, height),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        responsiveBorderRadius(6, width, height)),
                    color: result_group ? Colors.green : Colors.red),
                child: Center(
                  child: Text(
                    status == "Joined"
                        ? "Joined"
                        : status == "Join Now"
                            ? "Join Now"
                            : "Removed",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Manrope",
                        fontWeight: FontWeight.bold,
                        fontSize: responsiveFontSize(
                            16, width, height, textScaleFactor)),
                  ),
                ),
              ),
            ),
    ),
  );
}
