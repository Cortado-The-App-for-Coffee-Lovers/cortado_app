import 'package:flutter/material.dart';

import '../style.dart';

class CortadoButton extends StatelessWidget {
  const CortadoButton(
      {Key key,
      this.text,
      this.onTap,
      this.color,
      this.textStyle,
      this.lineDist})
      : super(key: key);
  final String text;
  final Color color;
  final Function onTap;
  final TextStyle textStyle;
  final double lineDist;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: GestureDetector(
              child: Text(
                text,
                style: textStyle ??
                    TextStyle(
                      fontFamily: kFontFamilyNormal,
                      fontSize: 28,
                      color: color ?? AppColors.caramel,
                    ),
              ),
              onTap: onTap),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: lineDist ?? 8.0),
          color: color ?? AppColors.caramel,
          height: 1.0,
          width: SizeConfig.safeBlockHorizontal * .5,
        ),
      ],
    );
  }
}
