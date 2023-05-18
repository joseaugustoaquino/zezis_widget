library zezis_widget;

import 'package:flutter/material.dart';

class ZDividerInformation extends StatelessWidget {
  final String title;
  final IconData? icon;
  final double? fontSize;
  final TextStyle? style;
  final Color? colorTitle;
  final Color? colorIcon;
  final EdgeInsetsGeometry? padding;
  final Function()? onTap;

  const ZDividerInformation({
    super.key,

    required this.title,
    this.icon,
    this.fontSize,
    this.style,
    this.colorTitle,
    this.colorIcon,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: style ?? TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: colorTitle,
            ),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Expanded(
              child: Divider(
                thickness: 2,
              ),
            ),
          ),
          
          if (icon != null) InkWell(
            onTap: onTap,
            child: Icon(
              icon,
              color: colorIcon,
            ),
          ),
        ],
      ),
    );
  }
}