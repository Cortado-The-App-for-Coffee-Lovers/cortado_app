import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/locator.dart';
import 'package:cortado_app/src/services/auth_service.dart';
import 'package:cortado_app/src/services/user_service.dart';
import 'bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserService get _userService => locator.get();
  AuthService get _authService => locator.get();

  // todo: check singleton for logic in project
  static final AuthBloc _authBlocSingleton = AuthBloc._internal();
  factory AuthBloc() {
    return _authBlocSingleton;
  }
  AuthBloc._internal();

  @override
  Future<void> close() async {
    // dispose objects
    await super.close();
    await _authBlocSingleton.close();
  }

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted || event is SignedIn) {
      try {
        var firebaseUser = await _authService.getCurrentFBUser();

        if (firebaseUser != null) {
          User user = await _userService.getUser(firebaseUser);

          if (user != null) {
            yield SignedInState(user);
          } else {
            yield SignedOutState();
          }
        } else {
          yield SignedOutState();
        }
      } catch (error) {
        await _authService.signOut();
        yield SignedOutState();
      }
    }
    if (event is SignOut) {
      await _authService.signOut();
      yield SignedOutState();
    }
  }
}
