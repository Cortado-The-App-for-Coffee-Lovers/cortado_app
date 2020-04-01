import 'package:cortado_app/src/data/coffee_shop.dart';
import 'package:cortado_app/src/ui/style.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CoffeeShopTile extends StatefulWidget {
  final CoffeeShop coffeeShop;
  final double userDistance;

  CoffeeShopTile({Key key, this.coffeeShop, this.userDistance})
      : super(key: key);

  @override
  _CoffeeShopTileState createState() => _CoffeeShopTileState();
}

class _CoffeeShopTileState extends State<CoffeeShopTile> {
  Geolocator geolocator = Geolocator();
  Future<double> distance;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8.0),
        child: Card(
          elevation: 0,
          color: AppColors.light,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 12.0, left: 8.0, bottom: 8.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.coffeeShop.name,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 26,
                          fontFamily: kFontFamilyNormal,
                          color: AppColors.dark),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Tab(
                      icon: Image.asset("assets/images/closed_sign.png"),
                    ),
                  )
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: Text(
                        widget.coffeeShop.address['street'],
                        style: TextStyles.kDefaultSmallTextStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 8.0,
                      ),
                      child: Text(
                        widget.coffeeShop.currentDistance
                                .toString()
                                .substring(0, 4) +
                            ' mi',
                        style: TextStyles.kDefaultDarkTextStyle,
                      ),
                    )
                  ])
            ],
          ),
        ));
  }
}
