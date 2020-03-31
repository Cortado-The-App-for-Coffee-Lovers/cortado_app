import 'package:cortado_app/src/ui/account/account_page.dart';
import 'package:cortado_app/src/ui/map/coffee_map_page.dart';
import 'package:flutter/material.dart';
import '../coffee_shop/coffee_shop_page.dart';

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

  _DrawerHomePageState(this._currentRoute);

  @override
  Widget build(BuildContext context) {
    Widget drawer = _drawer(context);

    switch (_currentRoute) {
      case DrawerRoute.coffeeShops:
        _currentPage = CoffeeShopsPage(
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
        _currentPage = CoffeeShopsPage(
          drawer,
        );
    }

    return _currentPage;
  }

  _drawer(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: SizeConfig.safeBlockHorizontal * .6,
      child: Drawer(
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 200,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                  ),
                  Positioned(
                    top: 80,
                    left: 0,
                    child: Container(
                      width: SizeConfig.safeBlockHorizontal * .5,
                      height: SizeConfig.safeBlockVertical * .07,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/lid_top.png'))),
                    ),
                  ),
                  Positioned(
                    bottom: 25,
                    left: 0,
                    child: Container(
                      width: SizeConfig.safeBlockHorizontal * .5,
                      height: SizeConfig.safeBlockVertical * .085,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage('assets/images/lid_shadow.png'))),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25.0),
                        bottomRight: Radius.circular(25.0),
                      ),
                      child: Container(
                        width: SizeConfig.safeBlockHorizontal * .7,
                        height: SizeConfig.safeBlockVertical * .05,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/images/lid_bottom.png'))),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                    child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 163, right: 40),
                      child: Container(
                          width: SizeConfig.blockSizeHorizontal * .8,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/cup_body.png")))),
                    ),
                    Positioned(
                      child: Container(
                        color: Color(0xFF703D19),
                        width: SizeConfig.safeBlockHorizontal * .51,
                        height: SizeConfig.safeBlockVertical * .025,
                      ),
                    ),
                    ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          height: SizeConfig.safeBlockVertical * .15,
                        ),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.only(bottom: 45),
                            child: Text(
                              'Coffee Shops',
                              style: TextStyles.kDefaultLightTextStyle,
                            ),
                          ),
                          onTap: () {
                            _changeRoute(context, DrawerRoute.coffeeShops);
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.only(bottom: 45),
                            child: Text(
                              'Coffee Map',
                              style: TextStyles.kDefaultLightTextStyle,
                            ),
                          ),
                          onTap: () {
                            _changeRoute(context, DrawerRoute.map);
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.only(bottom: 45),
                            child: Text(
                              'Account',
                              style: TextStyles.kDefaultLightTextStyle,
                            ),
                          ),
                          onTap: () {
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
    path.lineTo(size.width / 1.5, size.height);

    path.lineTo(size.width - 30, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
