import 'package:cortado_app/src/data/coffee_shop.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/ui/drawer/drawer_home_page.dart';

import 'coffee_shop/coffee_shop_page.dart';
import 'home/home.dart';
import 'sign_in/sign_in_page.dart';
import 'sign_up/onboarding_page.dart';
import 'sign_up/phone_input_page.dart';
import 'sign_up/phone_verify_page.dart';
import 'sign_up/sign_up_cards_page.dart';
import 'sign_up/sign_up_initial_page.dart';
import 'package:flutter/material.dart';

const String kHomeRoute = '/home';
const String kSignInRoute = '/signin';
const String kSignUpCardsRoute = '/signup/signup-cards';
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
      case kSignUpCardsRoute:
        return MaterialPageRoute(builder: (_) => SignUpCardsPage());
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
        return MaterialPageRoute(builder: (_) {
          List args = settings.arguments;
          return CoffeeShopPage(CoffeeShopPageArguments(args[0], args[1]));
        });

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

class CoffeeShopPageArguments {
  final CoffeeShop coffeeShop;
  final User user;

  CoffeeShopPageArguments(this.coffeeShop, this.user);
}
