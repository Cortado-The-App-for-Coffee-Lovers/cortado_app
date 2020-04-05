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

  List<CoffeeShop> _currentCoffeeShopList;

  @override
  void initState() {
    super.initState();
    _coffeeShopsBloc = BlocProvider.of<CoffeeShopsBloc>(context);
    _coffeeShopsBloc.add(GetCoffeeShops());
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
      _currentCoffeeShopList = _updateCoffeeShopsList(input);
    });
  }

  _updateCoffeeShopsList(String input) {
    int len = input.length;
    String name;
    List<String> splitName;
    List<CoffeeShop> filteredCoffeeShops;
    String inputUpper;

    if (input == '') {
      return _coffeeShopsBloc.coffeeShops;
    } else {
      splitName = input.split(' ');

      if (splitName.length > 1 && splitName[1] != '') {
        inputUpper = capitalize(splitName[0]) + " " + capitalize(splitName[1]);
      } else {
        inputUpper = capitalize(input);
      }

      filteredCoffeeShops = _coffeeShopsBloc.coffeeShops.where((coffeeShop) {
        name = coffeeShop.name;
        return (name.substring(0, len) == input ||
            name.substring(0, len) == inputUpper);
      }).toList();

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
      body: BlocConsumer(
        bloc: _coffeeShopsBloc,
        listener: (BuildContext context, state) {
          if (state is CoffeeShopsLoaded) {
            setState(() {
              _currentCoffeeShopList = state.coffeeShops;
            });
          }
        },
        builder: (context, state) {
          if (state is CoffeeShopsLoaded) {
            return CustomScrollView(
              slivers: <Widget>[
                AppBarWithImage(
                  image: _coffeeShopImage(),
                  actions: coffeeRedemptionWidget(widget.user),
                  lower: CortadoSearchBar(
                    onChanged: _onCoffeeSearch,
                  ),
                ),
                CoffeeShopsList(
                  coffeeShops:
                      _currentCoffeeShopList ?? _coffeeShopsBloc.coffeeShops,
                  user: widget.user,
                ),
              ],
            );
          }

          return Center(child: LatteLoader());
        },
      ),
    );
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
