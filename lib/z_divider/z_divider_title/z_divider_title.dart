import 'package:flutter/material.dart';

class ZDividerTitle extends StatelessWidget {
  final String title;
  final double? fontSize;
  final TextStyle? style;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const ZDividerTitle({
    super.key,

    required this.title,
    this.fontSize,
    this.style,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: margin ?? const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: const Divider(
                color: Colors.black,
                height: 50,
              ),
            ),
          ),
    
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: style ?? TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
    
          Expanded(
            child: Container(
              margin: margin ?? const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: const Divider(
                color: Colors.black,
                height: 50,
              ),
            ),
          ),
        ],
      ),
    );
  } 
}