import 'package:cortado_app/src/bloc/redemption/bloc.dart';
import 'package:cortado_app/src/ui/router.dart';
import 'package:cortado_app/src/ui/widgets/bean_tile.dart';
import 'package:cortado_app/src/ui/widgets/cortado_button.dart';
import 'package:cortado_app/src/ui/widgets/loading_state_button.dart';
import 'package:cortado_app/src/ui/widgets/onboarding_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../style.dart';

class CoffeeRedemptionPage extends StatefulWidget {
  CoffeeRedemptionPage(this.coffeeRedemptionPageArguments, {Key key})
      : super(key: key);
  final CoffeeRedemptionPageArguments coffeeRedemptionPageArguments;

  @override
  _CoffeeRedemptionPageState createState() => _CoffeeRedemptionPageState();
}

class _CoffeeRedemptionPageState extends State<CoffeeRedemptionPage> {
  RedemptionBloc redemptionBloc;
  String coffeeShop;
  String drink;

  @override
  void initState() {
    super.initState();
    redemptionBloc = widget.coffeeRedemptionPageArguments.redemptionBloc;
    coffeeShop = widget.coffeeRedemptionPageArguments.coffeeShop;
    drink = widget.coffeeRedemptionPageArguments.drink;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener(
        bloc: redemptionBloc,
        listener: (context, state) {
          if (state is ConfirmedRedemptionState) {
            Navigator.of(context).pop();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.dark, AppColors.caramel, AppColors.cream],
                begin: Alignment.bottomCenter,
                end: Alignment.topRight,
                stops: [.6, .8, .9]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: SizeConfig.blockSizeVertical * .1,
              ),
              Expanded(
                flex: 4,
                child: OnBoardingCard(
                  fontSize: 22,
                  backgroundColor: Colors.transparent,
                  image: Image.asset('assets/images/cup_of_joe.png',
                      height:
                          SizeConfig.iHeight == IphoneHeight.i667 ? 200 : 250),
                  title:
                      'Please hand your phone to the barista to confirm order.',
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    coffeeShop,
                    style: TextStyles.kLargeCreamTextStyle,
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
                    color: AppColors.cream,
                    height: 2,
                  ),
                ],
              ),
              Container(
                width: SizeConfig.iWidth == IphoneWidth.i375 ? 250 : 300,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * .24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    BeanTile(drink),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 100,
        child: Column(
          children: <Widget>[
            LoadingStateButton<RedemptionLoadingState>(
                bloc: redemptionBloc,
                button: CortadoButton(
                  text: "Confirm Order",
                  color: AppColors.light,
                  onTap: () => redemptionBloc.add(RedemptionConfirmed()),
                )),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
