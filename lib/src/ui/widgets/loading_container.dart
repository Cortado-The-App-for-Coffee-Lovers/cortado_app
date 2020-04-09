import 'package:cortado_app/src/ui/style.dart';
import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListTile(
        title: buildBox(),
        subtitle: buildBox(),
      ),
      Divider(
        height: 8.0,
        color: AppColors.dark,
      )
    ]);
  }

  Widget buildBox() {
    return Container(
      color: AppColors.caramel,
      height: 25.0,
      width: 150.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
    );
  }
}
