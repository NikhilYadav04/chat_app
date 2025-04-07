import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bloc/bloc.dart';
import 'package:chat_app/helper/helper_functions.dart';
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
    emit(RegisterInitializeState());
  }

  FutureOr<void> registerButtonClickedEvent(
      RegisterButtonClickedEvent event, Emitter<AuthBlocState> emit) async {
    emit(RegisterButtonClickedState());

    final AuthService authService = AuthService();

    String success =
        await authService.registerWithEmailPassword(name, email, Password);

    if (success == "Success") {
      emit(LoginPageNavigateState());

      emit(RegisterInitializeState());

      final snackbar = SnackBar(
        duration: Duration(seconds: 4),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Success!!',
          message: 'Registration Successful',
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(event.context).showSnackBar(snackbar);
    } else {
      final snackbar = SnackBar(
        duration: Duration(seconds: 4),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error!',
          message: '${success}',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(event.context).showSnackBar(snackbar);

      emit(RegisterInitializeState());
    }
  }

  FutureOr<void> loginInitializeEvent(
      LoginInitializeEvent event, Emitter<AuthBlocState> emit) {
    emit(LoginInitializeState());
  }

  FutureOr<void> loginButtonClickedEvent(
      LoginButtonClickedEvent event, Emitter<AuthBlocState> emit) async {
    emit(LoginButtonClickedState());

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
      emit(HomePageNavigateState());

      emit(LoginInitializeState());

      final snackbar = SnackBar(
        duration: Duration(seconds: 4),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Success!!',
          message: 'Login Successful',
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(event.context).showSnackBar(snackbar);
      ;
    } else {
      final snackbar = SnackBar(
        duration: Duration(seconds: 4),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error !',
          message: '${success}',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(event.context).showSnackBar(snackbar);

      emit(LoginInitializeState());
    }
  }
}
