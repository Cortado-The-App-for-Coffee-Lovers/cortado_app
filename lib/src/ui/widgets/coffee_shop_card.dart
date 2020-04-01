import 'package:flutter/material.dart';

import '../style.dart';

class CoffeeShopCard extends StatelessWidget {
  final String image;
  final double distance;
  final String shopName;

  const CoffeeShopCard({Key key, this.image, this.distance, this.shopName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.blockSizeVertical * .2,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: image != null
                        ? AssetImage(image)
                        : NetworkImage(
                            "https://firebasestorage.googleapis.com/v0/b/cortado-f9ae2.appspot.com/o/coffee_shop_pics%2Fcoffee-shop-default.jpg?alt=media&token=f6177afd-253a-441f-aea5-5bc3860699a7"))),
          ),
          Positioned(
            bottom: 0,
            child: Opacity(
              opacity: .8,
              child: Container(
                height: SizeConfig.blockSizeVertical * .08,
                width: SizeConfig.blockSizeVertical * 2,
                decoration: BoxDecoration(color: AppColors.dark),
              ),
            ),
          ),
          Positioned(
            bottom: SizeConfig.blockSizeVertical * .03,
            child: Opacity(
                opacity: .8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      shopName,
                      style: TextStyles.kCoffeeShopTitleTextStyle,
                    ),
                    Text(
                      distance.toString().substring(0, 3) + ' mi',
                      style: TextStyles.kCoffeeShopTitleTextStyle,
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
