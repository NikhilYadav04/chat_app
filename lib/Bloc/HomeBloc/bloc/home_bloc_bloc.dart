import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/helper/helper_functions.dart';
import 'package:chat_app/helper/snack_messages.dart';
import 'package:chat_app/services/database_services.dart';
import 'package:chat_app/widgets/home/home_page_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

String? Home_Name = "";
String? Home_Email = "";
Stream? snapshots;

class HomeBlocBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBlocBloc() : super(HomeBlocInitial()) {
    on<HomeBlocEvent>((event, emit) {});

    on<HomeBlock_Initial_Event>(homeBlock_Initial_Event);
    on<Group_clicked_Event>(group_clicked_Event);
    on<Profile_clicked_Event>(profile_clicked_Event);
    on<Logout_clicked_Event>(logout_clicked_Event);
    on<Add_Button_Clicked_Event>(add_Button_Clicked_Event);
    on<group_create_clicked_event>(Group_create_clicked_event);
    on<search_page_clicked_event>(Search_page_clicked_event);
  }

  FutureOr<void> homeBlock_Initial_Event(
      HomeBlock_Initial_Event event, Emitter<HomeBlocState> emit) async {
    //* Store Current User Name and Email
    Home_Name = await HelperFunctions.getUserName();
    Home_Email = await HelperFunctions.getUserEmail();
    snapshots =
        await DatabaseServices(userId: FirebaseAuth.instance.currentUser!.uid)
            .getUserGroups();

    //* Home Page Loaded
    emit(HomeBlock_Initial_State(
        Home_Name: Home_Name, Home_Email: Home_Email, snapshots: snapshots));
  }

  FutureOr<void> group_clicked_Event(
      Group_clicked_Event event, Emitter<HomeBlocState> emit) {
    print("Group_clicked");
    emit(Group_clicked_State());
  }

  FutureOr<void> profile_clicked_Event(
      Profile_clicked_Event event, Emitter<HomeBlocState> emit) {
    print("Profile_clicked");
    emit(Profile_clicked_Stat(
        Profil_Name: Home_Name, Profile_Email: Home_Email));
  }

  FutureOr<void> logout_clicked_Event(
      Logout_clicked_Event event, Emitter<HomeBlocState> emit) {
    emit(Logout_clicked_State());

    print("Logout_clicked");
  }

  FutureOr<void> add_Button_Clicked_Event(
      Add_Button_Clicked_Event event, Emitter<HomeBlocState> emit) {
    emit(Add_Button_Clicked_State());
  }

  FutureOr<void> Group_create_clicked_event(
      group_create_clicked_event event, Emitter<HomeBlocState> emit) async {
    //* Group Created API Call
    await DatabaseServices(userId: FirebaseAuth.instance.currentUser!.uid)
        .createGroup(
      Home_Name,
      FirebaseAuth.instance.currentUser!.uid,
      group_name,
    );

    showSuccessSnackbar(
        event.context, "Group Created!", "New Group Created Successfully!");
  }

  FutureOr<void> Search_page_clicked_event(
      search_page_clicked_event event, Emitter<HomeBlocState> emit) {
    emit(search_page_clicked_state());
  }
}
