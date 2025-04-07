// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/pages/chat/chat_page.dart';
import 'package:chat_app/shared/scale.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

// ignore: must_be_immutable
class GroupTile extends StatelessWidget {
  String groupID;
  String groupName;
  String userName;
  GroupTile({
    Key? key,
    required this.groupID,
    required this.groupName,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: ChatPage(
                  groupID: groupID,
                  groupName: groupName,
                  userName: userName,
                ),
                type: PageTransitionType.rightToLeft));
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 10 * verticalPaddingFactor(height),
            horizontal: 5 * horizontalPaddingFactor(width)),
        child: ListTile(
          leading: CircleAvatar(
            radius: responsiveBorderRadius(25, width, height),
            backgroundColor: Color.fromARGB(255, 246, 205, 140),
            child: Center(
              child: Text(
                groupName.substring(0, 1).toUpperCase(),
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
            groupName,
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Nova",
                fontWeight: FontWeight.bold,
                fontSize:
                    responsiveFontSize(19, width, height, textScaleFactor)),
          ),
          subtitle: Text(
            "Join this conversation as ${userName}",
            style: TextStyle(
                color: Colors.grey.shade600,
                fontFamily: "Nova",
                fontSize:
                    responsiveFontSize(16, width, height, textScaleFactor)),
          ),
        ),
      ),
    );
  }
}
