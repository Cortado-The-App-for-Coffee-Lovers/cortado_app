import 'package:cortado_app/src/ui/widgets/cortado_input_field.dart';
import 'package:flutter/material.dart';

import '../style.dart';

class CortadoSearchBar extends StatefulWidget {
  CortadoSearchBar({Key key, this.list, this.filterList}) : super(key: key);
  final List list;
  final Function(String) filterList;

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
        onChanged: widget.filterList,
      ),
    );
  }
}
