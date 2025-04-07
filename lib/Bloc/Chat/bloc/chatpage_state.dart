// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'chatpage_bloc.dart';

@immutable
sealed class ChatpageState {}

sealed class ChatpageActionState extends ChatpageState {}

final class ChatpageInitial extends ChatpageState {}

class Chat_Initial_State extends ChatpageState {
  Stream<QuerySnapshot>? chats;
  Chat_Initial_State({required this.chats});
}

class Group_info_initial_State extends ChatpageState {
  String admin;
  Stream members;
  Group_info_initial_State({
    required this.admin,
    required this.members,
  });
  
}

class info_clicked_State extends ChatpageActionState {}

class loading_state extends ChatpageState {}

class exit_success extends ChatpageActionState {}

class temp extends ChatpageState {}

class temp_chats extends ChatpageState {}

class chat_message_delete_await_state extends ChatpageActionState {}

class chat_message_delete_state extends ChatpageActionState {}

