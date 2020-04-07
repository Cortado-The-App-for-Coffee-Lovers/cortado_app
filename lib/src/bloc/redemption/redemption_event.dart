import 'package:flutter/material.dart';

@immutable
abstract class RedemptionEvent {}

class RedeemPressed extends RedemptionEvent {}

class RedemptionConfirmed extends RedemptionEvent {}


