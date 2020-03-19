import 'package:flutter/material.dart';

showSnackbar(BuildContext context, Widget content) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Scaffold.of(context).showSnackBar(SnackBar(content: content));
  });
}

showSnackBarWithKey(GlobalKey<ScaffoldState> _scaffoldKey, Widget content,
    {SnackBarAction action}) {
  _scaffoldKey.currentState.showSnackBar(new SnackBar(
    content: content,
    action: action,
  ));
}
