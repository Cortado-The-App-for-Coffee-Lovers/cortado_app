import 'package:cortado_app/src/data/coffee_shop.dart';

abstract class CoffeeShopEvent {
  const CoffeeShopEvent();
}

class GetCoffeeShops extends CoffeeShopEvent {}
