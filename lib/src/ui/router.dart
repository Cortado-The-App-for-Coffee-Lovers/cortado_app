import 'package:cortado_app/src/ui/home/home_page.dart';
import 'package:cortado_app/src/ui/welcome.dart/welcome_page.dart';
import 'package:flutter/material.dart';

const String kHomeRoute = '/home';
const String kWelcomeRoute = '/welcome';

class Router {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case kHomeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());

      case kWelcomeRoute:
        return MaterialPageRoute(builder: (_) => WelcomePage());
    }
  }
}
