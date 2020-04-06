import 'package:cortado_app/src/bloc/sign_up/bloc.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/ui/widgets/cortado_button.dart';
import 'package:cortado_app/src/ui/widgets/latte_loader.dart';
import 'package:cortado_app/src/ui/widgets/loading_state_button.dart';
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
    AuthBloc authbloc = BlocProvider.of<AuthBloc>(context);
    // ignore: close_sinks
    SignUpBloc signUpBloc = BlocProvider.of<SignUpBloc>(context);
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.light,
      body: MultiBlocListener(
        listeners: [
          BlocListener(
            bloc: authbloc,
            listener: (BuildContext context, state) {
              UserModel userModel =
                  Provider.of<UserModel>(context, listen: false);
              if (state is SignedInState) {
                userModel.updateUser(state.user);
                Navigator.of(context).pushReplacementNamed(kHomeRoute);
              }
            },
          ),
          BlocListener(
            bloc: signUpBloc,
            listener: (BuildContext context, state) {
              if (state is SignUpStart) {
                Navigator.of(context).pushNamed(kSignUpCardsRoute);
              }
            },
          )
        ],
        child: BlocBuilder(
            bloc: authbloc,
            builder: (context, state) {
              if (state is SignedInState) {
                return DrawerHomePage(
                  initialRoute: DrawerRoute.coffeeShops,
                );
              } else if (state is SignedOutState) {
                var error = state.error;
                if (error.isNotEmpty) showSnackbar(context, Text(error));
                return Scaffold(
                  body: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                left: 0,
                                top: SizeConfig.safeBlockVertical * .18,
                                child: Container(
                                  height:
                                      SizeConfig.iHeight == IphoneHeight.i667
                                          ? SizeConfig.blockSizeVertical * .15
                                          : SizeConfig.blockSizeVertical * .2,
                                  width: SizeConfig.iWidth == IphoneWidth.i375
                                      ? SizeConfig.safeBlockHorizontal * .15
                                      : SizeConfig.screenWidth * .23,
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
                                  width: SizeConfig.iWidth == IphoneWidth.i375
                                      ? SizeConfig.safeBlockHorizontal * .23
                                      : SizeConfig.safeBlockHorizontal * .26,
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
                                  height:
                                      SizeConfig.iHeight == IphoneHeight.i667
                                          ? SizeConfig.safeBlockVertical * .5
                                          : SizeConfig.safeBlockVertical * .6,
                                  width: SizeConfig.iWidth == IphoneWidth.i375
                                      ? SizeConfig.safeBlockHorizontal * .29
                                      : SizeConfig.safeBlockHorizontal * .35,
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
                                  width: SizeConfig.iWidth == IphoneWidth.i375
                                      ? SizeConfig.safeBlockHorizontal * .6
                                      : SizeConfig.safeBlockHorizontal * .9,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                              'assets/images/blob_left.png'))),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                bottom: SizeConfig.iHeight == IphoneHeight.i667
                                    ? SizeConfig.safeBlockVertical * .26
                                    : SizeConfig.safeBlockVertical * .3,
                                child: Container(
                                  height: SizeConfig.safeBlockVertical * .2,
                                  width: SizeConfig.iWidth == IphoneWidth.i375
                                      ? SizeConfig.safeBlockHorizontal * .2
                                      : SizeConfig.safeBlockHorizontal * .28,
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
                                  height:
                                      SizeConfig.iHeight == IphoneHeight.i667
                                          ? SizeConfig.blockSizeVertical * .15
                                          : SizeConfig.blockSizeVertical * .2,
                                  width: SizeConfig.iWidth == IphoneWidth.i375
                                      ? SizeConfig.safeBlockHorizontal * .15
                                      : SizeConfig.screenWidth * .23,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/beans_right.png'))),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: SizeConfig.screenHeight * .4),
                                alignment: Alignment.bottomCenter,
                                child: Center(
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                                  onTap: () =>
                                      signUpBloc.add(SignUpPressed()))),
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
                );
              }
              return Container(
                color: Colors.white,
                child: Center(child: LatteLoader()),
              );
            }),
      ),
    );
  }

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
}
