import 'package:flutter/material.dart';

import '../style.dart';

class DrinkTile extends StatefulWidget {
  DrinkTile({Key key, this.title, this.description}) : super(key: key);

  final String title;
  final String description;

  @override
  _DrinkTileState createState() => _DrinkTileState();
}

class _DrinkTileState extends State<DrinkTile> with TickerProviderStateMixin {
  bool _expanded = false;

  bool _itemOne = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      vsync: this,
      curve: Curves.easeInOutQuad,
      duration: Duration(milliseconds: 250),
      child: Container(
        color: Color.fromRGBO(124, 63, 0, .1),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        top: 8,
                        left: 6,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(widget.title,
                                  style: TextStyles.kDefaultDarkTextStyle)),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(widget.description,
                                  style:
                                      TextStyles.kDefaultSmallTextCaramelStyle))
                        ],
                      ),
                    ),
                    Spacer(
                      flex: 10,
                    ),
                    Container(
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          _expanded ? Icons.expand_less : Icons.expand_more,
                        )),
                  ],
                ),
              ),
            ),
            _lowerWidget(),
          ],
        ),
      ),
    );
  }

  Widget _lowerWidget() {
    if (_expanded) {
      return Container(
        decoration: new BoxDecoration(
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
      );
    } else {
      return Container();
    }
  }
}
