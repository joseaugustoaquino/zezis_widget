import 'package:flutter/material.dart';

Future zSnackBarCustom({
  required BuildContext context,
  required String message,

  TextStyle? style,
  Color? backgroundColor,
  int duration = 3600,
  DismissDirection dismissDirection = DismissDirection.down
}) async {
  final snackBar = SnackBar(
    elevation: 5,
    margin: const EdgeInsets.all(20),
    behavior: SnackBarBehavior.floating,
    dismissDirection: dismissDirection,

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