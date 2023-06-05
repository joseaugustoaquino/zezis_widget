import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ZDividerInformation extends StatelessWidget {
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

  const ZDividerInformation({
    super.key,

    required this.title,
    this.icon,
    this.fontSize,
    this.thickness = 2,
    this.style,
    this.colorTitle,
    this.colorIcon,
    this.colorDivider,
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
            style: style ?? GoogleFonts.roboto(
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