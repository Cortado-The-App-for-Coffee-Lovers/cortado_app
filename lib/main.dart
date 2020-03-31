import 'package:cortado_app/src/app.dart';
import 'package:cortado_app/src/bloc/auth/bloc.dart';
import 'package:cortado_app/src/bloc/coffee_shop/bloc.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/repositories/coffee_shop_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'src/bloc/sign_up/bloc.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black, //top bar color
    statusBarIconBrightness: Brightness.dark, //top bar icons
    //bottom bar color
    systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
  ));
  CoffeeShopRepository _coffeeShopRepository = CoffeeShopRepository();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(),
        ),
        BlocProvider<SignUpBloc>(create: (_) => SignUpBloc()),
        BlocProvider<CoffeeShopsBloc>(create: (_) => CoffeeShopsBloc(_coffeeShopRepository)),

      ],
      child: ChangeNotifierProvider(
          create: (BuildContext context) => UserModel(), child: App())));
}
