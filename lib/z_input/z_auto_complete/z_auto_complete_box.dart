import 'package:flutter/material.dart';

Widget selectAutoComplete({
  required void Function()? onPressed,
  required bool enable,

  required String title,
  String? subtitle,
  Widget? leading,

  EdgeInsetsGeometry? padding,
  Color color = const Color(0xFF000000),
}) {
  return Padding(
    padding: padding ?? const EdgeInsets.fromLTRB(0, 5, 0, 5), 
    child: Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: enable ? color : Colors.black12),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: ListTile(
        dense: true,
        leading: leading,
        visualDensity: VisualDensity.comfortable,

        title: Expanded(
          child: Text(
            title.toUpperCase(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              fontWeight: subtitle == null ? FontWeight.normal : FontWeight.w700
            ),
          ),
        ),

        subtitle: subtitle == null ? null : Expanded(
          child: Text(
            subtitle.toUpperCase(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),

        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, size: 22),
          color: enable ? color : Colors.black12,
          onPressed: onPressed,
        ),
      ),
    ),
  );
}