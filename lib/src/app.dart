import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cortado',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      //home: HomePage(),
      onGenerateRoute: Router.appRouter.generator,
    );
  }
}
