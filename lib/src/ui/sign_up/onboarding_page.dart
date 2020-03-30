import 'package:cortado_app/src/ui/router.dart';
import 'package:cortado_app/src/ui/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';
import '../widgets/circle_bar.dart';
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

class _OnboardingPageState extends SignUpPageState<OnboardingPage>
    with TickerProviderStateMixin {
  int _currentPageValue = 0;

  PageController _pageController;
  List<Widget> _onboardingCards = <Widget>[
    OnBoardingCard(
      backgroundColor: AppColors.dark,
      image: Image.asset('assets/images/credit_card.png', height: 200),
      title: 'Save money with every purchase.',
    ),
    OnBoardingCard(
      backgroundColor: AppColors.dark,
      image: Image.asset('assets/images/map.png', height: 200),
      title: 'Support local cafés.',
    ),
    OnBoardingCard(
      backgroundColor: AppColors.dark,
      image: Image.asset('assets/images/cup_of_joe.png', height: 200),
      title: 'Get your daily cup of joe.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageValue);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget get child => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.dark,
        body: SafeArea(
            child: Container(
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: SizeConfig.safeBlockVertical * .1,
                    bottom: SizeConfig.safeBlockVertical * .1),
                child: Column(children: [
                  Text(
                    "Cortado",
                    style: TextStyles.kWelcomeTitleLightTextStyle,
                  ),
                  Text(
                    "The app for coffee lovers.",
                    style: TextStyles.kSubtitleTextStyle,
                  ),
                ]),
              ),
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    PageView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount: _onboardingCards.length,
                      onPageChanged: (int index) {
                        _getChangedPageAndMoveBar(index);
                      },
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        return _onboardingCards[index];
                      },
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * .2),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              for (int i = 0; i < _onboardingCards.length; i++)
                                if (i == _currentPageValue) ...[
                                  CircleBar(
                                    isActive: true,
                                    activeSize: 18.0,
                                    inactiveSize: 13.0,
                                  )
                                ] else
                                  CircleBar(
                                    isActive: false,
                                    activeSize: 18.0,
                                    inactiveSize: 13.0,
                                  ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
        floatingActionButton: Visibility(
          visible: _currentPageValue == _onboardingCards.length - 1,
          child: Container(
            height: 150,
            child: Column(
              children: <Widget>[
                LoadingStateButton<SignUpLoadingState>(
                  bloc: signUpBloc,
                  button: Container(
                    child: GestureDetector(
                        child: Text(
                          "Subscribe",
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
                    Text("Don't want to subscribe?",
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );

  _browseButton(BuildContext context) {
    return ButtonTheme(
      minWidth: 30,
      child: FlatButton(
          onPressed: () => Navigator.of(context).pushNamed(kHomeRoute),
          child: Text("Browse the app",
              style: TextStyle(
                  color: AppColors.light,
                  fontSize: 20,
                  fontFamily: kFontFamilyNormal,
                  decoration: TextDecoration.underline))),
    );
  }

  void _getChangedPageAndMoveBar(int page) {
    _currentPageValue = page;
    setState(() {});
  }
}
