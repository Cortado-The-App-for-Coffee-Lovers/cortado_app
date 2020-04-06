import 'package:cortado_app/src/bloc/coffee_shop/bloc.dart';
import 'package:cortado_app/src/data/coffee_shop.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/ui/account/account_page.dart';
import 'package:cortado_app/src/ui/map/coffee_map_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../coffee_shop/coffee_shop_list_page.dart';

import '../style.dart';

class DrawerHomePage extends StatefulWidget {
  final DrawerRoute initialRoute;

  const DrawerHomePage({
    Key key,
    this.initialRoute = DrawerRoute.coffeeShops,
  }) : super(key: key);

  @override
  _DrawerHomePageState createState() => _DrawerHomePageState(initialRoute);
}

class _DrawerHomePageState extends State<DrawerHomePage> {
  User user;
  List<CoffeeShop> coffeeShops;

  DrawerRoute _currentRoute;
  DrawerPage _currentPage;

  CoffeeShopsBloc _coffeeShopsBloc;
  _DrawerHomePageState(this._currentRoute);

  bool _coffeeShopsSelected = true;
  bool _coffeeMapSelected = false;
  bool _accountSelected = false;

  @override
  void initState() {
    super.initState();

    // initiate coffee shop list request
    _coffeeShopsBloc = BlocProvider.of<CoffeeShopsBloc>(context);
    _coffeeShopsBloc.add(GetCoffeeShops());
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserModel>(context).user;
    Widget drawer = _drawer(context);

    switch (_currentRoute) {
      case DrawerRoute.coffeeShops:
        _currentPage = CoffeeShopsListPage(drawer, user);
        break;
      case DrawerRoute.map:
        _currentPage = CoffeeShopMapPage(drawer, user);
        break;
      case DrawerRoute.account:
        _currentPage = AccountPage(drawer, user);
        break;

      default:
        _currentPage = CoffeeShopsListPage(drawer, user);
    }

    return _currentPage;
  }

  _drawer(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: SizeConfig.screenWidth,
      child: Drawer(
        elevation: 0,
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                    child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: SizeConfig.screenHeight * .05,
                      left: 0,
                      child: Container(
                        width: SizeConfig.blockSizeVertical * .3,
                        height: SizeConfig.blockSizeVertical * .11,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image:
                                    AssetImage('assets/images/lid_top.png'))),
                      ),
                    ),
                    Positioned(
                      top: SizeConfig.screenHeight * .105,
                      left: 0,
                      child: Container(
                        width: SizeConfig.screenWidth * .65,
                        height: SizeConfig.screenHeight * .04,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: AssetImage(
                                    'assets/images/lid_shadow.png'))),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                          height: SizeConfig.screenHeight * .815,
                          width: SizeConfig.screenWidth * .685,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: AssetImage(
                                      "assets/images/cup_body.png")))),
                    ),
                    Positioned(
                      top: SizeConfig.screenHeight * .208,
                      child: ClipPath(
                        clipper: CoffeeDrawerClipper(),
                        child: Container(
                          color: Color(0xFF703D19),
                          width: SizeConfig.screenHeight * .315,
                          height: SizeConfig.screenHeight * .03,
                        ),
                      ),
                    ),
                    Positioned(
                      top: SizeConfig.screenHeight * .1,
                      left: 0,
                      child: Container(
                        width: SizeConfig.screenWidth * .83,
                        height: SizeConfig.screenHeight * .13,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                    'assets/images/lid_bottom.png'))),
                      ),
                    ),
                    ListView(
                      padding:
                          EdgeInsets.only(right: SizeConfig.screenWidth * .24),
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          height: SizeConfig.screenHeight * .3,
                        ),
                        GestureDetector(
                          child: Container(
                            decoration: _coffeeShopsSelected
                                ? BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        image: AssetImage(
                                            "assets/images/coffee_guard.png")))
                                : BoxDecoration(),
                            child: Container(
                              height: SizeConfig.screenHeight * .1,
                              padding: EdgeInsets.only(
                                  top: SizeConfig.screenHeight * .039,
                                  left: SizeConfig.screenWidth * .09),
                              child: Text(
                                'Coffee Shops',
                                style: _coffeeShopsSelected
                                    ? TextStyles.kCoffeeDrawerSelectedTextStyle
                                    : TextStyles.kCoffeeDrawerTextStyle,
                              ),
                            ),
                          ),
                          onTap: () {
                            _moveCoffeeGuard(0);
                            _changeRoute(context, DrawerRoute.coffeeShops);
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            decoration: _coffeeMapSelected
                                ? BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        image: AssetImage(
                                            "assets/images/coffee_guard.png")))
                                : BoxDecoration(),
                            child: Container(
                              height: SizeConfig.screenHeight * .1,
                              padding: EdgeInsets.only(
                                  top: SizeConfig.screenHeight * .039,
                                  left: SizeConfig.screenWidth * .09),
                              child: Text(
                                'Coffee Map',
                                style: _coffeeMapSelected
                                    ? TextStyles.kCoffeeDrawerSelectedTextStyle
                                    : TextStyles.kCoffeeDrawerTextStyle,
                              ),
                            ),
                          ),
                          onTap: () {
                            _moveCoffeeGuard(1);
                            _changeRoute(context, DrawerRoute.map);
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            decoration: _accountSelected
                                ? BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fitWidth,
                                        image: AssetImage(
                                            "assets/images/coffee_guard.png")))
                                : BoxDecoration(),
                            child: Container(
                              height: SizeConfig.screenHeight * .1,
                              padding: EdgeInsets.only(
                                  top: SizeConfig.screenHeight * .039,
                                  left: SizeConfig.screenWidth * .09),
                              child: Text(
                                'My Account',
                                style: _accountSelected
                                    ? TextStyles.kCoffeeDrawerSelectedTextStyle
                                    : TextStyles.kCoffeeDrawerTextStyle,
                              ),
                            ),
                          ),
                          onTap: () {
                            _moveCoffeeGuard(2);
                            _changeRoute(context, DrawerRoute.account);
                          },
                        ),
                      ],
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _moveCoffeeGuard(int index) {
    switch (index) {
      case 0:
        setState(() {
          _coffeeShopsSelected = true;
          _coffeeMapSelected = false;
          _accountSelected = false;
        });
        break;
      case 1:
        setState(() {
          _coffeeShopsSelected = false;
          _coffeeMapSelected = true;
          _accountSelected = false;
        });
        break;

      case 2:
        setState(() {
          _coffeeShopsSelected = false;
          _coffeeMapSelected = false;
          _accountSelected = true;
        });
        break;
    }
  }

  _changeRoute(BuildContext context, DrawerRoute route) async {
    Navigator.of(context).pop();
    await Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _currentRoute = route;
      });
    });
  }
}

enum DrawerRoute { coffeeShops, map, account }

abstract class DrawerPage extends StatefulWidget {
  final Widget drawer;

  DrawerPage(this.drawer, {Key key});
}

class CoffeeDrawerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width - 2, size.height);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

List<Widget> coffeeRedemptionWidget(User user) {
  return <Widget>[
    Container(
      margin: EdgeInsets.only(right: SizeConfig.screenWidth * .03),
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
