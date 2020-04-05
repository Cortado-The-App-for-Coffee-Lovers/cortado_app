import 'package:cortado_app/src/ui/widgets/cortado_input_field.dart';
import 'package:flutter/material.dart';

import '../style.dart';

class CortadoSearchBar extends StatefulWidget {
  CortadoSearchBar({
    Key key,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);
  final Function(String) onChanged;
  final Function(String) onSubmitted;

  @override
  _CortadoSearchBarState createState() => _CortadoSearchBarState();
}

class _CortadoSearchBarState extends State<CortadoSearchBar> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: AppColors.dark,
      height: SizeConfig.screenHeight * .1,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.screenHeight * .01),
            child: CortadoInputField(
              style: TextStyles.kDefaultLightTextStyle,
              hint: "Search...",
              hintStyle: TextStyles.kDefaultCreamTextStyle,
              color: AppColors.cream,
              isPassword: false,
              autofocus: false,
              textAlign: TextAlign.start,
              enabled: true,
              textCapitalization: TextCapitalization.sentences,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
            ),
          ),
          Positioned(
            right: 34,
            top: SizeConfig.screenHeight * .03,
            child: IconButton(
                icon: Image.asset(
                  "assets/images/icons/my_location.png",
                  color: AppColors.cream,
                ),
                onPressed: () => {}),
          )
        ],
      ),
    );
  }
}
