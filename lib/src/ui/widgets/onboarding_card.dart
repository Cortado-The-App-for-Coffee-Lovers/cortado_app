import 'package:flutter/material.dart';

import '../style.dart';

class OnBoardingCard extends StatelessWidget {
  final Color backgroundColor;
  final Widget image;
  final String title;

  OnBoardingCard({
    @required this.backgroundColor,
    @required this.image,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 8,
              ),
              child: image,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: kFontFamilyNormal,
                fontSize: 34,
                color: AppColors.light,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
