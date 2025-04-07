// ignore_for_file: must_be_immutable

part of 'home_bloc_bloc.dart';

@immutable
sealed class HomeBlocState {}

sealed class HomeBlocActionState extends HomeBlocState {}

final class HomeBlocInitial extends HomeBlocState {}

class HomeBlock_Initial_State extends HomeBlocState {
  String? Home_Name;
  String? Home_Email;
  Stream? snapshots;
  HomeBlock_Initial_State({required this.Home_Name, required this.Home_Email, required this.snapshots});
}

class Group_clicked_State extends HomeBlocActionState {}

class Profile_clicked_Stat extends HomeBlocActionState {
  String? Profil_Name;
  String? Profile_Email;

  Profile_clicked_Stat(
      {required this.Profil_Name, required this.Profile_Email});
}

class Logout_clicked_State extends HomeBlocActionState {}

class Add_Button_Clicked_State extends HomeBlocActionState {}

class search_page_clicked_state extends HomeBlocActionState {}

class Loading_State extends HomeBlocActionState {}
