import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../style.dart';

class CortadoInputField extends StatefulWidget {
  final String hint;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final bool isPassword;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final bool autofocus;
  final FocusNode focusNode;
  final TextEditingController controller;
  final Widget prefix;
  final Widget suffix;
  final TextAlign textAlign;
  final List<TextInputFormatter> inputFormatters;
  final bool enabled;
  final TextCapitalization textCapitalization;
  final Color color;
  final TextStyle style;
  final TextStyle hintStyle;
  final double horizontalPadding;
  CortadoInputField(
      {Key key,
      this.hint,
      this.onChanged,
      this.onSubmitted,
      this.onSaved,
      this.validator,
      @required this.isPassword,
      this.textInputAction,
      this.textInputType,
      @required this.autofocus,
      this.focusNode,
      this.controller,
      this.prefix,
      this.suffix,
      @required this.textAlign,
      this.inputFormatters,
      @required this.enabled,
      @required this.textCapitalization,
      this.color,
      this.hintStyle,
      this.style,
      this.horizontalPadding})
      : super(key: key);

  @override
  _CortadoInputFieldState createState() => _CortadoInputFieldState();
}

class _CortadoInputFieldState extends State<CortadoInputField> {
  bool obscure = false;

  @override
  void initState() {
    super.initState();
    obscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.horizontalPadding ?? 40,
        vertical: 10,
      ),
      child: Stack(
        children: <Widget>[
          TextFormField(
            cursorColor: widget.color ?? Colors.brown,
            enabled: widget.enabled,
            validator: widget.validator,
            onSaved: widget.onSaved,
            inputFormatters: widget.inputFormatters,
            textAlign: widget.textAlign,
            controller: widget.controller,
            onFieldSubmitted: widget.onSubmitted,
            focusNode: widget.focusNode,
            autofocus: widget.autofocus,
            textCapitalization: widget.textCapitalization,
            keyboardType: widget.textInputType,
            textInputAction: widget.textInputAction,
            style: widget.style ?? TextStyles.kDefaultTextStyle,
            obscureText: obscure ?? false,
            onChanged: widget.onChanged,
            enableInteractiveSelection: true,
            readOnly: false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                  left: 8.0,
                  bottom: SizeConfig.iHeight == IphoneHeight.i667 ? -4 : -10),
              suffix: widget.suffix,
              prefixIcon: widget.prefix,
              hintText: widget.hint,
              hintStyle: widget.hintStyle ?? TextStyles.kHintTextStyle,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: widget.color ?? AppColors.dark,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: widget.color ?? AppColors.dark,
                ),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: widget.color ?? AppColors.dark,
                ),
              ),
            ),
          ),
          widget.isPassword
              ? Positioned(
                  right: 8,
                  top: 20,
                  child: GestureDetector(
                      child: Icon(Icons.remove_red_eye),
                      onTap: _toggleObscurity))
              : SizedBox.shrink()
        ],
      ),
    );
  }

  _toggleObscurity() {
    setState(() {
      obscure = false;
    });
    return Timer(Duration(seconds: 3), () {
      setState(() {
        obscure = true;
      });
    });
  }
}
