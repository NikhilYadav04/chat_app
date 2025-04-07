// ignore_for_file: must_be_immutable

part of 'home_bloc_bloc.dart';

@immutable
sealed class HomeBlocEvent {}

class HomeBlock_Initial_Event extends HomeBlocEvent {}

class Group_clicked_Event extends HomeBlocEvent {}

class Profile_clicked_Event extends HomeBlocEvent {}

// ignore: duplicate_ignore
// ignore: must_be_immutable
class Logout_clicked_Event extends HomeBlocEvent {
  BuildContext context;
  Logout_clicked_Event({required this.context});
}

class Add_Button_Clicked_Event extends HomeBlocEvent {}

class group_create_clicked_event extends HomeBlocEvent {
   BuildContext context;
   group_create_clicked_event({required this.context});
}

class search_page_clicked_event extends HomeBlocEvent {}


