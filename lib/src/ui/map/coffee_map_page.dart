import 'package:cortado_app/src/ui/drawer/drawer_home_page.dart';
import 'package:flutter/material.dart';

import '../style.dart';

class CoffeeShopMapPage extends DrawerPage {
  CoffeeShopMapPage(Widget drawer) : super(drawer);

  @override
  _CoffeeShopMapPageState createState() => _CoffeeShopMapPageState();
}

class _CoffeeShopMapPageState extends State<CoffeeShopMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.light,
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.dark),
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            // Set the transparency here
            canvasColor: Colors
                .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
          ),
          child: widget.drawer,
        ));
  }
}
