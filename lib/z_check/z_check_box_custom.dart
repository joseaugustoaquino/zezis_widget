import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ZCheckBoxCustom extends StatelessWidget {
  final bool value;
  final String label;
  final Function()? onTap;
  final Function(bool?)? onChanged;

  final Color? color;
  final Color? checkColor;
  final Color? activeColor;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  
  const ZCheckBoxCustom({
    Key? key,

    this.value = false,
    this.label = "",
    this.onTap,
    this.onChanged,

    this.color,
    this.checkColor,
    this.activeColor,

    this.padding,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),

                checkColor: checkColor,
                activeColor: activeColor,
              ),
            ),

            InkWell(
              onTap: onTap,
              child: Container(
                padding: contentPadding ?? const EdgeInsets.only(left: 16),
                child: Text(
                  label,
                  style: GoogleFonts.roboto(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}