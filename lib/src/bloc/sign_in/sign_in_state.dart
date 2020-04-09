import 'package:flutter/material.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInErrorState extends SignInState {
  final String error;

  SignInErrorState(this.error);
}

class SignInLoadingState extends SignInState {}
