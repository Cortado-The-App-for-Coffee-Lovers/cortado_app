import 'package:cortado_app/src/bloc/coffee_shop/bloc.dart';
import 'package:cortado_app/src/ui/account/account_page.dart';
import 'package:cortado_app/src/ui/map/coffee_map_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    _coffeeShopsBloc = BlocProvider.of<CoffeeShopsBloc>(context);
    _coffeeShopsBloc.add(GetCoffeeShops());
  }

  @override
  Widget build(BuildContext context) {
    Widget drawer = _drawer(context);

    switch (_currentRoute) {
      case DrawerRoute.coffeeShops:
        _currentPage = CoffeeShopsListPage(
          drawer,
        );
        break;
      case DrawerRoute.map:
        _currentPage = CoffeeShopMapPage(
          drawer,
        );
        break;
      case DrawerRoute.account:
        _currentPage = AccountPage(
          drawer,
        );
        break;

      default:
        _currentPage = CoffeeShopsListPage(
          drawer,
        );
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
              Stack(
                children: <Widget>[
                  Container(
                    color: Colors.transparent,
                    height: SizeConfig.screenHeight * .25,
                    alignment: Alignment.center,
                  ),
                  Positioned(
                    top: SizeConfig.screenHeight * .08,
                    left: 0,
                    child: Container(
                      width: SizeConfig.blockSizeVertical * .27,
                      height: SizeConfig.blockSizeVertical * .1,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage('assets/images/lid_top.png'))),
                    ),
                  ),
                  Positioned(
                    bottom: SizeConfig.safeBlockVertical * .04,
                    left: 0,
                    child: Container(
                      width: SizeConfig.screenHeight * .27,
                      height: SizeConfig.screenHeight * .1,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage('assets/images/lid_shadow.png'))),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      color: Color(0xFF703D19),
                      width: SizeConfig.screenHeight * .302,
                      height: SizeConfig.screenHeight * .02,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: SizeConfig.screenWidth * .8,
                      height: SizeConfig.screenHeight * .12,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image:
                                  AssetImage('assets/images/lid_bottom.png'))),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                    child: Stack(
                  children: <Widget>[
                    Container(
                        width: SizeConfig.screenWidth * .65,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image:
                                    AssetImage("assets/images/cup_body.png")))),
                    Positioned(
                      child: ClipPath(
                        clipper: CoffeeDrawerClipper(),
                        child: Container(
                          color: Color(0xFF703D19),
                          width: SizeConfig.screenHeight * .302,
                          height: SizeConfig.screenHeight * .02,
                        ),
                      ),
                    ),
                    ListView(
                      padding:
                          EdgeInsets.only(right: SizeConfig.screenWidth * .3),
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          height: SizeConfig.safeBlockVertical * .15,
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
                                  left: SizeConfig.screenWidth * .05),
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
                                  left: SizeConfig.screenWidth * .05),
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
                                  left: SizeConfig.screenWidth * .05),
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
    path.lineTo(size.width - 3, size.height);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
