import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cortado_app/repositories/auth_repository.dart';
import 'bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository = AuthRepository();

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
  ) async* {}
}
