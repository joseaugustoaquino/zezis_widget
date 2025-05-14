import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ZDividerTitle extends StatelessWidget {
  final double space;
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
    this.thickness = 2.0,
    this.space = 5.0,
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        
        children: [
          Expanded(
            child: Divider(
              thickness: thickness,
              color: colorDivider ?? Theme.of(context).dividerColor,
            ),
          ),

          SizedBox(width: space),

          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: style ?? GoogleFonts.roboto(
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
        ],
      ),
    );
  } 
}