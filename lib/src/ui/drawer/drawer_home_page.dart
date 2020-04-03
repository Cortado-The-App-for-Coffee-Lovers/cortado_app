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
      child: Drawer(
        elevation: 0,
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: SizeConfig.screenHeight * .2,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                  ),
                  Positioned(
                    bottom: SizeConfig.screenHeight * .07,
                    left: 0,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(12.0)),
                      child: Container(
                        width: SizeConfig.blockSizeVertical * .24,
                        height: SizeConfig.blockSizeVertical * .07,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    AssetImage('assets/images/lid_top.png'))),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: SizeConfig.safeBlockVertical * .02,
                    left: 0,
                    child: Container(
                      width: SizeConfig.screenHeight * .245,
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
                      width: SizeConfig.screenHeight * .25,
                      height: SizeConfig.screenHeight * .02,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        bottomRight: Radius.circular(50.0),
                      ),
                      child: Container(
                        width: SizeConfig.screenHeight * .32,
                        height: SizeConfig.blockSizeVertical * .1,
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
                      padding:
                          EdgeInsets.only(right: SizeConfig.screenWidth * .2),
                      child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      "assets/images/cup_body.png")))),
                    ),
                    Positioned(
                      child: ClipPath(
                        clipper: CoffeeDrawerClipper(),
                        child: Container(
                          color: Color(0xFF703D19),
                          width: SizeConfig.screenHeight * .25,
                          height: SizeConfig.screenHeight * .02,
                        ),
                      ),
                    ),
                    ListView(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeVertical * .03,
                          vertical: 30),
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
                              style: TextStyles.kCoffeeDrawerTextStyle,
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
                              style: TextStyles.kCoffeeDrawerTextStyle,
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
                              'My Account',
                              style: TextStyles.kCoffeeDrawerTextStyle,
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
    path.lineTo(size.width - 3, size.height);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
