import 'package:cortado_app/src/data/coffee_shop.dart';
import 'package:cortado_app/src/ui/widgets/coffee_shop_card.dart';
import 'package:flutter/material.dart';

class CoffeeShopPage extends StatefulWidget {
  CoffeeShopPage({Key key, this.coffeeShop}) : super(key: key);

  final CoffeeShop coffeeShop;

  @override
  _CoffeeShopPageState createState() => _CoffeeShopPageState();
}

class _CoffeeShopPageState extends State<CoffeeShopPage> {
  CoffeeShop _coffeeShop;
  @override
  void initState() {
    super.initState();
    _coffeeShop = widget.coffeeShop;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        CoffeeShopCard(
          image: _coffeeShop.picture,
          shopName: _coffeeShop.name,
          distance: _coffeeShop.currentDistance,
        ),
      ]),
    );
  }
}
