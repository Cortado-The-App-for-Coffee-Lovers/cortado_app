import 'package:flutter/material.dart';

@immutable
abstract class SignInEvent {}

class SignInPressed extends SignInEvent {
  final String email;
  final String password;

  SignInPressed(this.email, this.password);
}
