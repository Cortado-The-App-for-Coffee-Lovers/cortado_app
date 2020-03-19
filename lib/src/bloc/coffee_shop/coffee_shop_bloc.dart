import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cortado_app/src/bloc/coffee_shop/bloc.dart';
import 'package:cortado_app/src/constants.dart';
import 'package:cortado_app/src/data/coffee_shop.dart';
import 'package:cortado_app/src/repositories/coffee_shop_repository.dart';

class CoffeeShopsBloc extends Bloc<CoffeeShopEvent, CoffeeShopState> {
  CoffeeShopRepository coffeeShopRepository;
  List<CoffeeShop> _coffeeShops = [];

  CoffeeShopsBloc(this.coffeeShopRepository);

  @override
  CoffeeShopState get initialState => CoffeeShopInitial();

  @override
  Stream<CoffeeShopState> mapEventToState(
    CoffeeShopEvent event,
  ) async* {
    List<CoffeeShop> coffeeShops;

    if (event is GetCoffeeShops) {
      yield CoffeeShopsLoading();
      try {
        coffeeShops = await coffeeShopRepository.read();
        this.setCoffeeShops(coffeeShops);
        yield CoffeeShopsLoaded(coffeeShops);
      } catch (e) {
        yield CoffeeShopsError(kCoffeeShopsLoadingError);
      }
    }
  }

  List<CoffeeShop> get coffeeShops => _coffeeShops;

  setCoffeeShops(List<CoffeeShop> coffeeShops) {
    this._coffeeShops = coffeeShops;
  }
}
