import 'package:cortado_app/src/data/coffee_shop.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/ui/widgets/coffee_shop_tile.dart';
import 'package:flutter/material.dart';

import '../style.dart';

class CoffeeShopsList extends StatefulWidget {
  CoffeeShopsList({Key key, this.coffeeShops, this.user}) : super(key: key);
  final List<CoffeeShop> coffeeShops;
  final User user;

  @override
  _CoffeeShopsListState createState() => _CoffeeShopsListState();
}

class _CoffeeShopsListState extends State<CoffeeShopsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        final int itemIndex = index ~/ 2;
        if (index.isEven) {
          return CoffeeShopTile(
              coffeeShop: widget.coffeeShops[itemIndex], user: widget.user);
        }
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          color: AppColors.dark,
          height: 2.0,
          width: SizeConfig.safeBlockHorizontal * .9,
        );
      },
      childCount: (widget.coffeeShops.length * 2) - 1,
    ));
  }
}
