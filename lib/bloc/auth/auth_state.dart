abstract class AuthState {}

class LoadingLogoutState extends AuthState {}

class LoadingLoginState extends AuthState {}

class UnlogedState extends AuthState {}

class LogedState extends AuthState {}

class LoginErrorState extends AuthState {}

class LoginFailState extends AuthState {
  String msg;
  LoginFailState(this.msg);
}
