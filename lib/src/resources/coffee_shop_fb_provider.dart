import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cortado_app/src/data/coffee_shop.dart';

class CoffeeShopFBProvider {
  final db = Firestore.instance.collection("coffee_shops");

  Future<int> addCoffeeShop(Map<String, dynamic> jsonRest) async {
    await db.document(jsonRest['id']).setData(jsonRest);
  }

  Future<int> updateCoffeeShop(Map<String, dynamic> jsonRest) async {
    await db.document(jsonRest['id']).setData(jsonRest, merge: true);
  }

  Future<CoffeeShop> fetchCoffeeShop(String apiKey) async {
    CoffeeShop restaurant;
    await db.document(apiKey).get().then((snapshot) async {
      if (snapshot?.data?.isNotEmpty ?? false) {
        restaurant = CoffeeShop.fromDb(snapshot.data);
      }
    });
    return restaurant;
  }
}
