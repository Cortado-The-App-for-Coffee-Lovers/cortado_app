import 'package:cortado_app/app.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

void main() {
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runApp(App());
}
