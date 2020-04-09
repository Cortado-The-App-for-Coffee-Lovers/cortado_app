import 'package:flutter/material.dart';

import '../style.dart';

class BeanTile extends StatelessWidget {
  const BeanTile(this.content, {Key key}) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 16,
        width: 20,
        decoration: BoxDecoration(
            image: DecorationImage(
                image:
                    AssetImage("assets/images/icons/white_coffee_bean.png"))),
      ),
      title: Align(
        alignment: Alignment(-1.5, 0),
        child: Text(
          content,
          style: TextStyles.kDefaultLightTextStyle,
        ),
      ),
    );
  }
}
