import 'package:cortado_app/src/data/coffee_shop.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CoffeeShopTile extends StatelessWidget {
  final CoffeeShop coffeeShop;
  final Position currentUserLocation;

  const CoffeeShopTile({Key key, this.coffeeShop, this.currentUserLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(coffeeShop.name),
      subtitle: Text(currentUserLocation.toString()),
    );
  }
}
