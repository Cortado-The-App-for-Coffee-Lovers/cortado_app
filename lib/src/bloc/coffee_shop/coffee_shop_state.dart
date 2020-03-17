import 'package:equatable/equatable.dart';

abstract class CoffeeShopState extends Equatable {
  const CoffeeShopState();
}

class CoffeeShopInitial extends CoffeeShopState {
  @override
  List<Object> get props => [];
}
