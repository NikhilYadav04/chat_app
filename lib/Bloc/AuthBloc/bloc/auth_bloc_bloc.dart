import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/helper/helper_functions.dart';
import 'package:chat_app/helper/snack_messages.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/database_services.dart';
import 'package:chat_app/widgets/auth/login_page_widgets.dart';
import 'package:chat_app/widgets/auth/register_page_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBlocBloc() : super(AuthBlocInitial()) {
    on<AuthBlocEvent>((event, emit) {});

    on<RegisterInitializeEvent>(registerInitializeEvent);

    on<RegisterButtonClickedEvent>(registerButtonClickedEvent);

    on<LoginInitializeEvent>(loginInitializeEvent);

    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
  }

  FutureOr<void> registerInitializeEvent(
      RegisterInitializeEvent event, Emitter<AuthBlocState> emit) {
    //* Initialize or Load The Register Screen
    emit(RegisterInitializeState());
  }

  FutureOr<void> registerButtonClickedEvent(
      RegisterButtonClickedEvent event, Emitter<AuthBlocState> emit) async {
    //* Account Register Started ( Loader Shows)
    emit(RegisterStartState());

    final AuthService authService = AuthService();

    String success =
        await authService.registerWithEmailPassword(name, email, Password);

    if (success == "Success") {
      emit(RegisterEndState());
      emit(LoginPageNavigateState());

      showSuccessSnackbar(
          event.context, 'Success!!', 'Registration Successful');
    } else {
      showErrorSnackbar(event.context, 'Error!', '${success}');

      emit(RegisterEndState());
    }
    //* Account Registration Completed ( Loader Ends )
  }

  FutureOr<void> loginInitializeEvent(
      LoginInitializeEvent event, Emitter<AuthBlocState> emit) {
    //* Initialize or Load The Login Screen
    emit(LoginInitializeState());
  }

  FutureOr<void> loginButtonClickedEvent(
      LoginButtonClickedEvent event, Emitter<AuthBlocState> emit) async {
    //* Account Login Started ( Loader Shows)
    emit(LoginStartState());

    final AuthService authService = AuthService();

    String success =
        await authService.loginwithEmailPassword(Loginemail, Loginpassword);

    if (success == "Success") {
      String Login_Name =
          await DatabaseServices(userId: FirebaseAuth.instance.currentUser!.uid)
              .getUserData();
      print(Login_Name);
      await HelperFunctions.saveUserLoggedInStatus(true);
      await HelperFunctions.saveUserEMail(Loginemail);
      await HelperFunctions.saveUserName(Login_Name);

      emit(LoginEndState());
      emit(HomePageNavigateState());

      showSuccessSnackbar(event.context, 'Success!!', 'Login Successful');
    } else {
      showErrorSnackbar(event.context, 'Error !', '${success}');

      emit(LoginEndState());
    }
    //* Account Login Completed ( Loader Ends )
  }
}
