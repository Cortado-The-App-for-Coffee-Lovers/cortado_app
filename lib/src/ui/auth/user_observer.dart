import 'package:cortado_app/src/bloc/auth/auth_bloc.dart';
import 'package:cortado_app/src/bloc/auth/auth_event.dart';
import 'package:cortado_app/src/services/auth_service.dart';
import 'package:cortado_app/src/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/async.dart';

import '../../locator.dart';

class UserObserver extends StatefulWidget {
  final Widget child;

  const UserObserver({Key key, this.child}) : super(key: key);

  @override
  _UserObserverState createState() => _UserObserverState();
}

class _UserObserverState extends State<UserObserver>
    with WidgetsBindingObserver {
  AuthService get _authService => locator.get();
  CountdownTimer _timer;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _timer?.cancel();
      _startTimer();
    } else if (state == AppLifecycleState.paused) {
      _timer?.cancel();
    }
  }

  _startTimer() {
    _timer = CountdownTimer(Duration(days: 1), Duration(minutes: 30))
      ..listen((_) async {
        var user = await _authService.getCurrentUser();
        print('Checking user...');
        if (user != null) {
          var navigatorState =
              locator<NavigationService>().navigatorKey.currentState;
          navigatorState.popUntil((route) => route.isFirst);
          BlocProvider.of<AuthBloc>(context).add(SignOutInActiveUser());
          navigatorState.pushReplacementNamed("/");
          _timer?.cancel();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
