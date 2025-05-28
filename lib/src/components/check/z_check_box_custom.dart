import 'package:flutter/material.dart';

class ZCheckBoxCustom extends StatelessWidget {
  final bool value;
  final String label;
  final double? space;
  final double border;
  final Widget? content;
  final Function()? onTap;
  final Function(bool?)? onChanged;

  final Color? color;
  final Color? checkColor;
  final Color? activeColor;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  
  const ZCheckBoxCustom({
    super.key,

    this.space,
    this.border = 5,
    this.value = false,
    this.label = "",
    this.content,
    this.onTap,
    this.onChanged,

    this.color,
    this.checkColor,
    this.activeColor,

    this.padding,
    this.contentPadding,
  });

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
                checkColor: checkColor,
                activeColor: activeColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(border)),
              ),
            ),
      
            SizedBox(width: space),
      
            content ?? Expanded(
              child: Text(
                label,
                
                textAlign: TextAlign.left,
                overflow: TextOverflow.clip,

                style: TextStyle(
                  fontWeight: value ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}