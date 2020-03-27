import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cortado_app/src/bloc/sign_up/bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  @override
  SignUpState get initialState => SignUpInitial();

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {}
}
