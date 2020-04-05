import 'package:cortado_app/src/bloc/coffee_shop/bloc.dart';
import 'package:cortado_app/src/data/coffee_shop.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/ui/coffee_shop/coffee_shop_list.dart';
import 'package:cortado_app/src/ui/drawer/drawer_home_page.dart';
import 'package:cortado_app/src/ui/widgets/app_bar_with_pic.dart';
import 'package:cortado_app/src/ui/widgets/cortado_search_bar.dart';
import 'package:cortado_app/src/ui/widgets/latte_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';

import '../style.dart';

class CoffeeShopsListPage extends DrawerPage {
  CoffeeShopsListPage(Widget drawer) : super(drawer);

  @override
  _CoffeeShopsListPageState createState() => _CoffeeShopsListPageState();
}

class _CoffeeShopsListPageState extends State<CoffeeShopsListPage> {
  // ignore: close_sinks
  CoffeeShopsBloc _coffeeShopsBloc;
  User user;
  List<CoffeeShop> _coffeeShops;

  @override
  void initState() {
    super.initState();
    _coffeeShopsBloc = BlocProvider.of<CoffeeShopsBloc>(context);
    _coffeeShopsBloc.add(GetCoffeeShops());
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserModel>(context).user;
    return Scaffold(
      backgroundColor: AppColors.light,
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: widget.drawer,
      ),
      body: BlocBuilder(
        bloc: _coffeeShopsBloc,
        builder: (context, state) {
          if (state is CoffeeShopsLoaded) {
            List<CoffeeShop> updatedCoffeeShops =
                _sortAndFilterCoffeeList(state.coffeeShops);
            return CustomScrollView(
              slivers: <Widget>[
                AppBarWithImage(
                  image: Container(
                      height: SizeConfig.screenHeight * .2,
                      child: Image.asset("assets/images/coffee_shop.png")),
                  actions: coffeeRedemptionWidget(user),
                  lower: CortadoSearchBar(),
                ),
                CoffeeShopsList(
                  coffeeShops: updatedCoffeeShops,
                  user: user,
                ),
              ],
            );
          }

          return Center(child: LatteLoader());
        },
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

List<Widget> coffeeRedemptionWidget(User user) {
  return <Widget>[
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
  ];
}
