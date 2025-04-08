import 'package:chat_app/Bloc/Search/bloc/search_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String? userId;
  DatabaseServices( {required this.userId});

  //reference for our collections
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  //* save the userdata in database
  Future updateUserData(String fullName, String email) async {
    await userCollection.doc(userId).set({
      "fullName": fullName,
      "email": email,
      "groups": [],
      "userIid": userId
    });
  }

  //* get the userdata from database
  Future getUserData() async {
    DocumentSnapshot documentSnapshot = await userCollection.doc(userId).get();
    String Fire_Name = documentSnapshot["fullName"];
    return Fire_Name;
  }

  //* getting the user groups list
  getUserGroups() async {
    return userCollection.doc(userId).snapshots();
  }

  //* create a group
  Future createGroup(String? Username, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": '${id}_${Username}',
      "members": [],
      "groupId": "",
      "recentMessages": "",
      "recentMessageSender": "",
      "recentMessageTime": ""
    });

    //update the members
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${userId}_${Username}"]),
      "groupId": groupDocumentReference.id
    });

    //update the user is included in the group
    DocumentReference userDocumentReference = userCollection.doc(userId);
    await userDocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_${groupName}"])
    });
  }

  //* getting the group admin
  Future getGroupAdmin(String groupID) async {
    DocumentSnapshot documentSnapshot =
        await groupCollection.doc(groupID).get();
    String admin = documentSnapshot["admin"];
    return admin;
  }

  //* getting the members
  Future getMemebers(String groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  //* search the groups
  Future searchByName(String groupName) {
    return groupCollection.where("groupName", isEqualTo: groupName).get();
  }

  //* checking is user is joined in a group
  Future<bool> checkUserJoined(String groupId, String groupName) async {
    DocumentSnapshot documentSnapshot = await userCollection.doc(userId).get();
    List<dynamic> groups = await documentSnapshot["groups"];
    if (groups.contains("${groupId}_${groupName}")) {
      return true;
    } else {
      return false;
    }
  }

  //* join or exit the group
  Future<String> joinGroup(
      String groupId, String groupName, String userId, String? userName) async {
    DocumentSnapshot documentSnapshot =
        await groupCollection.doc(groupId).get();
    String admin = documentSnapshot["admin"]
        .substring(documentSnapshot["admin"].indexOf("_") + 1);

    try {
      if (result_group == true) {
        if (admin == userName) {
          QuerySnapshot usersSnapshot = await userCollection.get();

          // Iterate through each user document
          for (DocumentSnapshot userDoc in usersSnapshot.docs) {
            // Check if the user is a member of the group
            if (userDoc["groups"].contains("${groupId}_${groupName}")) {
              // Remove the group from the user's groups array
              await userCollection.doc(userDoc.id).update({
                "groups": FieldValue.arrayRemove(["${groupId}_${groupName}"])
              });
            }
          }
          await groupCollection.doc(groupId).delete();
          await userCollection.doc(userId).update({
            "groups": FieldValue.arrayRemove(["${groupId}_${groupName}"])
          });
          return "Admin_Delete";
        } else {
          await groupCollection.doc(groupId).update({
            "members": FieldValue.arrayRemove(["${userId}_${userName}"])
          });
          await userCollection.doc(userId).update({
            "groups": FieldValue.arrayRemove(["${groupId}_${groupName}"])
          });
          return "Delete";
        }
        
      } else {
        await groupCollection.doc(groupId).update({
          "members": FieldValue.arrayUnion(["${userId}_${userName}"])
        });
        await userCollection.doc(userId).update({
          "groups": FieldValue.arrayUnion(["${groupId}_${groupName}"])
        });
        return "Add";
      }
    } catch (e) {
      return e.toString();
    }
  }

  //* to exit the group from info page
  Future<String> exitGroup(
      String groupId, String groupName, String userId, String? userName) async {
    DocumentSnapshot documentSnapshot =
        await groupCollection.doc(groupId).get();
    String admin = documentSnapshot["admin"]
        .substring(documentSnapshot["admin"].indexOf("_") + 1);
    if (admin == userName) {
      QuerySnapshot usersSnapshot = await userCollection.get();

      // Iterate through each user document
      for (DocumentSnapshot userDoc in usersSnapshot.docs) {
        // Check if the user is a member of the group
        if (userDoc["groups"].contains("${groupId}_${groupName}")) {
          // Remove the group from the user's groups array
          await userCollection.doc(userDoc.id).update({
            "groups": FieldValue.arrayRemove(["${groupId}_${groupName}"])
          });
        }
      }
      await groupCollection.doc(groupId).delete();
      await userCollection.doc(userId).update({
        "groups": FieldValue.arrayRemove(["${groupId}_${groupName}"])
      });
    } else {
      await groupCollection.doc(groupId).update({
        "members": FieldValue.arrayRemove(["${userId}_${userName}"])
      });
      await userCollection.doc(userId).update({
        "groups": FieldValue.arrayRemove(["${groupId}_${groupName}"])
      });
    }
    return "Delete";
  }

  //* getting the chats in a group
  Future getChats(String groupID) async {
    return await groupCollection
        .doc(groupID)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  //* send message in group
  Future sendChat(String groupId, Map<String, dynamic> chatMessage) async {
    await groupCollection.doc(groupId).collection("messages").add(chatMessage);
    await groupCollection.doc(groupId).update({
      "recentMessages": chatMessage["message"],
      "recentMessageSender": chatMessage["sender"],
      "recentMessageTime": chatMessage["time"].toString()
    });
  }

  //* clear all messages from a group
  Future deletechat(String groupID) async {
    CollectionReference collectionReference =
        await groupCollection.doc(groupID).collection("messages");
    QuerySnapshot snapshot = await collectionReference.get();

    for (DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
