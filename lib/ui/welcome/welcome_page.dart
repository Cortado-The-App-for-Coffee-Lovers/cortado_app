/*
*  welcome_two_widget.dart
*  cortadosuper
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'package:cortado_app/ui/sign_in/sign_in_page.dart';
import 'package:cortado_app/ui/style.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  void onLogInPressed(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => SignInPage()));

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.blockSizeVertical,
        width: SizeConfig.blockSizeHorizontal,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/welcome-screen-3.png"),
                fit: BoxFit.cover)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 45,
              right: 20,
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  child: FlatButton(
                    onPressed: () => this.onLogInPressed(context),
                    color: Color.fromARGB(0, 0, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 150),
                  child: Text(
                    "Welcome to Cortado",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w400,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 100,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: MaterialButton(
                    elevation: 0,
                    height: 52,
                    minWidth: 200,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Colors.white,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.brown,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => print("hello"),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
