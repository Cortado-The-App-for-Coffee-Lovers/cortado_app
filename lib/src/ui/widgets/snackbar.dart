import 'package:flutter/material.dart';

showSnackbar(BuildContext context, Widget content) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: content,
      behavior: SnackBarBehavior.floating,
    ));
  });
}

showSnackBarWithKey(GlobalKey<ScaffoldState> scaffoldKey, Widget content,
    {SnackBarAction action}) {
  scaffoldKey.currentState.showSnackBar(new SnackBar(
    content: content,
    action: action,
  ));
}
