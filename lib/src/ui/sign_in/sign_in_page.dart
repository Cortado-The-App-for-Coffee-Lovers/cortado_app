import 'package:cortado_app/src/bloc/sign_in/bloc.dart';
import 'package:cortado_app/src/bloc/sign_in/sign_in_bloc.dart';
import 'package:cortado_app/src/ui/style.dart';
import 'package:cortado_app/src/ui/widgets/cortado_input_field.dart';
import 'package:cortado_app/src/ui/widgets/loading_state_button.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _signInBloc = SignInBloc();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.light,
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(bottom: 215),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                    hint: "Email",
                    onChanged: (value) => setState(() {
                      _email = value;
                    }),
                    textAlign: TextAlign.start,
                    autofocus: true,
                    isPassword: false,
                    enabled: true,
                    textCapitalization: TextCapitalization.sentences,
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
