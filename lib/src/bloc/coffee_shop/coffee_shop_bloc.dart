import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cortado_app/src/bloc/coffee_shop/bloc.dart';
import 'package:cortado_app/src/constants.dart';
import 'package:cortado_app/src/data/coffee_shop.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/repositories/coffee_shop_repository.dart';
import 'package:geolocator/geolocator.dart';

class CoffeeShopsBloc extends Bloc<CoffeeShopEvent, CoffeeShopState> {
  CoffeeShopRepository coffeeShopRepository;
  Stream<CoffeeShop> coffeeShopStream;
  List<CoffeeShop> _coffeeShops = [];
  User user;

  Geolocator geolocator = Geolocator();

  CoffeeShopsBloc(this.coffeeShopRepository, this.user) {
    _getCurrentLocation();

    geolocator
        .getPositionStream(LocationOptions(
            accuracy: LocationAccuracy.best, timeInterval: 1000))
        .listen((position) {
      user.currentLocation = position;
    });
  }

  @override
  CoffeeShopState get initialState => CoffeeShopInitial();

  @override
  Stream<CoffeeShopState> mapEventToState(
    CoffeeShopEvent event,
  ) async* {
    List<CoffeeShop> coffeeShops;

    if (event is GetCoffeeShops) {
      yield CoffeeShopsLoadingState();
      try {
        await _getCurrentLocation();
        coffeeShops = await coffeeShopRepository.read();
        Stream<CoffeeShop> coffeeShopStream = Stream.fromIterable(coffeeShops);

        coffeeShopStream = addDistancesToShops(coffeeShopStream);

        coffeeShops = await coffeeListFromStream(coffeeShopStream);

        _coffeeShops = _sortAndFilterCoffeeList(coffeeShops);

        yield CoffeeShopsLoaded(_coffeeShops);
      } catch (e) {
        yield CoffeeShopsError(kCoffeeShopsLoadingError);
      }
    }
  }

  List<CoffeeShop> get coffeeShops => _coffeeShops;
  Future<CoffeeShop> _getUserDistance(CoffeeShop coffeeShop) async {
    GeoPoint coffeeShopCoords = coffeeShop.address['coordinates'];

    double distance = await geolocator.distanceBetween(
        user.currentLocation.latitude,
        user.currentLocation.longitude,
        coffeeShopCoords.latitude,
        coffeeShopCoords.longitude);

    distance = distance / 1609;
    coffeeShop.currentDistance = distance;

    return coffeeShop;
  }

  List<CoffeeShop> _sortAndFilterCoffeeList(List<CoffeeShop> coffeeShops) {
    List<CoffeeShop> sortedAndFilterList;
    coffeeShops.sort((a, b) => a.currentDistance.compareTo(b.currentDistance));
    sortedAndFilterList = coffeeShops.where((coffeeShop) {
      if (coffeeShop.currentDistance > 20.0)
        return false;
      else
        return true;
    }).toList();
    return sortedAndFilterList;
  }

  Future<void> _getCurrentLocation() async {
    try {
      user.currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      user.currentLocation = null;
    }
  }

  Stream<CoffeeShop> addDistancesToShops(
      Stream<CoffeeShop> coffeeShops) async* {
    CoffeeShop updatedCoffeeShop;
    await for (CoffeeShop coffeeShop in coffeeShops) {
      updatedCoffeeShop = await _getUserDistance(coffeeShop);
      yield updatedCoffeeShop;
    }
  }

  Future<List<CoffeeShop>> coffeeListFromStream(
      Stream<CoffeeShop> stream) async {
    List<CoffeeShop> updatedCoffeeShops = [];
    await for (CoffeeShop coffeeShop in stream) {
      updatedCoffeeShops.add(coffeeShop);
    }
    return updatedCoffeeShops;
  }
}
