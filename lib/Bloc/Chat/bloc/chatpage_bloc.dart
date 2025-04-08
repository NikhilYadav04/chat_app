import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/services/database_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'chatpage_event.dart';
part 'chatpage_state.dart';

class ChatpageBloc extends Bloc<ChatpageEvent, ChatpageState> {
  ChatpageBloc() : super(ChatpageInitial()) {
    on<ChatpageEvent>((event, emit) {});

    on<Chat_Initial_Event>(chat_Initial_Event);
    on<info_clicked_Event>(info_clicked_event);
    on<Group_info_initial_Event>(group_info_initial_Event);
    on<exit_group_event>(Exit_group_event);
    on<send_message_event>(Send_message_event);
    on<chat_message_delete>(Chat_message_delete);
  }

  FutureOr<void> chat_Initial_Event(
      Chat_Initial_Event event, Emitter<ChatpageState> emit) async {
    //* Show Loader When Chats Are Loading
    emit(loading_state());

    Stream<QuerySnapshot>? chats;
    await DatabaseServices(userId: FirebaseAuth.instance.currentUser!.uid)
        .getChats(event.groupID)
        .then((val) {
      chats = val;
    });

    //* Chat Screen is shown along with messages and loader ends
    emit(Chat_Initial_State(chats: chats));
  }

  FutureOr<void> info_clicked_event(
      info_clicked_Event event, Emitter<ChatpageState> emit) {
    //* Group Info Screen Clicked
    emit(info_clicked_State());
  }

  FutureOr<void> group_info_initial_Event(
      Group_info_initial_Event event, Emitter<ChatpageState> emit) async {
    String admin = "";
    Stream members;
    await DatabaseServices(userId: FirebaseAuth.instance.currentUser!.uid)
        .getGroupAdmin(event.groupID)
        .then((val) {
      if (val != null) {
        admin = val;
      }
    });
    print("Memebrs got");
    members =
        await DatabaseServices(userId: FirebaseAuth.instance.currentUser!.uid)
            .getMemebers(event.groupID);

    //* Show Group Info
    emit(Group_info_initial_State(admin: admin, members: members));
  }

  FutureOr<void> Exit_group_event(
      exit_group_event event, Emitter<ChatpageState> emit) async {
    //* Show Loader and Group Exit API Call Executes
    emit(loading_state());
    await DatabaseServices(userId: FirebaseAuth.instance.currentUser!.uid)
        .exitGroup(
            event.groupID, event.groupName, event.userID, event.userName);

    //* Show Empty Message In Chat Page For Removed User
    emit(temp_chats());

    //* Show Empty Message In Group Info Page For Removed User
    emit(temp());

    //* Exit Success And Navigate To Home Page
    emit(exit_success());
  }

  FutureOr<void> Send_message_event(
      send_message_event event, Emitter<ChatpageState> emit) async {
    await DatabaseServices(userId: FirebaseAuth.instance.currentUser!.uid)
        .sendChat(event.groupId, event.chatMessage);
  }

  FutureOr<void> Chat_message_delete(
      chat_message_delete event, Emitter<ChatpageState> emit) async {
    //* show loader and Messages Clear API Call Executes
    emit(chat_message_delete_await_state());
    await DatabaseServices(userId: FirebaseAuth.instance.currentUser!.uid)
        .deletechat(event.groupID);

    //* Messages Are Deleted And Loader Ends
    emit(chat_message_delete_state());
  }
}
