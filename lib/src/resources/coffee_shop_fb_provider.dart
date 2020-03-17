import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cortado_app/src/data/coffee_shop.dart';

class CoffeeShopFBProvider {
  final db = Firestore.instance.collection("coffee_shops");

  Future<void> addCoffeeShop(CoffeeShop coffeeShop) async {
    Map<String, dynamic> jsonRest = coffeeShop.toJson();
    return await db.document(jsonRest['id']).setData(jsonRest);
  }

  Future<void> updateCoffeeShop(CoffeeShop coffeeShop) async {
    Map<String, dynamic> jsonRest = coffeeShop.toJson();
    return await db.document(jsonRest['id']).setData(jsonRest, merge: true);
  }

  Future<void> deleteCoffeeShop(CoffeeShop coffeeShop) async {
    Map<String, dynamic> jsonRest = coffeeShop.toJson();
    return await db.document(jsonRest['id']).delete();
  }

  Future<CoffeeShop> fetchCoffeeShop(String id) async {
    CoffeeShop coffeeShop;
    await db.document(id).get().then((snapshot) async {
      if (snapshot?.data?.isNotEmpty ?? false) {
        coffeeShop = CoffeeShop.fromSnapshot(snapshot);
      }
    });
    return coffeeShop;
  }

  Future<List<CoffeeShop>> fetchAllCoffeeShops() async {
    List<CoffeeShop> coffeeShops = [];

    await db.getDocuments().then((querySnapshot) async {
      querySnapshot.documents.forEach((snapshot) {
        coffeeShops.add(CoffeeShop.fromSnapshot(snapshot));
      });
    });
    return coffeeShops;
  }
}

final coffeeShopFBProvider = CoffeeShopFBProvider();
