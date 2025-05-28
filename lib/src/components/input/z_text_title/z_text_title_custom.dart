import 'package:flutter/material.dart';
import 'package:zezis_widget/src/components/notification/notification.dart';

class ZTextTileCustom extends StatelessWidget {
  final String title; 
  final String label; 
  final IconData icon;
  final String labelAlert;
  final Color? color;
  final Color? iconColor;
  final EdgeInsetsGeometry? padding;
  final double? iconSized;

  const ZTextTileCustom({
    super.key,
    required this.title,
    required this.label,
    required this.icon,
    this.labelAlert = "",
    this.color,
    this.iconColor,
    this.padding,
    this.iconSized,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.fromLTRB(2.5, 10, 5, 2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(
                  icon, 
                  color: iconColor  ?? Theme.of(context).primaryColor
                ),

                const SizedBox(width: 10),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800
                        ),
                      ),
                      Text(
                        label,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          labelAlert.isEmpty ? const SizedBox() : const SizedBox(width: 5),

          labelAlert.isEmpty ? const SizedBox() : InkWell(
            onTap: () => zSnackBarCustom(
              context: context, 
              message: labelAlert,
            ),
            
            child: Icon(
              Icons.info_rounded, 
              color: iconColor ?? Theme.of(context).primaryColor,
              size: iconSized,
            ),
          ),
        ],
      ),
    );
  }
}