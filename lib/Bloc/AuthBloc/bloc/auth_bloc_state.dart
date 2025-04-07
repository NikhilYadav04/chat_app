part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocState {}

sealed class AuthBlockActionState extends AuthBlocState {}

final class AuthBlocInitial extends AuthBlocState {}

class RegisterInitializeState extends AuthBlocState {}

class LoginInitializeState extends AuthBlocState {}

class RegisterButtonClickedState extends AuthBlocState {}

class LoginButtonClickedState extends AuthBlocState {}

class HomePageNavigateState extends AuthBlockActionState {}

class LoginPageNavigateState extends AuthBlockActionState {}
