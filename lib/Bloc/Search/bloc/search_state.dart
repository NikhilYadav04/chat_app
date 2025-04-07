// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

sealed class SearchActionState extends SearchState {}

final class SearchInitial extends SearchState {}

class Search_Initial_State extends SearchState {}

class Search_Clicked_State extends SearchState {}

// ignore: must_be_immutable
class Search_Completed_State extends SearchActionState {
  QuerySnapshot? groupsnapshot;
  Search_Completed_State({
    required this.groupsnapshot,
  });
}

class Loading_State extends SearchActionState {}

class Loading_Finished_State extends SearchActionState {}

class Check_Group_State extends SearchActionState {}

class Check_Group_State_Complete extends SearchActionState {}

class Join_Group_State extends SearchActionState {}

class Join_Group_Complete_State extends SearchActionState {}
