/*
*  welcome_widget.dart
*  cortadosuper
*
*  Created by [Author].
*  Copyright © 2018 [Company]. All rights reserved.
    */

import 'package:cortado_app/ui/sign_in/sign_in_animations.dart';
import 'package:cortado_app/values/values.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  AnimationController logInButtonAnimationController;
  AnimationController signUpButtonAnimationController;

  @override
  void initState() {
    super.initState();

    this.logInButtonAnimationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    this.signUpButtonAnimationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
  }

  @override
  void dispose() {
    super.dispose();

    this.logInButtonAnimationController.dispose();
    this.signUpButtonAnimationController.dispose();
  }

  void onLogInPressed(BuildContext context) => startAnimationOne();

  void onSignUpPressed(BuildContext context) => startAnimationTwo();

  void onForgotPasswordPressed(BuildContext context) {}

  void startAnimationOne() => this.logInButtonAnimationController.forward();

  void startAnimationTwo() => this.signUpButtonAnimationController.forward();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 96,
              margin: EdgeInsets.only(left: 50, top: 93, right: 47),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "c",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: "Lato",
                        fontWeight: FontWeight.w400,
                        fontSize: 80,
                        letterSpacing: -1.90476,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: 96,
                        margin: EdgeInsets.only(left: 4),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Text(
                                "rtado.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontFamily: "Lato",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 80,
                                  letterSpacing: -1.90476,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 37,
                              child: Image.asset(
                                "assets/images/cortado-logo-4.png",
                                fit: BoxFit.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 35,
              margin: EdgeInsets.only(left: 48, top: 4, right: 43),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/images/path-1.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 12,
                    top: 9,
                    child: Text(
                      "Email",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 188, 188, 188),
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 35,
              margin: EdgeInsets.only(top: 20, right: 43),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 284,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 247, 247, 247),
                        border: Border.all(
                          width: 1,
                          color: Color.fromARGB(255, 112, 112, 112),
                        ),
                      ),
                      child: Container(),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 7,
                    child: Text(
                      "                 Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 188, 188, 188),
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 85,
                height: 15,
                margin: EdgeInsets.only(top: 9, right: 51),
                child: FlatButton(
                  onPressed: () => this.onForgotPasswordPressed(context),
                  color: Color.fromARGB(0, 0, 0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  textColor: Color.fromARGB(255, 0, 15, 208),
                  padding: EdgeInsets.all(0),
                  child: Text(
                    "Forgot Password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 15, 208),
                      fontFamily: "Lato",
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 60,
              margin: EdgeInsets.only(left: 31, top: 33, right: 31),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 148,
                      height: 60,
                      child: SignInButtonAnimation(
                        animationController:
                            this.signUpButtonAnimationController,
                        child: FlatButton(
                          onPressed: () => this.onSignUpPressed(context),
                          color: Color.fromARGB(255, 142, 100, 61),
                          shape: RoundedRectangleBorder(
                            borderRadius: Radii.k2pxRadius,
                          ),
                          textColor: Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.all(0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/icon-sign-up.png",
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "SIGN UP",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 148,
                      height: 60,
                      child: SignInButtonAnimation(
                        animationController:
                            this.logInButtonAnimationController,
                        child: FlatButton(
                          onPressed: () => this.onLogInPressed(context),
                          color: Color.fromARGB(255, 142, 100, 61),
                          shape: RoundedRectangleBorder(
                            borderRadius: Radii.k2pxRadius,
                          ),
                          textColor: Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.all(0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/icon-log-in.png",
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "LOG IN",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
