import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      @required this.textCapitalization})
      : super(key: key);

  @override
  _CortadoInputFieldState createState() => _CortadoInputFieldState();
}

class _CortadoInputFieldState extends State<CortadoInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 18,
      ),
      child: TextFormField(
        cursorColor: Colors.brown,
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
        style: TextStyle(
            fontFamily: 'GibsonSemi', letterSpacing: 1.2, color: Colors.brown),
        obscureText: widget.isPassword,
        onChanged: widget.onChanged,
        enableInteractiveSelection: true,
        readOnly: false,
        decoration: InputDecoration(
          suffix: widget.suffix,
          prefixIcon: widget.prefix,
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: Colors.brown,
            fontFamily: 'GibsonSemi',
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.brown,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.brown,
            ),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.brown,
            ),
          ),
        ),
      ),
    );
  }


}
