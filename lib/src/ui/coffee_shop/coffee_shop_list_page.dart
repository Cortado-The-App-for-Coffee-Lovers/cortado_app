import 'package:cortado_app/src/bloc/coffee_shop/bloc.dart';
import 'package:cortado_app/src/data/coffee_shop.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/ui/coffee_shop/coffee_shop_list.dart';
import 'package:cortado_app/src/ui/drawer/drawer_home_page.dart';
import 'package:cortado_app/src/ui/widgets/app_bar_with_pic.dart';
import 'package:cortado_app/src/ui/widgets/coffee_shop_tile.dart';
import 'package:cortado_app/src/ui/widgets/cortado_search_bar.dart';
import 'package:cortado_app/src/ui/widgets/latte_loader.dart';
import 'package:cortado_app/src/ui/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sortedmap/sortedmap.dart';
import '../style.dart';

class CoffeeShopsListPage extends DrawerPage {
  CoffeeShopsListPage(Widget drawer, this.user) : super(drawer);

  final User user;

  @override
  _CoffeeShopsListPageState createState() => _CoffeeShopsListPageState();
}

class _CoffeeShopsListPageState extends State<CoffeeShopsListPage> {
  User user;

  // ignore: close_sinks
  CoffeeShopsBloc _coffeeShopsBloc;

  Map<double, CoffeeShop> _currentCoffeeShopMap = {};

  @override
  void initState() {
    super.initState();
    _coffeeShopsBloc = BlocProvider.of<CoffeeShopsBloc>(context);
  }

  _coffeeShopImage() {
    return Container(
        height: SizeConfig.screenHeight * .2,
        child: Stack(
          children: <Widget>[
            Positioned(
                left: SizeConfig.screenWidth * .26,
                top: SizeConfig.screenHeight * .173,
                child: Image.asset("assets/images/left_plant.png")),
            Align(child: Image.asset("assets/images/coffee_shop.png")),
            Positioned(
                right: SizeConfig.screenWidth * .35,
                top: SizeConfig.screenHeight * .176,
                child: Image.asset("assets/images/right_plant.png")),
          ],
        ));
  }

  _onCoffeeSearch(dynamic input) {
    setState(() {
      _currentCoffeeShopMap = _updateCoffeeShopsMap(input);
    });
  }

  _updateCoffeeShopsMap(String input) {
    int len = input.length;
    String name;
    List<String> splitName;
    Map<double, CoffeeShop> filteredCoffeeShops =
        Map.from(_coffeeShopsBloc.coffeeMap);

    String inputUpper;

    if (input == '') {
      return _coffeeShopsBloc.coffeeMap;
    } else {
      splitName = input.split(' ');

      if (splitName.length > 1 && splitName[1] != '') {
        inputUpper = capitalize(splitName[0]) + " " + capitalize(splitName[1]);
      } else {
        inputUpper = capitalize(input);
      }

      filteredCoffeeShops.removeWhere((k, coffeeShop) {
        name = coffeeShop.name;
        return (name.substring(0, len) != input ||
            name.substring(0, len) != inputUpper);
      });

      return filteredCoffeeShops;
    }
  }

  String capitalize(String word) {
    return word[0].toUpperCase() + word.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.light,
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
          ),
          child: widget.drawer,
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            AppBarWithImage(
              image: _coffeeShopImage(),
              actions: coffeeRedemptionWidget(widget.user),
              lower: CortadoSearchBar(
                onChanged: _onCoffeeSearch,
              ),
            ),
            _currentCoffeeShopMap.isEmpty
                ? StreamBuilder(
                    stream: _coffeeShopsBloc.coffeeMapStream,
                    builder: (context,
                        AsyncSnapshot<SortedMap<double, CoffeeShop>> snapshot) {
                      if (snapshot.hasData) {
                        List<CoffeeShop> filteredList = snapshot.data.values
                            .toList()
                            .where((coffeeShop) =>
                                coffeeShop.currentDistance < 20.0)
                            .toList();
                        return CoffeeShopsList(
                            coffeeShops: filteredList, user: widget.user);
                      }

                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.screenHeight * .2),
                          child: Container(
                              constraints:
                                  BoxConstraints.tight(Size.fromHeight(40)),
                              child: LatteLoader()),
                        ),
                      );
                    },
                  )
                : CoffeeShopsList(
                    coffeeShops: _currentCoffeeShopMap.values.toList(),
                    user: widget.user)
          ],
        ));
  }
}
