import 'package:cortado_app/src/data/coffee_shop.dart';
import 'package:cortado_app/src/repositories/repository.dart';
import 'package:cortado_app/src/resources/coffee_shop_fb_provider.dart';

class CoffeeShopRepository extends Repository<CoffeeShop, String> {
  CoffeeShopFBProvider _coffeeShopFBProvider;

  @override
  CoffeeShop create(CoffeeShop entity) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  CoffeeShop delete(CoffeeShop entity) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  List<CoffeeShop> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  CoffeeShop readById(String id) {
    // TODO: implement readById
    throw UnimplementedError();
  }

  @override
  CoffeeShop update(CoffeeShop entity) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
