import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

InputDecoration bgInputDecoration({
  required BuildContext context,
  
  String? hintText,
  String? labelText,
  String? errorText,
  Color? focusColor,
  Color? disabledColor,
  Color? hoverColor,
  Color? fillColor,
  Color? defocusColor,
  Widget? prefixIcon,
  Widget? suffixIcon,
  InputBorder? border,
  TextStyle? labelStyle,
  double borderRadius = 10,
  EdgeInsetsGeometry? contentPadding,
}) {
  return InputDecoration(
    hintText: hintText,
    labelText: labelText,
    errorText: errorText,

    fillColor: fillColor ?? Theme.of(context).primaryColor,
    focusColor: focusColor ?? Theme.of(context).focusColor,
    hoverColor: hoverColor ?? Theme.of(context).primaryColor,
    labelStyle: labelStyle ?? GoogleFonts.roboto(color: Colors.grey),
    contentPadding: contentPadding ?? const EdgeInsets.only(left: 15.0),
    
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,

    enabledBorder: border ?? OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: (focusColor ?? Theme.of(context).primaryColor)),
    ),

    disabledBorder: border ?? OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: (disabledColor ?? Theme.of(context).disabledColor)),
    ),

    border: border ?? OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: (defocusColor ?? Theme.of(context).primaryColor)),
    ),
  );
}