import 'package:flutter/material.dart';

Future zSnackBarSimple({
  required BuildContext context,
  required String message,

  TextStyle? style,
  Color? backgroundColor,
  int duration = 600
}) async {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: style,
    ),

    duration: Duration(milliseconds: duration),
    backgroundColor: backgroundColor,
    action: SnackBarAction(
      label: "Ok", 
      onPressed: () {}
    ),
  );

  return ScaffoldMessenger.of(context)
                          .showSnackBar(snackBar);
}