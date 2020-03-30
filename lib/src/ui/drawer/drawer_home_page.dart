import 'package:cortado_app/src/ui/account/account_page.dart';
import 'package:cortado_app/src/ui/map/coffee_map_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../data/user.dart';
import '../../bloc/auth/bloc.dart';
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
    Drawer drawer = _drawer(context);

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
    // ignore: close_sinks
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    var user = Provider.of<UserModel>(context).user;
    var itemStyle = TextStyle(
      fontFamily: kFontFamilyNormal,
      fontSize: 18,
      color: AppColors.light,
    );
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 250,
            color: AppColors.dark,
            alignment: Alignment.center,
            child: Material(
              type: MaterialType.transparency,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                    top: 48,
                    right: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Spacer(
                        flex: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8,
                          left: 24,
                        ),
                        child: Text(
                          user?.displayName ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: kFontFamilyNormal,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Text(
                          user?.email ?? "",
                          style: TextStyle(
                            color: Colors.white.withAlpha(140),
                            fontFamily: kFontFamilyNormal,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(left: 16),
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  height: 16,
                ),
                GestureDetector(
                  child: Text(
                    'Coffee Shops',
                    style: itemStyle,
                  ),
                  onTap: () {
                    _changeRoute(context, DrawerRoute.coffeeShops);
                  },
                ),
                GestureDetector(
                  child: Text(
                    'Coffee Map',
                    style: itemStyle,
                  ),
                  onTap: () {
                    _changeRoute(context, DrawerRoute.map);
                  },
                ),
                GestureDetector(
                  child: Text(
                    'Account',
                    style: itemStyle,
                  ),
                  onTap: () {
                    _changeRoute(context, DrawerRoute.account);
                  },
                ),
                ListTile(
                  title: Text(
                    'Log Out',
                    style: itemStyle,
                  ),
                  leading: Image.asset(
                    'images/logout.png',
                    height: 18,
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await Future.delayed(Duration(milliseconds: 200), () {
                      authBloc.add(SignOut());
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/',
                        (Route<dynamic> route) => false,
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        ],
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
  final Drawer drawer;

  DrawerPage(this.drawer, {Key key});
}
