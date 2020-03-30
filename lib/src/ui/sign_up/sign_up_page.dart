import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../bloc/sign_up/bloc.dart';
import '../router.dart';
import '../../data/user.dart';
import '../style.dart';
import '../widgets/snackbar.dart';

abstract class SignUpPageState<T extends StatefulWidget> extends State<T> {
  Widget get child;

  // ignore: close_sinks
  SignUpBloc signUpBloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    signUpBloc = BlocProvider.of<SignUpBloc>(context);
    SizeConfig().init(context);
    return Scaffold(
      extendBody: true,
      key: _scaffoldKey,
      body: BlocListener(
        bloc: signUpBloc,
        listener: (context, state) {
          print(state);
          if (state is SignUpErrorState) {
            showSnackBarWithKey(_scaffoldKey, Text(state.error));
          }

          if (state is SignUpInitialState) {
            Navigator.of(context).pushNamed(
              kSignUpInitialRoute,
              arguments: state.user,
            );
          }

          if (state is SignUpInitialComplete) {
            Navigator.of(context).pushNamed(
              kPhoneInputRoute,
              arguments: state.user,
            );
          }

          if (state is SignUpPhoneVerificationSent) {
            print("verify route");
            Navigator.of(context).pushNamed(kPhoneVerifyRoute, arguments: [
              state.verificationId,
              state.user,
            ]);
          }

          if (state is SignUpPhoneVerificationComplete) {
            Provider.of<UserModel>(context, listen: false)
                .updateUser(state.user);
            Navigator.of(context).pushNamedAndRemoveUntil(
              kOnBoardingRoute,
              (route) {
                return route.settings.name == '/';
              },
              arguments: state.user,
            );
          }
        },
        child: child,
      ),
    );
  }
}
