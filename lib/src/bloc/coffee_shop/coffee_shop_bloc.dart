import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cortado_app/src/bloc/coffee_shop/bloc.dart';
import 'package:cortado_app/src/constants.dart';
import 'package:cortado_app/src/data/coffee_shop.dart';
import 'package:cortado_app/src/repositories/coffee_shop_repository.dart';
import 'package:geolocator/geolocator.dart';

class CoffeeShopsBloc extends Bloc<CoffeeShopEvent, CoffeeShopState> {
  CoffeeShopRepository coffeeShopRepository;
  Stream<CoffeeShop> coffeeShopStream;
  List<CoffeeShop> _coffeeShops = [];

  Position _currentUserLocation;
  Geolocator geolocator = Geolocator();

  CoffeeShopsBloc(this.coffeeShopRepository) {
    _getCurrentLocation();

    geolocator
        .getPositionStream(LocationOptions(
            accuracy: LocationAccuracy.best, timeInterval: 1000))
        .listen((position) {
      _currentUserLocation = position;
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

        _coffeeShops = await coffeeListFromStream(coffeeShopStream);

        _coffeeShops = _sortAndFilterCoffeeList(_coffeeShops);

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
        _currentUserLocation.latitude,
        _currentUserLocation.longitude,
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
      _currentUserLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      _currentUserLocation = null;
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
