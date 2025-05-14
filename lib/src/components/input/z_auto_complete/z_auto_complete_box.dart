import 'package:get/get.dart';
import 'package:flutter/material.dart';

Widget selectAutoComplete({
  required void Function()? onPressed,
  required BuildContext context,
  required String title,
  required bool enable,
  
  double border = 10.0,
  String? labelText,
  String? subtitle,
  Widget? leading,

  EdgeInsetsGeometry? padding,
  Color? color,
}) {
  color = color ?? Theme.of(context).primaryColor;

  return Padding(
    padding: padding ?? const EdgeInsets.fromLTRB(0, 5, 0, 5), 

    child: InputDecorator(
      decoration: InputDecoration(
        prefixIcon: leading,
        labelText: labelText,
        contentPadding: const EdgeInsets.only(left: 15.0),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w300,
        ),
        
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(border),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),

        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(border),
          borderSide: BorderSide(color: Theme.of(context).disabledColor),
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(border),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),

      child: ListTile(
        dense: true,
        visualDensity: VisualDensity.comfortable,

        title: Text(
          title.toUpperCase(),
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16,
            fontWeight: subtitle == null ? FontWeight.normal : FontWeight.w700
          ),
        ),

        subtitle: subtitle == null ? null : Text(
          subtitle.toUpperCase(),
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),

        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, size: 22),
          color: enable ? color : Get.theme.primaryColor,
          onPressed: onPressed,
        ),
      ),
    ),
  );
}