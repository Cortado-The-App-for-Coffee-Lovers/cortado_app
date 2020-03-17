import 'package:cortado_app/src/data/coffee_shop.dart';
import 'package:flutter/material.dart';

class CoffeeShopTile extends StatelessWidget {
  final CoffeeShop coffeeShop;

  const CoffeeShopTile({Key key, this.coffeeShop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(coffeeShop.name),
    );
  }
}
