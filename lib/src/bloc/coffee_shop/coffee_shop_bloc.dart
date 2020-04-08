import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cortado_app/src/bloc/coffee_shop/bloc.dart';
import 'package:cortado_app/src/constants.dart';
import 'package:cortado_app/src/data/coffee_shop.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/repositories/coffee_shop_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sortedmap/sortedmap.dart';

class CoffeeShopsBloc extends Bloc<CoffeeShopEvent, CoffeeShopState> {
  CoffeeShopsBloc(this.coffeeShopRepository, this.user) {
    _getCurrentLocation();
    coffeeSubject.transform(_transformCoffeeShops()).pipe(_coffeeOutput);
    geolocator
        .getPositionStream(LocationOptions(
            accuracy: LocationAccuracy.best, timeInterval: 1000))
        .listen((position) {
      user.currentLocation = position;
    });
  }

  SortedMap<double, CoffeeShop> coffeeMap = SortedMap(Ordering.byKey());
  CoffeeShopRepository coffeeShopRepository;
  var coffeeSubject = PublishSubject<CoffeeShop>();
  final _coffeeOutput = BehaviorSubject<Map<double, CoffeeShop>>();

  Geolocator geolocator = Geolocator();
  User user;

  @override
  CoffeeShopState get initialState => CoffeeShopInitial();

  ValueStream<Map<double, CoffeeShop>> get coffeeMapStream =>
      _coffeeOutput.stream;

  @override
  Stream<CoffeeShopState> mapEventToState(
    CoffeeShopEvent event,
  ) async* {
    List<CoffeeShop> coffeeShops;

    if (event is GetCoffeeShops && coffeeMap.isEmpty) {
      yield CoffeeShopsLoadingState();
      try {
        await _getCurrentLocation();
        coffeeShops = await coffeeShopRepository.read();

        Stream<CoffeeShop> coffeeShopStream = Stream.fromIterable(coffeeShops);

        coffeeShopStream = addDistancesToShops(coffeeShopStream);

        coffeeShops = await coffeeListFromStream(coffeeShopStream);

        yield CoffeeShopsLoaded();
      } catch (e) {
        yield CoffeeShopsError(kCoffeeShopsLoadingError);
      }
    }
  }

  _transformCoffeeShops() {
    return ScanStreamTransformer(
        (Map<double, CoffeeShop> cache, CoffeeShop coffeeShop, index) {
      if (coffeeShop.currentDistance < 20) {
        cache[coffeeShop.currentDistance] = coffeeShop;
        coffeeMap.addAll({coffeeShop.currentDistance: coffeeShop});
      }

      return cache;
    }, <double, CoffeeShop>{});
  }

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
      coffeeMap.addAll({updatedCoffeeShop.currentDistance: updatedCoffeeShop});
      coffeeSubject.add(updatedCoffeeShop);
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
