import 'package:cortado_app/src/bloc/redemption/bloc.dart';
import 'package:cortado_app/src/data/coffee_shop.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/ui/widgets/coffee_shop_card.dart';
import 'package:cortado_app/src/ui/widgets/cortado_button.dart';
import 'package:cortado_app/src/ui/widgets/expanding_drink_tile.dart';
import 'package:cortado_app/src/ui/widgets/loading_state_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

import '../router.dart';
import '../style.dart';

class CoffeeShopPage extends StatefulWidget {
  CoffeeShopPage(this.coffeeShopPageArguments, {Key key}) : super(key: key);

  final CoffeeShopPageArguments coffeeShopPageArguments;

  @override
  _CoffeeShopPageState createState() => _CoffeeShopPageState();
}

class _CoffeeShopPageState extends State<CoffeeShopPage> {
  CoffeeShop coffeeShop;
  User user;
  String _selectedDrink = "Drink Option #1";
  // ignore: close_sinks
  RedemptionBloc _redemptionBloc;
  @override
  void initState() {
    super.initState();
    coffeeShop = widget.coffeeShopPageArguments.coffeeShop;
    user = widget.coffeeShopPageArguments.user;
    _redemptionBloc = RedemptionBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      appBar: GradientAppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child:
                Tab(icon: Image.asset("assets/images/icons/back_arrow.png"))),
        gradient: LinearGradient(
            stops: [.6, .5],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [AppColors.light, AppColors.dark]),
        brightness: Brightness.dark,
        elevation: 0,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 25.0),
            child: Row(
              children: <Widget>[
                user.redemptionsLeft != null
                    ? Text(user.redemptionsLeft.toString())
                    : Tab(icon: (Image.asset("assets/images/infinity.png"))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Tab(
                    icon: Image.asset("assets/images/icons/coffee.png"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: BlocListener(
          bloc: _redemptionBloc,
          listener: (context, state) {
            if (state is RedeemState) {
              Navigator.of(context).pushNamed(kCoffeeRedemptionRoute,
                  arguments: [
                    _redemptionBloc,
                    coffeeShop.name,
                    _selectedDrink
                  ]);
            }
          },
          child: _middleSection()),
      floatingActionButton: Container(
          height: SizeConfig.iHeight == IphoneHeight.i667 ? 50 : 125,
          child: Column(children: <Widget>[
            Center(
              child: LoadingStateButton<RedemptionLoadingState>(
                bloc: _redemptionBloc,
                button: Container(
                  width: SizeConfig.screenWidth,
                  color: AppColors.light,
                  child: CortadoButton(
                    text: "Redeem",
                    onTap: () => _redemptionBloc.add(RedeemPressed()),
                    color: AppColors.caramel,
                  ),
                ),
              ),
            ),
          ])),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _middleSection() {
    return SingleChildScrollView(
        child: LayoutBuilder(builder: (context, contraints) {
      return Column(children: [
        CoffeeShopCard(
          image: coffeeShop.picture,
          shopName: coffeeShop.name,
          distance: coffeeShop.currentDistance,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      coffeeShop.address['street'] + ',',
                      style: TextStyles.kDefaultSmallTextCaramelStyle,
                    ),
                    Text(
                      coffeeShop.address['city'] +
                          ',' +
                          coffeeShop.address['state'] +
                          " " +
                          coffeeShop.address['zipcode'],
                      style: TextStyles.kDefaultSmallTextCaramelStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    right: 20.0,
                  ),
                  child: Column(children: [
                    Text(
                      "Mon-Fri   " + coffeeShop.hours["Mon-Fri"],
                      style: TextStyles.kDefaultSmallTextCaramelStyle,
                    ),
                    Text(
                      "Sat     " + coffeeShop.hours["Sat"],
                      style: TextStyles.kDefaultSmallTextCaramelStyle,
                    ),
                    Text(
                      "Sun    " + coffeeShop.hours["Sun"],
                      style: TextStyles.kDefaultSmallTextCaramelStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 0,
                      ),
                      child: Text(coffeeShop.phone,
                          style: TextStyles.kDefaultSmallTextCaramelStyle),
                    )
                  ]))
            ]),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
          color: AppColors.caramel,
          height: .5,
          width: SizeConfig.safeBlockHorizontal * .9,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
              ),
              child: Text(
                "Description",
                style: TextStyles.kDefaultDarkTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 20.0,
              ),
              child: Text(
                coffeeShop.description,
                style: TextStyles.kDefaultSmallTextCaramelStyle,
              ),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
          color: AppColors.caramel,
          height: .5,
          width: SizeConfig.safeBlockHorizontal * .9,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
              ),
              child: Text(
                "Available Drinks",
                style: TextStyles.kDefaultDarkTextStyle,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
              child: Container(
                height: SizeConfig.screenHeight * .6,
                child: ListView(
                  children: [
                    ExpandingDrinkTile(
                      title: "Black Coffees",
                      description: "16 oz Black Coffee",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ExpandingDrinkTile(
                      title: "Premium Coffees",
                      description: "16 oz Latte",
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ]);
    }));
  }
}
