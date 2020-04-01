import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LatteLoader extends StatefulWidget {
  LatteLoader({Key key}) : super(key: key);

  @override
  _LatteLoaderState createState() => _LatteLoaderState();
}

class _LatteLoaderState extends State<LatteLoader> {
  @override
  Widget build(BuildContext context) {
    return SpinKitRotatingCircle(
      itemBuilder: (context, index) {
        return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/latte_spin.png'))));
      },
    );
  }
}
