import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../bloc/sign_up/bloc.dart';
import '../router.dart';
import '../../data/user.dart';
import '../style.dart';

abstract class SignUpPageState<T extends StatefulWidget> extends State<T> {
  Widget get child;

  // ignore: close_sinks
  SignUpBloc signUpBloc;

  @override
  Widget build(BuildContext context) {
    signUpBloc = BlocProvider.of<SignUpBloc>(context);

    return Scaffold(
      backgroundColor: AppColors.dark,
      body: BlocListener(
        bloc: signUpBloc,
        listener: (context, state) {
          if (state is SignUpErrorState) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
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
