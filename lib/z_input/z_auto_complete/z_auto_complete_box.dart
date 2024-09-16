import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget selectAutoComplete({
  required void Function()? onPressed,
  required bool enable,

  required String title,
  String? subtitle,
  Widget? leading,

  EdgeInsetsGeometry? padding,
  Color? color,
  BuildContext? context,
}) {
  color = color ?? (context == null ? Get.theme.primaryColor : Theme.of(context).primaryColor);

  return Padding(
    padding: padding ?? const EdgeInsets.fromLTRB(0, 5, 0, 5), 

    child: Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: enable ? color : Get.theme.primaryColor),
      ),

      child: ListTile(
        dense: true,
        leading: leading,
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