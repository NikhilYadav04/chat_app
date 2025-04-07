import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()) {
    on<MainEvent>((event, emit) {});

    on<Check_User_Logged_In_Event>(check_User_Logged_In_Event);
  }

  FutureOr<void> check_User_Logged_In_Event(
      Check_User_Logged_In_Event event, Emitter<MainState> emit) async {
    bool loggedIn = false;
    emit(Loading_State());

    await HelperFunctions.getUserLoggedInStatus(event.context).then((value) {
      if (value != null) {
        loggedIn = value;
      }
    });
    emit(Check_User_Logged_In_State(key_value: loggedIn));
  }
}
