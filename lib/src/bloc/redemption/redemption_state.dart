import 'package:flutter/material.dart';

@immutable
abstract class RedemptionState {}

class RedemptionInitial extends RedemptionState {}

class RedemptionLoadingState extends RedemptionState {}

class RedeemState extends RedemptionState {}
