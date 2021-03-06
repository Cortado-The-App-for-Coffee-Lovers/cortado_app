import 'package:flutter/material.dart';

import '../style.dart';

class AppBarWithImage extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  @required
  final Widget image;
  final Widget lower;
  final double imagePadding;

  const AppBarWithImage(
      {Key key,
      this.actions,
      this.lower,
      @required this.image,
      this.imagePadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SliverAppBar(
      expandedHeight: SizeConfig.iHeight == IphoneHeight.i667 ? 250 : 250,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              stops: [.87, .5],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [AppColors.light, AppColors.dark]),
        ),
        child: FlexibleSpaceBar(
          background: Container(child: image),
        ),
      ),
      floating: true,
      elevation: 0,
      actions: actions,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(SizeConfig.screenHeight * .2),
        child: Container(
          height: SizeConfig.iHeight == IphoneHeight.i667
              ? SizeConfig.screenHeight * .12
              : SizeConfig.screenHeight * .1,
          width: SizeConfig.screenWidth,
          child: this.lower,
        ),
      ),
      iconTheme: IconThemeData(color: AppColors.dark),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(lower == null ? kToolbarHeight * 2 : 156);
}
