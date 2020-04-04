import 'package:cortado_app/src/data/coffee_shop.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/ui/widgets/coffee_shop_card.dart';
import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    coffeeShop = widget.coffeeShopPageArguments.coffeeShop;
    user = widget.coffeeShopPageArguments.user;
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
      body: Column(children: [
        CoffeeShopCard(
          image: coffeeShop.picture,
          shopName: coffeeShop.name,
          distance: coffeeShop.currentDistance,
        ),
      ]),
    );
  }
}
