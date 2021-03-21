import 'package:bloc/bloc.dart';
import 'package:test_kanban/bloc/auth/auth_event.dart';
import 'package:test_kanban/shared/api_auth.dart';

import 'auth_state.dart';

class BlocAuth extends Bloc<AuthEvent, AuthState> {
  BlocAuth(AuthState initialState) : super(initialState);

  @override
  get initialState => UnlogedState();

  bool _isLoged = false;

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    try {
      if (event is ResetStateEvent) {
        yield UnlogedState();
      } else if (event is LoginEvent) {
        yield LoadingLoginState();
        yield await ApiAuth.instance.login(event);
        return;
      } else if (event is LogoutEvent) {
        yield LoadingLogoutState();
        await ApiAuth.instance.logout();
        yield UnlogedState();
      }
    } catch (e) {
      yield LoginErrorState();
    }
  }
}
