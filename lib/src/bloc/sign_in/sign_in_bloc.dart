import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cortado_app/src/bloc/auth/bloc.dart';
import 'package:cortado_app/src/bloc/sign_in/bloc.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/services/auth_service.dart';
import 'package:cortado_app/src/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../constants.dart';
import '../../locator.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthBloc authBloc;

  SignInBloc(this.authBloc);
  @override
  SignInState get initialState => SignInInitial();

  AuthService get _authService => locator.get();
  UserService get _userService => locator.get();

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is SignInPressed) {
      yield SignInLoadingState();
      try {
        FirebaseUser firebaseUser =
            await _authService.signIn(event.email, event.password);
        if (firebaseUser == null) {
          yield SignInErrorState(kEmailNotVerifiedError);
        } else {
          User user = await _userService.getUser(firebaseUser);
          if (firebaseUser != null && user != null) {
            authBloc.add(SignedIn());
          } else {
            yield SignInErrorState(kGenericSignInError);
          }
        }
      } catch (e) {
        print(e);
        if (e is PlatformException) {
          ///   • `ERROR_INVALID_EMAIL` - If the [email] address is malformed.
          ///   • `ERROR_WRONG_PASSWORD` - If the [password] is wrong.
          ///   • `ERROR_USER_NOT_FOUND` - If there is no user corresponding to the given [email] address, or if the user has been deleted.
          ///   • `ERROR_USER_DISABLED` - If the user has been disabled (for example, in the Firebase console)
          ///   • `ERROR_TOO_MANY_REQUESTS` - If there was too many attempts to sign in as this user.
          ///   • `ERROR_OPERATION_NOT_ALLOWED`
          switch (e.code) {
            case 'ERROR_INVALID_EMAIL':
            case 'ERROR_WRONG_PASSWORD':
            case 'ERROR_USER_NOT_FOUND':
              yield SignInErrorState(kWrongEmailPass);
              break;
            case 'ERROR_USER_DISABLED':
            case 'ERROR_TOO_MANY_REQUESTS':
              yield SignInErrorState(kTooManyAttempts);
              break;
            default:
              yield SignInErrorState(kGenericSignInError);
          }
        } else
          yield SignInErrorState(e.toString());
      }
    }
  }
}
