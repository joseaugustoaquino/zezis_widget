import 'package:flutter/material.dart';

class ZCheckBoxInfo extends StatelessWidget {
  final bool value;
  final String label;
  final Function()? onTap;
  final Function(bool?)? onChanged;

  final Color? color;
  final Color? checkColor;
  final Color? activeColor;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;

  final IconData? icon;
  final double? iconSized;
  final Color? iconColor;
  final Function()? iconOnTap;

  const ZCheckBoxInfo({
    super.key,

    this.value = false,
    this.label = "",
    this.onTap,
    this.onChanged,

    this.color,
    this.checkColor,
    this.activeColor,

    this.padding,
    this.contentPadding,

    this.icon,
    this.iconSized,
    this.iconColor,
    this.iconOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
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
                        style: const TextStyle(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            InkWell(
              onTap: iconOnTap,
              child: Icon(
                icon,
                size: iconSized,
                color: color,
              ),
            )
          ],
        ),
      ),
    );
  }
}