import 'package:cortado_app/src/bloc/auth/auth_bloc.dart';
import 'package:cortado_app/src/bloc/auth/bloc.dart';
import 'package:cortado_app/src/bloc/sign_up/bloc.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/locator.dart';
import 'package:cortado_app/src/services/navigation_service.dart';
import 'package:cortado_app/src/ui/home/home.dart';
import 'package:cortado_app/src/ui/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
    BlocProvider.of<AuthBloc>(context).add(AppStarted());
    return MaterialApp(
      title: 'Cortado',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<SignUpBloc>(create: (context) => SignUpBloc())
        ],
        child: home(context),
      ),
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
      child: HomePage(),
    );
  }
}
