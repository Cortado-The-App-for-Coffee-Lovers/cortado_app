import 'package:cortado_app/src/bloc/sign_up/bloc.dart';
import 'package:cortado_app/src/ui/widgets/cortado_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  Widget get child => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: BlocListener(
          bloc: signUpBloc,
          listener: (context, state) {
            if (state is SignUpPhoneVerificationSent) {
              Navigator.of(context).pushNamed(kPhoneVerifyRoute,
                  arguments: [state.verificationId, state.user, state.phone]);
            }
          },
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
              decoration: BoxDecoration(
                  border: Border.all(width: 0.0, color: Colors.transparent)),
              child: Column(children: [
                Column(children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.screenHeight * .02),
                    child: Text(
                      "Cortado",
                      style: TextStyles.kWelcomeTitleTextStyle,
                    ),
                  ),
                  Text(
                    "The app for coffee lovers.",
                    style: TextStyles.kSubtitleTextStyle,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.screenHeight * .06),
                    child: Text(
                      "Verify your account.",
                      style: TextStyle(
                          color: AppColors.dark,
                          fontFamily: kFontFamilyNormal,
                          fontSize: 34),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 0.0, color: AppColors.light)),
                      padding: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical * .05),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("or verify with ",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: kFontFamilyNormal,
                              color: AppColors.dark)),
                      _emailButton(context)
                    ],
                  ),
                ]),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.dark,
                        border:
                            Border.all(width: 0.0, color: Colors.transparent)),
                    margin:
                        EdgeInsets.only(top: SizeConfig.safeBlockVertical * .1),
                    child: ClipPath(
                      clipper: PhoneInputClippingClass(),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.light,
                            border: Border.all(
                                width: 0.0, color: Colors.transparent)),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            floatingActionButton: Container(
              color: Colors.transparent,
              height: 125,
              padding: EdgeInsets.only(bottom: 30),
              child: LoadingStateButton<SignUpLoadingState>(
                bloc: signUpBloc,
                button: Container(
                    child: CortadoButton(
                  color: AppColors.light,
                  text: "Continue",
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      signUpBloc.add(SignUpPhonePressed(
                          user: widget.user,
                          phone: Format.phoneToE164(_phone)));
                    }
                  },
                )),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          ),
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

_emailButton(BuildContext context) {
  return ButtonTheme(
    minWidth: 10,
    child: FlatButton(
        padding: EdgeInsets.zero,
        onPressed: () => {},
        child: Text("email.",
            style: TextStyle(
                color: AppColors.caramel,
                fontSize: 20,
                fontFamily: kFontFamilyNormal,
                decoration: TextDecoration.underline))),
  );
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
