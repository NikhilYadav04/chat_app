import 'package:bloc/bloc.dart';
import 'package:chat_app/Bloc/Chat/bloc/chatpage_bloc.dart';
import 'package:chat_app/shared/scale.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final TextEditingController searchController = TextEditingController();

PreferredSizeWidget AppBChatPage(
    BuildContext context,
    double width,
    double height,
    double textScaleFactor,
    String groupName,
    Bloc ChatpageBloc,
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
      groupName,
      style: TextStyle(
          color: Colors.white,
          fontFamily: "Manrope",
          fontSize: responsiveFontSize(32, width, height, textScaleFactor),
          fontWeight: FontWeight.bold),
    ),
    actions: [
      IconButton(
        onPressed: () {
          ChatpageBloc.add(info_clicked_Event());
        },
        icon: Icon(
          Icons.info,
          color: Colors.white,
          size: responsiveContainerSize(30, width, height),
        ),
      ),
      IconButton(
        onPressed: () {
          // ChatpageBloc.add(info_clicked_Event());
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    "Clear Messages",
                    style: TextStyle(
                        fontFamily: "Manrope",
                        fontWeight: FontWeight.bold,
                        fontSize: responsiveFontSize(
                            22, width, height, textScaleFactor)),
                  ),
                  content: Text(
                    "Do you want to clear messages?",
                    style: TextStyle(
                        fontFamily: "Manrope",
                        fontSize: responsiveFontSize(
                            16, width, height, textScaleFactor),
                        fontWeight: FontWeight.w500),
                  ),
                  actions: [
                    InkWell(
                      onTap: () {
                        ChatpageBloc.add(chat_message_delete(groupID: groupID));
                        Navigator.of(context).pop();
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
          Icons.delete,
          color: Colors.white,
          size: responsiveContainerSize(30, width, height),
        ),
      ),
    ],
  );
}

Widget Typing(double width, double height, double textScaleFactor,
    String userName, String groupId, Bloc chatBloc) {
  DateTime now = DateTime.now();
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: 12 * horizontalPaddingFactor(width),
    ),
    width: double.infinity,
    height: responsiveContainerSize(70, width, height),
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 217, 212, 212),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextField(
            style: TextStyle(
                color: Colors.black,
                fontSize:
                    responsiveFontSize(20, width, height, textScaleFactor)),
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Search A Message....",
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              hintStyle: TextStyle(
                  fontFamily: "Manrope",
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                  fontSize:
                      responsiveFontSize(21, width, height, textScaleFactor)),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Map<String, dynamic> chatmessageMap = {
              "message": searchController.text,
              "sender": userName,
              "time": DateTime.now().millisecondsSinceEpoch,
              "sendTime": DateFormat('hh:mm a').format(now)
            };
            chatBloc.add(send_message_event(
                groupId: groupId, chatMessage: chatmessageMap));
            searchController.clear();
          },
          child: CircleAvatar(
            radius: responsiveBorderRadius(26, width, height),
            backgroundColor: Colors.blue.shade100,
            child: Icon(
              Icons.send,
              color: Colors.blue.shade800,
              size: responsiveFontSize(28, width, height, textScaleFactor),
            ),
          ),
        )
      ],
    ),
  );
}

Widget Messages(double width, double height, double textScaleFactor,
    Stream<QuerySnapshot>? chats, String userName) {
  return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshots) {
        if (snapshots.connectionState == ConnectionState.active) {
          if (snapshots.hasData) {
            if (snapshots.data.docs.isNotEmpty) {
              print("Has Data");
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshots.data.docs.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                        width,
                        height,
                        textScaleFactor,
                        snapshots.data.docs[index]["message"],
                        snapshots.data.docs[index]["sender"],
                        userName == snapshots.data.docs[index]["sender"],
                        snapshots.data.docs[index]["sendTime"]);
                  });
            } else {
              print("No Data");
              return Center(child: NoMessage(width, height, textScaleFactor));
            }
          } else {
            return Center(
              child: Text("No Data"),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.yellow.shade800,
            ),
          );
        }
      });
}

Widget NoMessage(double width, double height, double textScaleFactor) {
  return SingleChildScrollView(
    child: Container(
      padding:
          EdgeInsets.symmetric(vertical: 200 * verticalPaddingFactor(height)),
      child: Column(
        children: [
          Icon(
            Icons.textsms,
            color: Colors.grey.shade800,
            size: responsiveContainerSize(72, width, height),
          ),
          Text(
            "No Messages?",
            style: TextStyle(
                color: Colors.grey.shade800,
                fontFamily: "Manrope",
                fontSize:
                    responsiveFontSize(26, width, height, textScaleFactor),
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Start A Conversation Now!!",
            style: TextStyle(
                color: Colors.grey.shade800,
                fontFamily: "Manrope",
                fontSize:
                    responsiveFontSize(26, width, height, textScaleFactor),
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    ),
  );
}

Widget MessageTile(double width, double height, double textScaleFactor,
    String message, String sender, bool sentByme, String time) {
  return Container(
    margin: EdgeInsets.only(
        top: 10 * verticalPaddingFactor(height),
        left: sentByme
            ? 40 * horizontalPaddingFactor(width)
            : 10 * horizontalPaddingFactor(width),
        right: sentByme
            ? 10 * horizontalPaddingFactor(width)
            : 40 * horizontalPaddingFactor(width)),
    padding: EdgeInsets.symmetric(
        horizontal: 5 * horizontalPaddingFactor(width),
        vertical: 5 * verticalPaddingFactor(height)),
    decoration: BoxDecoration(
        color: sentByme
            ? const Color.fromARGB(255, 197, 191, 191)
            : Color.fromARGB(255, 230, 219, 125),
        borderRadius:
            BorderRadius.circular(responsiveBorderRadius(25, width, height))
        // BorderRadius.only(
        //   topLeft: Radius.circular(8),
        //   topRight: Radius.circular(8),
        //   bottomLeft: sentByme ? Radius.circular(8) : Radius.circular(0),
        //   bottomRight: sentByme ? Radius.circular(0) : Radius.circular(8),
        // )
        ),
    child: ListTile(
      title: Text(
        sender,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: responsiveFontSize(22, width, height, textScaleFactor)),
      ),
      subtitle: Text(
        message,
        style: TextStyle(
            color: Colors.black,
            fontFamily: "Manrope",
            fontSize: responsiveFontSize(16, width, height, textScaleFactor)),
      ),
      trailing: Text(
        time,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontFamily: "Manrope",
            fontSize: responsiveFontSize(16, width, height, textScaleFactor)),
      ),
    ),
  );
}
