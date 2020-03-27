
import 'package:cortado_app/src/ui/home/home_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration(seconds: 2),
        () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => HomePage())));
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
