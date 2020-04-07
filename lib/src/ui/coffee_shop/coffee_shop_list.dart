import 'package:cortado_app/src/data/coffee_shop.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/ui/widgets/coffee_shop_tile.dart';
import 'package:cortado_app/src/ui/widgets/loading_container.dart';
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
  List<CoffeeShop> filteredList;
  @override
  void initState() {
    super.initState();
    filteredList = widget.coffeeShops
        .where((coffeeShop) => coffeeShop.currentDistance < 20.0)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        final int itemIndex = index ~/ 2;
        if (index.isEven) {
          if (filteredList[itemIndex] == null) return LoadingContainer();
          return CoffeeShopTile(
              coffeeShop: filteredList[itemIndex], user: widget.user);
        }
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          color: AppColors.dark,
          height: 2.0,
          width: SizeConfig.safeBlockHorizontal * .9,
        );
      },
      childCount: (filteredList.length * 2) - 1,
    ));
  }
}
