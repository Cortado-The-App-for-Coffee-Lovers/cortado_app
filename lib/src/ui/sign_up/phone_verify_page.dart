import 'package:pin_code_fields/pin_code_fields.dart';
import './sign_up_page.dart';
import 'package:flutter/material.dart';
import '../widgets/loading_state_button.dart';
import '../../bloc/sign_up/bloc.dart';
import '../../data/user.dart';

import '../style.dart';

class PhoneVerifyPage extends StatefulWidget {
  PhoneVerifyPage({Key key, this.verificationId, this.user, this.phone})
      : super(key: key);
  final String verificationId;
  final User user;
  final String phone;

  @override
  _PhoneVerifyPageState createState() => _PhoneVerifyPageState();
}

class _PhoneVerifyPageState extends SignUpPageState<PhoneVerifyPage> {
  TextEditingController _pinController = TextEditingController();

  @override
  Widget get child => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          extendBody: true,
          appBar: AppBar(
            backgroundColor: AppColors.light,
            elevation: 0,
            leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Tab(
                    icon: Image.asset("assets/images/icons/back_arrow.png"))),
          ),
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.light,
          body: Container(
            margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * .025),
            child: Column(children: [
              Column(children: [
                Text(
                  "Cortado",
                  style: TextStyles.kWelcomeTitleTextStyle,
                ),
                Text(
                  "The app for coffee lovers.",
                  style: TextStyles.kSubtitleTextStyle,
                ),
              ]),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          AppColors.dark,
                          AppColors.caramel,
                          AppColors.cream
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topLeft,
                        stops: [.72, .8, .9]),
                  ),
                  margin:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical * .05),
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 200, horizontal: 70),
                        child: PinCodeTextField(
                          textStyle: TextStyle(color: AppColors.light),
                          backgroundColor: AppColors.dark,
                          autoFocus: true,
                          inactiveColor: AppColors.caramel,
                          activeColor: AppColors.light,
                          selectedColor: AppColors.light,
                          controller: _pinController,
                          length: 6,
                          obsecureText: false,
                          animationType: AnimationType.fade,
                          shape: PinCodeFieldShape.box,
                          animationDuration: Duration(milliseconds: 300),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          onChanged: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 170, left: 70),
                        child: Text(
                          "Verification Code",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: kFontFamilyNormal,
                              color: AppColors.light),
                        ),
                      ),
                      Positioned(
                        bottom: 70,
                        left: 100,
                        child: Container(
                          color: AppColors.dark,
                          child: Column(
                            children: <Widget>[
                              LoadingStateButton<SignUpLoadingState>(
                                bloc: signUpBloc,
                                button: Container(
                                  child: GestureDetector(
                                      child: Text(
                                        "Continue",
                                        style: TextStyle(
                                          fontFamily: kFontFamilyNormal,
                                          color: AppColors.light,
                                          fontSize: 28,
                                        ),
                                      ),
                                      onTap: () => signUpBloc.add(
                                          SignUpVerifyPressed(
                                              user: widget.user,
                                              verificationId:
                                                  widget.verificationId,
                                              code: _pinController.text))),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 8.0),
                                color: AppColors.light,
                                height: 1.0,
                                width: SizeConfig.safeBlockHorizontal * .5,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.screenHeight * .09),
                          child: Text(
                            "Enter verification code.",
                            style: TextStyle(
                                color: AppColors.light,
                                fontFamily: kFontFamilyNormal,
                                fontSize: 34),
                          ),
                        ),
                      ),
                      ClipPath(
                        clipper: PhoneVerifyClippingClass(),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.light,
                              border: Border.all(
                                  width: 0.0, color: Colors.transparent)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      );
}

class PhoneVerifyClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 10);
    path.quadraticBezierTo(size.width / 4, 40, size.width / 2, 35);
    path.quadraticBezierTo(3 / 4 * size.width, 30, size.width, 70);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
