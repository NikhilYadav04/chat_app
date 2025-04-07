import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/services/database_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

bool result_group = false;
bool widget_loading = false;
String status = "Join Now";

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {});

    on<Search_Initial_Event>(search_Initial_Event);

    on<Loading>(loading);

    on<Search_Clicked_Event>(search_Clicked_Event);

    on<Check_Group_Event>(check_Group_Event);

    on<User_Join_Event>(user_Join_Event);
  }

  FutureOr<void> search_Initial_Event(
      Search_Initial_Event event, Emitter<SearchState> emit) {
    emit(Search_Initial_State());
  }

  FutureOr<void> loading(Loading event, Emitter<SearchState> emit) {
    emit(Loading_State());
  }

  FutureOr<void> search_Clicked_Event(
      Search_Clicked_Event event, Emitter<SearchState> emit) async {
    // emit(Search_Initial_State());
    emit(Loading_State());
    QuerySnapshot groupsnapshot =
        await DatabaseServices(userId: FirebaseAuth.instance.currentUser!.uid)
            .searchByName(event.groupName);

    emit(Loading_Finished_State());
    emit(Search_Completed_State(groupsnapshot: groupsnapshot));
  }

  FutureOr<void> check_Group_Event(
      Check_Group_Event event, Emitter<SearchState> emit) async {
    emit(Check_Group_State());
    await DatabaseServices(userId: FirebaseAuth.instance.currentUser!.uid)
        .checkUserJoined(event.groupID, event.groupName)
        .then((val) {
      result_group = val;
      result_group == true ? status = "Joined" : status = "Join Now";
    });
    emit(Check_Group_State_Complete());
  }

  FutureOr<void> user_Join_Event(
      User_Join_Event event, Emitter<SearchState> emit) async {
    emit(Join_Group_State());
    await DatabaseServices(userId: event.userID).joinGroup(
        event.groupID, event.groupName, event.userID, event.userName).then((val){
          if(val == "Add"){
            result_group = true;
            status = "Joined";
          }
          else if(val == "Delete"){
            result_group = false;
            status = "Join Now";
          }
          else if (val == "Admin_Delete"){
             result_group = false;
            status = "Admin";
          }
        });
    emit(Join_Group_Complete_State());
  }
}
