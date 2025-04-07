// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class Search_Initial_Event extends SearchEvent {}

// ignore: must_be_immutable
class Search_Clicked_Event extends SearchEvent {
  String groupName;
  Search_Clicked_Event({
    required this.groupName,
  });

}

class Search_Complete_Event extends SearchEvent {}

class Loading extends SearchEvent {}

// ignore: must_be_immutable
class Check_Group_Event extends SearchEvent {
  String groupID;
  String groupName;
  Check_Group_Event({
    required this.groupID,
    required this.groupName,
  });
}

// ignore: must_be_immutable
class User_Join_Event extends SearchEvent {
  String userID;
  String groupID;
  String? userName;
  String groupName;
  User_Join_Event({
    required this.userID,
    required this.groupID,
    required this.userName,
    required this.groupName,
  });

}
