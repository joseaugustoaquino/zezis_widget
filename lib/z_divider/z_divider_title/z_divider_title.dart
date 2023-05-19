import 'package:flutter/material.dart';

class ZDividerTitle extends StatelessWidget {
  final String title;
  final double? fontSize;
  final double? thickness;
  final TextStyle? style;
  final Color? colorTitle;
  final Color? colorDivider;
  final EdgeInsetsGeometry? padding;

  const ZDividerTitle({
    super.key,

    required this.title,
    this.fontSize,
    this.thickness = 2,
    this.style,
    this.colorTitle,
    this.colorDivider,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: padding ?? const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Divider(
                thickness: thickness,
                color: colorDivider,
              ),
            ),
          ),

          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: style ?? TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: colorTitle,
            ),
          ),
    
          Expanded(
            child: Padding(
              padding: padding ?? const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Divider(
                thickness: thickness,
                color: colorDivider,
              ),
            ),
          ),
        ],
      ),
    );
  } 
}