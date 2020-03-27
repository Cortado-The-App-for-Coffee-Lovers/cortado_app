import 'package:cortado_app/src/bloc/auth/auth_bloc.dart';
import 'package:cortado_app/src/bloc/auth/bloc.dart';
import 'package:cortado_app/src/bloc/coffee_shop/bloc.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/locator.dart';
import 'package:cortado_app/src/repositories/coffee_shop_repository.dart';
import 'package:cortado_app/src/services/navigation_service.dart';
import 'package:cortado_app/src/ui/router.dart';
import 'package:cortado_app/src/ui/welcome.dart/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
          child: home(context)),
      onGenerateRoute: Router.onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }

  Widget home(BuildContext context) {
    // ignore: close_sinks
    var authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocListener(
      bloc: authBloc,
      listener: (context, state) {
        UserModel userModel = Provider.of<UserModel>(context, listen: false);

        if (state is SignedInState) {
          userModel.updateUser(state.user);
          Navigator.of(context).pushReplacementNamed(kHomeRoute);
        }
      },
      child: WelcomePage(),
    );
  }
}
