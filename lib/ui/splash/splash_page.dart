import 'package:cortado_app/ui/welcome/welcome_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration(seconds: 2),
        () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => WelcomePage())));
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/cortado-splash.png"),
                fit: BoxFit.cover)),
      ),
    );
  }
}
