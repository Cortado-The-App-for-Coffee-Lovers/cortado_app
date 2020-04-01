import 'package:cortado_app/src/data/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../ui/drawer/drawer_home_page.dart';
import '../router.dart';
import '../style.dart';
import '../../bloc/auth/bloc.dart';
import '../widgets/snackbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    AuthBloc bloc = BlocProvider.of<AuthBloc>(context);
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.light,
      body: BlocListener(
        bloc: bloc,
        listener: (context, state) {
          UserModel userModel = Provider.of<UserModel>(context, listen: false);
          if (state is SignedInState) {
            userModel.updateUser(state.user);
            Navigator.of(context).pushReplacementNamed(kHomeRoute);
          }
        },
        child: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if (state is SignedInState) {
                return DrawerHomePage(
                  initialRoute: DrawerRoute.coffeeShops,
                );
              } else if (state is SignedOutState) {
                var error = state.error;
                if (error.isNotEmpty) showSnackbar(context, Text(error));
                return Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              left: 0,
                              top: SizeConfig.safeBlockVertical * .18,
                              child: Container(
                                height: SizeConfig.blockSizeVertical * .2,
                                width: SizeConfig.safeBlockHorizontal * .21,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/beans_left.png'))),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: SizeConfig.safeBlockVertical * .07,
                              child: Container(
                                height: SizeConfig.safeBlockVertical * .2,
                                width: SizeConfig.safeBlockHorizontal * .29,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/latte_right.png'))),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: SizeConfig.safeBlockVertical * .05,
                              child: Container(
                                height: SizeConfig.safeBlockVertical * .6,
                                width: SizeConfig.safeBlockHorizontal * .35,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/blob_right.png'))),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              child: Container(
                                height: SizeConfig.safeBlockVertical * .6,
                                width: SizeConfig.safeBlockHorizontal * .9,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            'assets/images/blob_left.png'))),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              bottom: SizeConfig.safeBlockVertical * .3,
                              child: Container(
                                height: SizeConfig.safeBlockVertical * .2,
                                width: SizeConfig.safeBlockHorizontal * .3,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/latte_left.png'))),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: SizeConfig.blockSizeVertical * .225,
                              child: Container(
                                height: SizeConfig.blockSizeVertical * .2,
                                width: SizeConfig.safeBlockHorizontal * .23,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/beans_right.png'))),
                              ),
                            ),
                            Positioned(
                              top: SizeConfig.safeBlockVertical * .4,
                              left: SizeConfig.safeBlockHorizontal * .12,
                              child: Column(children: [
                                Text(
                                  "Cortado",
                                  style: TextStyles.kWelcomeTitleTextStyle,
                                ),
                                Text(
                                  "The app for coffee lovers.",
                                  style: TextStyles.kSubtitleTextStyle,
                                ),
                              ]),
                            ),
                            Positioned(
                              bottom: SizeConfig.blockSizeVertical * .2,
                              left: SizeConfig.blockSizeHorizontal * .37,
                              child: GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .pushNamed(kSignUpInitialRoute),
                                child: Text(
                                  "Sign Up",
                                  style: TextStyles.kSubtitleTextStyle,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: SizeConfig.blockSizeVertical * .18,
                              left: SizeConfig.blockSizeHorizontal * .245,
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 8.0),
                                color: AppColors.caramel,
                                height: 1.0,
                                width: SizeConfig.safeBlockHorizontal * .5,
                              ),
                            ),
                            Positioned(
                              bottom: SizeConfig.blockSizeVertical * .04,
                              left: SizeConfig.blockSizeHorizontal * .2,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: SizeConfig.blockSizeVertical * .07),
                                child: Row(
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Container(
                color: Colors.white,
                child: Center(child: CircularProgressIndicator()),
              );
            }),
      ),
    );
  }

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
}