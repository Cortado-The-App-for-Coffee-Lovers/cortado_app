import 'package:flutter/material.dart';

import '../style.dart';

class CortadoButton extends StatelessWidget {
  const CortadoButton({Key key, this.text, this.onTap, this.color})
      : super(key: key);
  final String text;
  final Color color;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: GestureDetector(
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: kFontFamilyNormal,
                  fontSize: 28,
                  color: color ?? AppColors.caramel,
                ),
              ),
              onTap: onTap),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          color: color ?? AppColors.caramel,
          height: 1.0,
          width: SizeConfig.safeBlockHorizontal * .5,
        ),
      ],
    );
  }
}
