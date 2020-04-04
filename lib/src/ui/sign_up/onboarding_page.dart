import 'package:cortado_app/src/ui/router.dart';
import 'package:cortado_app/src/ui/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';
import '../widgets/onboarding_card.dart';
import '../style.dart';
import '../../data/user.dart';
import '../widgets/loading_state_button.dart';
import '../../bloc/sign_up/bloc.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key key, this.user}) : super(key: key);
  final User user;

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends SignUpPageState<OnboardingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget get child => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.dark, AppColors.caramel, AppColors.cream],
                begin: Alignment.bottomCenter,
                end: Alignment.topRight,
                stops: [.6, .8, .9]),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: SizeConfig.blockSizeVertical * .2,
              ),
              Expanded(
                child: OnBoardingCard(
                  backgroundColor: Colors.transparent,
                  image:
                      Image.asset('assets/images/cup_of_joe.png', height: 250),
                  title: 'Get your daily cup of joe.',
                ),
              ),
            ],
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
                        "Subscribe Now",
                        style: TextStyles.kButtonLightTextStyle,
                      ),
                      onTap: () {}),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                color: AppColors.light,
                height: 1.0,
                width: SizeConfig.safeBlockHorizontal * .5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't want to subscribe? ",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: kFontFamilyNormal,
                          color: AppColors.light)),
                  _browseButton(context)
                ],
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );

  _browseButton(BuildContext context) {
    return ButtonTheme(
      minWidth: 30,
      child: FlatButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              kCoffeeShopsListRoute, (Route<dynamic> route) => false,
              arguments: widget.user),
          child: Text("Start browsing.",
              style: TextStyle(
                  color: AppColors.light,
                  fontSize: 20,
                  fontFamily: kFontFamilyNormal,
                  decoration: TextDecoration.underline))),
    );
  }
}
