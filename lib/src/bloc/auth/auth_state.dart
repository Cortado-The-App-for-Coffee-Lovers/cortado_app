import 'package:cortado_app/src/bloc/sign_up/bloc.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthState {}

class InitialAuthState extends AuthState {}

class RequiresAuthState extends AuthState {}

class SignedOutState extends AuthState {
  final String error;

  SignedOutState({this.error = ""});
}

// Implement SingedInState

class SignedInState extends AuthState {
  final User user;

  SignedInState(this.user);
}

class IncompleteSignUp extends AuthState {
  final SignUpState signUpState;

  IncompleteSignUp(this.signUpState);
}

class DeepLinkState extends AuthState {
  final Uri deepLink;

  DeepLinkState(this.deepLink);
}
