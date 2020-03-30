import 'package:cortado_app/src/data/user.dart';
import 'package:flutter/material.dart';

@immutable
abstract class SignUpEvent {}

class SignUpEmailPassword extends SignUpEvent {
  final String email;
  final String password;
  final String retypePassword;

  SignUpEmailPassword({this.email, this.password, this.retypePassword});
}

class SignUpPhonePressed extends SignUpEvent {
  final User user;
  final String phone;

  SignUpPhonePressed({this.user, this.phone});
}

class SignUpVerifyPressed extends SignUpEvent {
  final User user;
  final String verificationId;
  final String code;

  SignUpVerifyPressed({this.user, this.verificationId, this.code});
}
