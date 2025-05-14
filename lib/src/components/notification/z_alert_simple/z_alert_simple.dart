import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),

      backgroundColor: Colors.white,
      actionsPadding: const EdgeInsets.all(2.5),

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
            style: styleAction ?? GoogleFonts.roboto(
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