import 'package:flutter/material.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoadingState extends SignInState {}
