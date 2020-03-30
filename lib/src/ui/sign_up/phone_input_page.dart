import 'package:cortado_app/src/bloc/sign_up/bloc.dart';
import 'package:flutter/material.dart';
import '../router.dart';
import '../widgets/cortado_input_field.dart';
import '../widgets/loading_state_button.dart';
import '../../data/user.dart';

import '../style.dart';
import 'sign_up_page.dart';

class PhoneInputPage extends StatefulWidget {
  final User user;
  PhoneInputPage({Key key, this.user}) : super(key: key);

  @override
  _PhoneInputPageState createState() => _PhoneInputPageState();
}

class _PhoneInputPageState extends SignUpPageState<PhoneInputPage> {
  String _phone;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget get child => Scaffold(
        extendBody: true,
        appBar: AppBar(
          backgroundColor: AppColors.light,
          elevation: 0,
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child:
                  Tab(icon: Image.asset("assets/images/icons/back_arrow.png"))),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.light,
        body: Container(
          decoration: BoxDecoration(
              color: AppColors.light,
              border: Border.all(width: 0.0, color: Colors.transparent)),
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
              Form(
                key: _formKey,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.light,
                      border: Border.all(width: 0.0, color: AppColors.light)),
                  padding:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical * .075),
                  child: CortadoInputField(
                    textInputType: TextInputType.phone,
                    inputFormatters: [UsNumberTextInputFormatter()],
                    hint: "Phone Number",
                    onChanged: (value) => setState(() {
                      _phone = value;
                    }),
                    validator: _phoneValidator,
                    textAlign: TextAlign.start,
                    autofocus: true,
                    isPassword: false,
                    enabled: true,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
              ),
            ]),
            Expanded(
              child: Container(
                color: AppColors.dark,
                margin:
                    EdgeInsets.only(top: SizeConfig.safeBlockVertical * .25),
                child: Stack(
                  children: <Widget>[
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
                                    onTap: () {
                                      if (_formKey.currentState.validate()) {
                                        Navigator.of(context).pushNamed(
                                            kPhoneVerifyRoute,
                                            arguments: [
                                              Format.phoneToE164(_phone),
                                              widget.user,
                                              _phone
                                            ]);
                                        /*  signUpBloc.add(SignUpPhonePressed(
                                            widget.user,
                                            Format.phoneToE164(_phone))); */
                                      }
                                    }),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              decoration: BoxDecoration(
                                  color: AppColors.light,
                                  border: Border.all(
                                      width: 0.0, color: AppColors.light)),
                              height: 1.0,
                              width: SizeConfig.safeBlockHorizontal * .5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ClipPath(
                      clipper: PhoneInputClippingClass(),
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
      );

  String _phoneValidator(String input) {
    RegExp regExp = RegExp(r'(^(\([0-9]{3}\) |[0-9]{3}-)[0-9]{3}-[0-9]{4}$)');
    if (input == null || input.isEmpty) {
      return 'Cannot be empty';
    } else if (!regExp.hasMatch(input)) {
      return 'Phone number should follow this format: (407) 741-8904';
    }

    return null;
  }
}

class PhoneInputClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 30.0);
    path.quadraticBezierTo(size.width / 4, 80, size.width / 2, 70);
    path.quadraticBezierTo(3 / 4 * size.width, 50, size.width, 70);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
