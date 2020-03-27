import 'package:cortado_app/src/bloc/sign_in/bloc.dart';
import 'package:cortado_app/src/bloc/sign_in/sign_in_bloc.dart';
import 'package:cortado_app/src/ui/style.dart';
import 'package:cortado_app/src/ui/widgets/cortado_input_field.dart';
import 'package:cortado_app/src/ui/widgets/loading_state_button.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
      body: Form(
        key: _formKey,
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            LoadingStateButton<SignInLoadingState>(
              bloc: _signInBloc,
              button: Container(
                child: RaisedButton(
                    child: Text("Sign In"),
                    onPressed: () =>
                        _signInBloc.add(SignInPressed(_email, _password))),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  _validateLoginForm() {
    if (_formKey.currentState.validate()) {}
  }
}
