import 'package:flutter/material.dart';

class LatteLoader extends StatefulWidget {
  LatteLoader({Key key}) : super(key: key);

  @override
  _LatteLoaderState createState() => _LatteLoaderState();
}

class _LatteLoaderState extends State<LatteLoader> {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}