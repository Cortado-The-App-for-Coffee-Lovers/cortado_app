import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cortado_app/src/bloc/coffee_shop/bloc.dart';
import 'package:cortado_app/src/data/coffee_shop.dart';
import 'package:cortado_app/src/repositories/coffee_shop_repository.dart';

class CoffeeShopsBloc extends Bloc<CoffeeShopEvent, CoffeeShopState> {
  CoffeeShopRepository coffeeShopRepository;
  List<CoffeeShop> _coffeeShops = [];

  List<CoffeeShop> get coffeeShops => _coffeeShops;

  CoffeeShopsBloc(this.coffeeShopRepository) {
    coffeeShopRepository.read().then((coffeeShops) {
      coffeeShops.forEach((coffeeShop) {
        _coffeeShops.add(coffeeShop);
      });
    });
  }

  @override
  CoffeeShopState get initialState => CoffeeShopInitial();

  @override
  Stream<CoffeeShopState> mapEventToState(
    CoffeeShopEvent event,
  ) async* {}
}
