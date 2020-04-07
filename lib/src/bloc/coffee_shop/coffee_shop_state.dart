

abstract class CoffeeShopState {
  const CoffeeShopState();
}

class CoffeeShopInitial extends CoffeeShopState {}

class CoffeeShopsLoadingState extends CoffeeShopState {}

class CoffeeShopsLoaded extends CoffeeShopState {}

class CoffeeShopsError extends CoffeeShopState {
  final String error;

  CoffeeShopsError(this.error);
}
