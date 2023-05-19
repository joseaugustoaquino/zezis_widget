import 'package:flutter/material.dart';

Future<T?> zAlertSimple<T>({
  required BuildContext context,
  WidgetBuilder? builder,

  required String message,
  TextAlign? textAlign,
  TextStyle? style,

  List<Widget>? actions,
  String? textAction,
  TextStyle? styleAction,
  Color? colorAction,
}) => showDialog(
  context: context, 
  builder: builder ?? (BuildContext context) {
    return AlertDialog(
      content: Text(
        message,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign ?? TextAlign.justify,
        style: style,
      ),

      actions: actions ?? [
        TextButton(
          child: Text(
            textAction ?? "Ok",
            style: styleAction ?? TextStyle(
              color: colorAction ?? Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
);