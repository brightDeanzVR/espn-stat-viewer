import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final Widget? label;
  final bool hideText;

  final TextStyle? textStyle;

  final InputBorder border;
  final InputBorder focusedBorder;
  final InputBorder enabledBorder;
  final Color? fillColor;

  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onFieldSubmitted;

  final void Function()? onTap;

  final TextInputType keyboardType;

  final double? contentPadding;
  final double _contentPadding = 15.0;

  final int? minLines;
  final int? maxLines;

  final Widget? prefixIcon;
  final TextEditingController? controller;

  const InputField(
      {Key? key,
      this.label,
      this.hideText = false,
      this.textStyle,
      this.border =
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      this.focusedBorder =
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      this.enabledBorder =
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      this.fillColor = Colors.white,
      this.validator,
      this.onSaved,
      this.onFieldSubmitted,
      this.onTap,
      this.keyboardType = TextInputType.text,
      this.contentPadding = 15.0,
      this.minLines = 1,
      this.maxLines = 1,
      this.prefixIcon,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: IgnorePointer(
        ignoring: false,
        child: TextFormField(
          style: textStyle,
          onTap: onTap,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: hideText,
          obscuringCharacter: '*',
          textAlign: TextAlign.center,
          validator: validator,
          onSaved: onSaved,
          onFieldSubmitted: onFieldSubmitted,
          minLines: minLines,
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            filled: true,
            fillColor: fillColor,
            border: border,
            contentPadding: contentPadding == null
                ? EdgeInsets.all(_contentPadding)
                : EdgeInsets.all(contentPadding!),
            focusedBorder: focusedBorder,
            enabledBorder: enabledBorder,
            label: label,
          ),
        ),
      ),
    );
  }
}
