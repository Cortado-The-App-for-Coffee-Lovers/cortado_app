import 'package:flutter/material.dart';

import '../style.dart';

class ExpandingDrinkTile extends StatefulWidget {
  ExpandingDrinkTile({Key key, this.title, this.description}) : super(key: key);

  final String title;
  final String description;

  @override
  _ExpandingDrinkTileState createState() => _ExpandingDrinkTileState();
}

class _ExpandingDrinkTileState extends State<ExpandingDrinkTile> {
  bool _itemOne = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(124, 63, 0, .1),
      child: ExpansionTile(
        backgroundColor: Color.fromRGBO(124, 63, 0, .1),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(102),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              children: [
                ListTile(
                    title: Text(
                      "Drink Name #1",
                      style: TextStyles.kDefaultSmallTextDarkStyle,
                    ),
                    leading: Theme(
                      data: ThemeData(unselectedWidgetColor: AppColors.dark),
                      child: Checkbox(
                        checkColor: AppColors.caramel,
                        activeColor: AppColors.caramel,
                        value: _itemOne,
                        onChanged: (bool newValue) {
                          setState(() {
                            _itemOne = newValue;
                          });
                        },
                      ),
                    ))
              ],
            ),
          )
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
                alignment: Alignment.topLeft,
                child: Text(widget.title,
                    style: TextStyles.kDefaultDarkTextStyle)),
            Align(
                alignment: Alignment.topLeft,
                child: Text(widget.description,
                    style: TextStyles.kDefaultSmallTextCaramelStyle))
          ],
        ),
      ),
    );
  }
}
