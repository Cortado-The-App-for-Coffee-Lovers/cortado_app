import 'package:cortado_app/src/bloc/auth/bloc.dart';
import 'package:cortado_app/src/bloc/sign_in/bloc.dart';
import 'package:cortado_app/src/bloc/sign_in/sign_in_bloc.dart';
import 'package:cortado_app/src/ui/style.dart';
import 'package:cortado_app/src/ui/widgets/cortado_input_field.dart';
import 'package:cortado_app/src/ui/widgets/loading_state_button.dart';
import 'package:cortado_app/src/ui/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../router.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  SignInBloc _signInBloc;
  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;

  FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _signInBloc = SignInBloc(BlocProvider.of<AuthBloc>(context));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.light,
        body: Builder(builder: (BuildContext context) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.light,
            body: BlocListener(
              bloc: _signInBloc,
              listener: (BuildContext context, state) {
                if (state is SignInErrorState) {
                  showSnackbar(context, Text(state.error));
                }
              },
              child: Form(
                key: _formKey,
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: SizeConfig.screenHeight * .17,
                        ),
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
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 30),
                              child: Column(
                                children: <Widget>[
                                  CortadoInputField(
                                    hint: "Email",
                                    onChanged: (value) => setState(() {
                                      _email = value;
                                    }),
                                    textAlign: TextAlign.start,
                                    autofocus: false,
                                    isPassword: false,
                                    enabled: true,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    onSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(_passwordFocus);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            CortadoInputField(
                              hint: "Password",
                              onChanged: (value) => setState(() {
                                _password = value;
                              }),
                              textAlign: TextAlign.start,
                              autofocus: false,
                              isPassword: true,
                              enabled: true,
                              textCapitalization: TextCapitalization.sentences,
                            ),
                          ],
                        ),
                        Spacer()
                      ]),
                ),
              ),
            ),
          );
        }),
        floatingActionButton: Container(
          height: 150,
          child: Column(
            children: <Widget>[
              LoadingStateButton<SignInLoadingState>(
                bloc: _signInBloc,
                button: Container(
                  child: GestureDetector(
                      child: Text(
                        "Continue",
                        style: TextStyles.kContinueTextStyle,
                      ),
                      onTap: () =>
                          _signInBloc.add(SignInPressed(_email, _password))),
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
                  _signUpButton(context)
                ],
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  _signUpButton(BuildContext context) {
    return ButtonTheme(
      minWidth: 30,
      child: FlatButton(
          onPressed: () => Navigator.of(context).pushNamed(kSignUpInitialRoute),
          child: Text("Sign Up",
              style: TextStyle(
                  color: AppColors.caramel,
                  fontSize: 20,
                  fontFamily: kFontFamilyNormal,
                  decoration: TextDecoration.underline))),
    );
  }
}
