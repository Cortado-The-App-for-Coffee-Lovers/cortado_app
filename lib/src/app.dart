import 'package:cortado_app/src/bloc/auth/auth_bloc.dart';
import 'package:cortado_app/src/bloc/auth/bloc.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/locator.dart';
import 'package:cortado_app/src/services/navigation_service.dart';
import 'package:cortado_app/src/ui/auth/user_observer.dart';
import 'package:cortado_app/src/ui/home/home.dart';
import 'package:cortado_app/src/ui/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'ui/style.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    registerLocatorItems();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black, //top bar color
      statusBarIconBrightness: Brightness.dark, //top bar icons
      //bottom bar color
      systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
    ));
    BlocProvider.of<AuthBloc>(context).add(AppStarted());

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: UserObserver(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Cortado',
          theme: ThemeData(
            primarySwatch: Colors.brown,
          ),
          home: home(context),
          onGenerateRoute: Router.onGenerateRoute,
          navigatorKey: locator<NavigationService>().navigatorKey,
        ),
      ),
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
      child: HomePage(),
    );
  }
}
