import 'package:geolocator/geolocator.dart';

abstract class CoffeeShopEvent {
  const CoffeeShopEvent();
}

class GetCoffeeShops extends CoffeeShopEvent {}
