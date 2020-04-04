import 'package:cortado_app/src/data/user.dart';
import 'package:flutter/material.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpErrorState extends SignUpState {
  final String error;

  SignUpErrorState(this.error);
}

class SignUpInitialState extends SignUpState {
  final User user;

  SignUpInitialState(this.user);
}

class SignUpInitialComplete extends SignUpState {
  final User user;

  SignUpInitialComplete(this.user);
}

class SignUpPhoneVerificationSent extends SignUpState {
  final User user;
  final String verificationId;
  final String phone;
  SignUpPhoneVerificationSent(this.user, this.verificationId, this.phone);
}

class SignUpPhoneVerificationComplete extends SignUpState {
  final User user;

  SignUpPhoneVerificationComplete(this.user);
}

class SignUpStart extends SignUpState {}
