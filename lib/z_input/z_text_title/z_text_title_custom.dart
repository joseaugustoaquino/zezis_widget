import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ZTextTileCustom extends StatelessWidget {
  final String title; 
  final String label; 
  final IconData icon;
  final String labelAlert;
  final Color? color;
  final Color? iconColor;
  final EdgeInsetsGeometry? padding;

  const ZTextTileCustom({
    super.key,
    required this.title,
    required this.label,
    required this.icon,
    this.labelAlert = "",
    this.color,
    this.iconColor,
    this.padding,
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
                Icon(icon, color: iconColor),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w800
                        ),
                      ),
                      Text(
                        label,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
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
            onTap: () async {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text(
                      labelAlert,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.roboto()
                    ),
                    actions: [
                      TextButton (
                        child: Text(
                          "Ok",
                          style: GoogleFonts.roboto(
                            color: iconColor,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(Icons.info_rounded, color: iconColor),
          ),
        ],
      ),
    );
  }
}