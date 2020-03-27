import 'package:cortado_app/src/data/coffee_shop.dart';

abstract class CoffeeShopState {
  const CoffeeShopState();
}

class CoffeeShopInitial extends CoffeeShopState {}

class CoffeeShopsLoadingState extends CoffeeShopState {}

class CoffeeShopsLoaded extends CoffeeShopState {
  final List<CoffeeShop> coffeeShops;

  CoffeeShopsLoaded(this.coffeeShops);
}

class CoffeeShopsError extends CoffeeShopState {
  final String error;

  CoffeeShopsError(this.error);
}
