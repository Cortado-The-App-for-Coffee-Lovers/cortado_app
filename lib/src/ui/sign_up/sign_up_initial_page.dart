import '../../data/user.dart';

import '../router.dart';
import '../widgets/cortado_input_field.dart';
import '../widgets/loading_state_button.dart';
import '../../bloc/sign_up/bloc.dart';
import 'package:flutter/material.dart';
import './sign_up_page.dart';

import '../style.dart';

class SignUpInitialPage extends StatefulWidget {
  SignUpInitialPage({Key key, this.user}) : super(key: key);
  final User user;

  @override
  _SignUpInitialPageState createState() => _SignUpInitialPageState();
}

class _SignUpInitialPageState extends SignUpPageState<SignUpInitialPage> {
  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _retypedPassword;

  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  FocusNode _retypeFocus = FocusNode();

  @override
  Widget get child => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.light,
          body: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.only(bottom: 150),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    Container(
                      padding: EdgeInsets.only(top: 30),
                      child: Column(
                        children: <Widget>[
                          CortadoInputField(
                            focusNode: _emailFocus,
                            hint: "Email",
                            onChanged: (value) => setState(() {
                              _email = value;
                            }),
                            validator: _emailValidator,
                            textAlign: TextAlign.start,
                            autofocus: true,
                            isPassword: false,
                            enabled: true,
                            textCapitalization: TextCapitalization.sentences,
                            textInputType: TextInputType.emailAddress,
                            onSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocus);
                            },
                          ),
                        ],
                      ),
                    ),
                    CortadoInputField(
                      focusNode: _passwordFocus,
                      hint: "Password",
                      onChanged: (value) => setState(() {
                        _password = value;
                      }),
                      validator: (value) {
                        if (value.length < 6) {
                          return "Password must be at least 6 characters in length.";
                        } else {
                          return null;
                        }
                      },
                      textAlign: TextAlign.start,
                      autofocus: true,
                      isPassword: true,
                      enabled: true,
                      textCapitalization: TextCapitalization.sentences,
                      onSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_retypeFocus);
                      },
                    ),
                    CortadoInputField(
                      focusNode: _retypeFocus,
                      hint: "Retype Password",
                      onChanged: (value) => setState(() {
                        _retypedPassword = value;
                      }),
                      textAlign: TextAlign.start,
                      autofocus: true,
                      isPassword: true,
                      enabled: true,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ]),
            ),
          ),
          floatingActionButton: Container(
            height: 150,
            child: Column(
              children: <Widget>[
                LoadingStateButton<SignUpLoadingState>(
                  bloc: signUpBloc,
                  button: Container(
                    child: GestureDetector(
                        child: Text(
                          "Continue",
                          style: TextStyles.kContinueTextStyle,
                        ),
                        onTap: () {
                          if (_formKey.currentState.validate())
                            signUpBloc.add(SignUpEmailPassword(
                                email: _email,
                                password: _password,
                                retypePassword: _retypedPassword));
                        }),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  color: AppColors.caramel,
                  height: 1.0,
                  width: SizeConfig.safeBlockHorizontal * .5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Have an account?",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: kFontFamilyNormal,
                            color: AppColors.dark)),
                    _loginButton(context)
                  ],
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      );

  _loginButton(BuildContext context) {
    return ButtonTheme(
      minWidth: 30,
      child: FlatButton(
          onPressed: () => Navigator.of(context).pushNamed(kSignInRoute),
          child: Text("Log in",
              style: TextStyle(
                  color: AppColors.caramel,
                  fontSize: 20,
                  fontFamily: kFontFamilyNormal,
                  decoration: TextDecoration.underline))),
    );
  }

  String _emailValidator(String input) {
    RegExp regExp = RegExp(
      r'^((?:.|\n)*?)((mailto:)?[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4})',
      caseSensitive: false,
    );
    if (input == null || input.isEmpty) {
      return 'Cannot be empty';
    } else if (!regExp.hasMatch(input)) {
      return 'Email should follow a standard format.';
    }

    return null;
  }
}
