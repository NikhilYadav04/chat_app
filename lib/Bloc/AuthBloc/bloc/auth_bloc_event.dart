part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocEvent {}

class RegisterInitializeEvent extends AuthBlocEvent {}

class LoginInitializeEvent extends AuthBlocEvent {}

// ignore: must_be_immutable
class RegisterButtonClickedEvent extends AuthBlocEvent {
  BuildContext context;
  RegisterButtonClickedEvent({required this.context});
}

// ignore: must_be_immutable
class LoginButtonClickedEvent extends AuthBlocEvent {
  BuildContext context;
  LoginButtonClickedEvent({required this.context});
}
