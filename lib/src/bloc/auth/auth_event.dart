import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class AuthReset extends AuthEvent {}

class SignOut extends AuthEvent {}

class SignOutInActiveUser extends AuthEvent {}

class DeleteUser extends AuthEvent {}

class SignedIn extends AuthEvent {}

/* class IncompleteSignIn extends AuthEvent {
  final SignUpState state;

  IncompleteSignIn(this.state);
} */
