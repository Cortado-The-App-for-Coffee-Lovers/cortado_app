import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cortado_app/src/data/coffee_shop.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CoffeeShopTile extends StatefulWidget {
  final CoffeeShop coffeeShop;
  final Position currentUserLocation;

  CoffeeShopTile({Key key, this.coffeeShop, this.currentUserLocation})
      : super(key: key);

  @override
  _CoffeeShopTileState createState() => _CoffeeShopTileState();
}

class _CoffeeShopTileState extends State<CoffeeShopTile> {
  Geolocator geolocator = Geolocator();
  Position _currentUserLocation;
  GeoPoint _coffeeShopLocation;
  Future<double> distance;

  @override
  void initState() {
    super.initState();
    _currentUserLocation = widget.currentUserLocation;
    _coffeeShopLocation = widget.coffeeShop.address["coordinates"];
    distance = _getUserDistance();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: distance,
          builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
            return Card(
              elevation: 2,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://firebasestorage.googleapis.com/v0/b/cortado-f9ae2.appspot.com/o/coffee_shop_pics%2Fcoffee-shop-default.jpg?alt=media&token=f6177afd-253a-441f-aea5-5bc3860699a7'))),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12.0, left: 12, bottom: 6.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.coffeeShop.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(widget.coffeeShop.address['street']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(snapshot.data.toString().substring(0, 4) +
                              ' mi away'),
                        )
                      ])
                ],
              ),
            );
          },
        ));
  }

  Future<double> _getUserDistance() async {
    return await geolocator
        .distanceBetween(
            _currentUserLocation.latitude,
            _currentUserLocation.longitude,
            _coffeeShopLocation.latitude,
            _coffeeShopLocation.longitude)
        .then((distance) {
      return distance / 1609;
    });
  }
}
