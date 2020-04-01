import 'package:cortado_app/src/ui/drawer/drawer_home_page.dart';

import 'coffee_shop/coffee_shop_page.dart';
import 'home/home.dart';
import 'sign_in/sign_in_page.dart';
import 'sign_up/onboarding_page.dart';
import 'sign_up/phone_input_page.dart';
import 'sign_up/phone_verify_page.dart';
import 'sign_up/sign_up_initial_page.dart';
import 'package:flutter/material.dart';

const String kHomeRoute = '/home';
const String kSignInRoute = '/signin';
const String kSignUpInitialRoute = '/signup/initial';
const String kPhoneInputRoute = '/signup/phone-input';
const String kPhoneVerifyRoute = '/signup/phone-verify';
const String kOnBoardingRoute = '/signup/onboarding';
const String kCoffeeShopsListRoute = '/coffee_shops';
const String kCoffeeShopRoute = '/coffee_shops/coffee_shop_page';

class Router {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case kHomeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());

      case kSignInRoute:
        return MaterialPageRoute(builder: (_) => SignInPage());
      case kSignUpInitialRoute:
        return MaterialPageRoute(
            builder: (_) => SignUpInitialPage(user: settings.arguments));
      case kPhoneInputRoute:
        return MaterialPageRoute(
            builder: (_) => PhoneInputPage(user: settings.arguments));
      case kPhoneVerifyRoute:
        List args = settings.arguments;
        final page = PhoneVerifyPage(
          verificationId: args[0],
          user: args[1],
          phone: args[2],
        );
        return MaterialPageRoute(builder: (_) => page);
      case kOnBoardingRoute:
        return MaterialPageRoute(
            builder: (_) => OnboardingPage(
                  user: settings.arguments,
                ));
      case kCoffeeShopsListRoute:
        return MaterialPageRoute(
            builder: (_) =>
                DrawerHomePage(initialRoute: DrawerRoute.coffeeShops));

      case kCoffeeShopRoute:
        return MaterialPageRoute(
            builder: (_) => CoffeeShopPage(
                  coffeeShop: settings.arguments,
                ));

      default:
        return MaterialPageRoute(builder: (_) => HomePage());
    }
  }

  Route welcomeTransition(Widget toPage) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => toPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }
}
