part of 'main_bloc.dart';

@immutable
sealed class MainEvent {}

// ignore: must_be_immutable
class Check_User_Logged_In_Event extends MainEvent {
 BuildContext context;
  Check_User_Logged_In_Event({required this.context});
}
