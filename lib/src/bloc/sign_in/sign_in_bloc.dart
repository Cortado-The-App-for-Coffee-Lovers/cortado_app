import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cortado_app/src/bloc/sign_in/bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  @override
  SignInState get initialState => SignInInitial();

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is SignInPressed) {
      yield SignInLoadingState();
      print('validate email and password');
    }
  }
}
