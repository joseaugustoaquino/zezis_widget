import 'package:flutter/material.dart';

InputDecoration bgInputDecoration({
  required BuildContext context,
  Widget? suffixIcon,
  Widget? prefixIcon,
  double borderRadius = 10,
  String? hintText,
  String? labelText,
  Color? focusColor,
  Color? hoverColor,
  Color? fillColor,
  Color? defocusColor,
  Color? disabledColor,
}) {
  return InputDecoration(
    hintText: hintText,
    labelText: labelText,
    contentPadding: const EdgeInsets.only(left: 15.0),
    fillColor: (fillColor ?? Theme.of(context).primaryColor),
    focusColor: (focusColor ?? Theme.of(context).focusColor),
    hoverColor: (hoverColor ?? Theme.of(context).primaryColor),

    // prefixIcon: prefixIcon,
    // suffixIcon: suffixIcon,

    disabledBorder: disabledColor == null ? null : OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: disabledColor),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: (focusColor ?? Theme.of(context).primaryColor)),
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: (defocusColor ?? Theme.of(context).primaryColor)),
    ),
  );
}