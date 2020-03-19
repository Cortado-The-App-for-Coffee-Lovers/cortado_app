import 'package:cortado_app/src/bloc/coffee_shop/bloc.dart';
import 'package:cortado_app/src/locator.dart';
import 'package:cortado_app/src/repositories/coffee_shop_repository.dart';
import 'package:cortado_app/src/ui/home/home_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  CoffeeShopRepository _coffeeShopRepository;
  @override
  void initState() {
    super.initState();
    registerLocatorItems();
    _coffeeShopRepository = CoffeeShopRepository();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cortado',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: BlocProvider<CoffeeShopsBloc>(
          create: (context) => CoffeeShopsBloc(_coffeeShopRepository),
          child: HomePage()),
      onGenerateRoute: Router.appRouter.generator,
    );
  }
}
