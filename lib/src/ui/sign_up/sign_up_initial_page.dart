import 'package:cortado_app/src/ui/widgets/cortado_button.dart';

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

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _retypedController = TextEditingController();

  FocusNode _firstNameFocus = FocusNode();
  FocusNode _lastNameFocus = FocusNode();
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
              padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * .21),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(
                              top: 30, left: 40, right: 50),
                          width: SizeConfig.screenWidth * .55,
                          child: CortadoInputField(
                            controller: _firstNameController,
                            textAlign: TextAlign.start,
                            isPassword: false,
                            onChanged: (value) => setState(() {}),
                            horizontalPadding: 0,
                            hint: "First Name",
                            enabled: true,
                            focusNode: _firstNameFocus,
                            autofocus: false,
                            textCapitalization: TextCapitalization.sentences,
                            textInputType: TextInputType.text,
                            onSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_lastNameFocus);
                            },
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30, right: 40),
                            child: CortadoInputField(
                              controller: _lastNameController,
                              textAlign: TextAlign.start,
                              isPassword: false,
                              onChanged: (value) => setState(() {}),
                              horizontalPadding: 0,
                              hint: "Last Name",
                              enabled: true,
                              focusNode: _lastNameFocus,
                              autofocus: false,
                              textCapitalization: TextCapitalization.sentences,
                              textInputType: TextInputType.text,
                              onSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_emailFocus);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          CortadoInputField(
                            controller: _emailController,
                            focusNode: _emailFocus,
                            hint: "Email",
                            onChanged: (value) => setState(() {}),
                            validator: _emailValidator,
                            textAlign: TextAlign.start,
                            autofocus: false,
                            isPassword: false,
                            enabled: true,
                            textCapitalization: TextCapitalization.none,
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
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      hint: "Password",
                      onChanged: (value) => setState(() {}),
                      validator: (value) {
                        if (value.length < 6) {
                          return "Password must be at least 6 characters in length.";
                        } else {
                          return null;
                        }
                      },
                      textAlign: TextAlign.start,
                      autofocus: false,
                      isPassword: true,
                      enabled: true,
                      textCapitalization: TextCapitalization.sentences,
                      onSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_retypeFocus);
                      },
                    ),
                    CortadoInputField(
                      controller: _retypedController,
                      focusNode: _retypeFocus,
                      hint: "Retype Password",
                      onChanged: (value) => setState(() {}),
                      textAlign: TextAlign.start,
                      autofocus: false,
                      isPassword: true,
                      enabled: true,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ]),
            ),
          ),
          floatingActionButton: Container(
            height: 125,
            padding: EdgeInsets.only(bottom: 30),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: LoadingStateButton<SignUpLoadingState>(
                      bloc: signUpBloc,
                      button: CortadoButton(
                          text: "Sign Up",
                          onTap: () {
                            if (_formKey.currentState.validate())
                              signUpBloc.add(SignUpEmailPassword(
                                  firstName: _firstNameController.text.trim(),
                                  lastName: _lastNameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text,
                                  retypePassword: _retypedController.text));
                          })),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Have an account? ",
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
          padding: EdgeInsets.zero,
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
