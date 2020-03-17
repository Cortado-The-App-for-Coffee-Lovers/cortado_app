import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cortado_app/bloc/coffee_shop/bloc.dart';

class CoffeeShopsBloc extends Bloc<CoffeeShopEvent, CoffeeShopState> {
  @override
  CoffeeShopState get initialState => CoffeeShopInitial();

  @override
  Stream<CoffeeShopState> mapEventToState(
    CoffeeShopEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
