import 'package:test_kanban/shared/models/user.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  User user;
  LoginEvent({this.user});
}

class LogoutEvent extends AuthEvent {}

class ResetStateEvent extends AuthEvent {}
