import 'package:cortado_app/src/ui/sign_up/sign_up_page.dart';
import 'package:cortado_app/src/ui/widgets/cortado_button.dart';
import 'package:flutter/material.dart';
import '../router.dart';
import '../widgets/circle_bar.dart';
import '../widgets/onboarding_card.dart';
import '../style.dart';
import '../../data/user.dart';

class SignUpCardsPage extends StatefulWidget {
  SignUpCardsPage({Key key, this.user}) : super(key: key);
  final User user;

  @override
  _SignUpCardsPageState createState() => _SignUpCardsPageState();
}

class _SignUpCardsPageState extends SignUpPageState<SignUpCardsPage>
    with TickerProviderStateMixin {
  int _currentPageValue = 0;

  PageController _pageController;
  List<Widget> _onboardingCards = <Widget>[
    OnBoardingCard(
      backgroundColor: Colors.transparent,
      image: Image.asset('assets/images/piggy_bank.png',
          height: SizeConfig.iHeight == IphoneHeight.i667 ? 200 : 250),
      title: 'Save money with every purchase.',
    ),
    OnBoardingCard(
      backgroundColor: Colors.transparent,
      image: Image.asset('assets/images/map.png',
          height: SizeConfig.iHeight == IphoneHeight.i667 ? 200 : 250),
      title: """
Discover new 
cafés.
      """,
    ),
    OnBoardingCard(
      backgroundColor: Colors.transparent,
      image: Image.asset('assets/images/community.png',
          height: SizeConfig.iHeight == IphoneHeight.i667 ? 200 : 250),
      title: 'Support local cafés.',
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
                height: SizeConfig.iHeight == IphoneHeight.i667
                    ? SizeConfig.blockSizeVertical * .12
                    : SizeConfig.blockSizeVertical * .2,
              ),
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    PageView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _onboardingCards.length,
                      onPageChanged: (int index) {
                        _getChangedPageAndMoveBar(index);
                      },
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        return _onboardingCards[index];
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: SizeConfig.screenHeight * .3,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(top: SizeConfig.screenHeight * .07),
                      child: Center(
                        child: CortadoButton(
                          color: AppColors.light,
                          text: "Continue",
                          onTap:
                              (_currentPageValue != _onboardingCards.length - 1)
                                  ? () => _pageController
                                      .jumpToPage(_currentPageValue + 1)
                                  : () => Navigator.of(context)
                                      .pushNamed(kSignUpInitialRoute),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 30),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (int i = 0; i < _onboardingCards.length; i++)
                            if (i == _currentPageValue) ...[
                              CircleBar(
                                isActive: true,
                                activeSize: 22.0,
                                inactiveSize: 13.0,
                              )
                            ] else
                              CircleBar(
                                isActive: false,
                                activeSize: 22.0,
                                inactiveSize: 13.0,
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  void _getChangedPageAndMoveBar(int page) {
    _currentPageValue = page;
    setState(() {});
  }
}
