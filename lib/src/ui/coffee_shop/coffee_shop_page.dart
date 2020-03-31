import 'package:cortado_app/src/bloc/coffee_shop/bloc.dart';
import 'package:cortado_app/src/data/coffee_shop.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/repositories/coffee_shop_repository.dart';
import 'package:cortado_app/src/ui/drawer/drawer_home_page.dart';
import 'package:cortado_app/src/ui/widgets/coffee_shop_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../style.dart';

class CoffeeShopsPage extends DrawerPage {
  CoffeeShopsPage(Widget drawer) : super(drawer);

  @override
  _CoffeeShopsPageState createState() => _CoffeeShopsPageState();
}

class _CoffeeShopsPageState extends State<CoffeeShopsPage> {
  CoffeeShopsBloc _coffeeShopsBloc;
  User user;

  @override
  void initState() {
    super.initState();
    _coffeeShopsBloc = BlocProvider.of<CoffeeShopsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserModel>(context).user;
    return Scaffold(
      backgroundColor: AppColors.light,
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 25.0),
            child: Row(
              children: <Widget>[
                user.redemptionsLeft != null
                    ? Text(user.redemptionsLeft.toString())
                    : Tab(icon: (Image.asset("assets/images/infinity.png"))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Tab(
                    icon: Image.asset("assets/images/icons/coffee.png"),
                  ),
                ),
              ],
            ),
          ),
        ],
        iconTheme: IconThemeData(color: AppColors.dark),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          // Set the transparency here
          canvasColor: Colors
              .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
        ),
        child: widget.drawer,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: SizeConfig.blockSizeVertical * .15,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: SizeConfig.safeBlockHorizontal * .23,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    color: AppColors.dark,
                    height: 2.0,
                    width: SizeConfig.safeBlockHorizontal * .9,
                  ),
                ),
                Positioned(
                  child: Container(
                      height: SizeConfig.blockSizeVertical * .27,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/coffee_shop.png')))),
                ),
              ],
            ),
          ),
          BlocBuilder(
              bloc: _coffeeShopsBloc,
              builder: (BuildContext context, state) {
                if (state is CoffeeShopsLoaded) {
                  List<CoffeeShop> updatedCoffeeShopList;
                  updatedCoffeeShopList =
                      _sortAndFilterCoffeeList(state.coffeeShops);
                  return Container(
                    height: SizeConfig.blockSizeVertical * .7,
                    child: ListView.separated(
                      itemCount: updatedCoffeeShopList.length,
                      itemBuilder: (context, index) {
                        CoffeeShop coffeeShop = updatedCoffeeShopList[index];

                        return CoffeeShopTile(coffeeShop: coffeeShop);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 16.0),
                          color: AppColors.dark,
                          height: 2.0,
                          width: SizeConfig.safeBlockHorizontal * .9,
                        );
                      },
                    ),
                  );
                }
                return Container(
                    padding:
                        EdgeInsets.only(top: SizeConfig.safeBlockVertical * .3),
                    child: CircularProgressIndicator());
              }),
        ],
      ),
    );
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
}
