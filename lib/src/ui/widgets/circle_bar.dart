import 'package:flutter/material.dart';

class CircleBar extends StatefulWidget {
  final bool isActive;
  final double activeSize;
  final double inactiveSize;
  CircleBar({Key key, this.isActive, this.activeSize, this.inactiveSize})
      : super(key: key);

  @override
  _CircleBarState createState() => _CircleBarState();
}

class _CircleBarState extends State<CircleBar> {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: -6.3,
        child: Container(
            child: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          margin: EdgeInsets.symmetric(horizontal: 6),
          height: widget.isActive
              ? widget.activeSize ?? 12
              : widget.inactiveSize ?? 8,
          width: widget.isActive
              ? widget.activeSize ?? 12
              : widget.inactiveSize ?? 8,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image:
                      AssetImage("assets/images/icons/white_coffee_bean.png"))),
        )));
  }
}
