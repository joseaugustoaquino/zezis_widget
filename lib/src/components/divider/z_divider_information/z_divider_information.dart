import 'package:flutter/material.dart';

class ZDividerInformation extends StatelessWidget {
  final double space;
  final String title;
  final IconData? icon;
  final double? fontSize;
  final double? thickness;
  final TextStyle? style;
  final Color? colorTitle;
  final Color? colorIcon;
  final Color? colorDivider;
  final EdgeInsetsGeometry? padding;
  final Function()? onTap;
  final double? iconSized;

  const ZDividerInformation({
    super.key,

    required this.title,
    this.space =  5,
    this.icon,
    this.fontSize,
    this.thickness = 2,
    this.style,
    this.colorTitle,
    this.colorIcon,
    this.colorDivider,
    this.padding,
    this.onTap,
    this.iconSized,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: style ?? TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: colorTitle ?? Theme.of(context).primaryColor,
            ),
          ),

          SizedBox(width: space),

          Expanded(
            child: Divider(
              thickness: thickness,
              color: colorDivider ?? Theme.of(context).dividerColor,
            ),
          ),

          SizedBox(width: space),
          
          if (icon != null) InkWell(
            onTap: onTap,
            child: Icon(
              icon,
              color: colorIcon ?? Theme.of(context).primaryColor,
              size: iconSized,
            ),
          ),
        ],
      ),
    );
  }
}