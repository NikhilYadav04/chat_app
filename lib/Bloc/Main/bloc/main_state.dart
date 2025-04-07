part of 'main_bloc.dart';

@immutable
sealed class MainState {}

final class MainInitial extends MainState {}

class Check_User_Logged_In_State extends MainState {
  final bool? key_value;

  Check_User_Logged_In_State({required this.key_value});
}

class Loading_State extends MainState {}
