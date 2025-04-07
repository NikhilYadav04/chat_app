// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'chatpage_bloc.dart';

@immutable
sealed class ChatpageEvent {}

class Chat_Initial_Event extends ChatpageEvent {
  String groupID;
  Chat_Initial_Event({
    required this.groupID,
  });
}

class Group_info_initial_Event extends ChatpageEvent {
  String groupID;
  Group_info_initial_Event({
    required this.groupID,
  });
}

class info_clicked_Event extends ChatpageEvent {}

class exit_group_event extends ChatpageEvent {
  String groupID;
  String groupName;
  String userID;
  String? userName;
  exit_group_event({
    required this.groupID,
    required this.groupName,
    required this.userID,
    required this.userName,
  });
}

class send_message_event extends ChatpageEvent {
  String groupId;
  Map<String,dynamic> chatMessage;
  send_message_event({
    required this.groupId,
    required this.chatMessage,
  });
}

class chat_message_delete extends ChatpageEvent {
  String groupID;
  chat_message_delete({
    required this.groupID,
  });
}
