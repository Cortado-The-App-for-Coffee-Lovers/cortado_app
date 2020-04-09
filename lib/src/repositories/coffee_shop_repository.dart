import 'package:cortado_app/src/data/coffee_shop.dart';
import 'package:cortado_app/src/repositories/repository.dart';
import 'package:cortado_app/src/resources/coffee_shop_fb_provider.dart';

class CoffeeShopRepository extends Repository<CoffeeShop, String> {
  @override
  Future<void> create(CoffeeShop coffeeShop) {
    return coffeeShopFBProvider.addCoffeeShop(coffeeShop);
  }

  @override
  Future<void> delete(CoffeeShop coffeeShop) {
    return coffeeShopFBProvider.deleteCoffeeShop(coffeeShop);
  }

  @override
  Future<List<CoffeeShop>> read() {
    return coffeeShopFBProvider.fetchAllCoffeeShops();
  }

  @override
  Future<CoffeeShop> readById(String id) {
    return coffeeShopFBProvider.fetchCoffeeShop(id);
  }

  @override
  Future<void> update(CoffeeShop coffeeShop) {
    return coffeeShopFBProvider.updateCoffeeShop(coffeeShop);
  }
}
