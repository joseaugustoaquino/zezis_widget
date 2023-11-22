import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ZTextTileSimple extends StatelessWidget {
  final String title; 
  final double? startHeight;
  final double? endHeight;
  final Color? color;

  const ZTextTileSimple({
    super.key,
    this.title = "Título",
    this.startHeight = 20,
    this.endHeight = 20,
    this.color,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: startHeight),

        Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: color
          )
        ),

        SizedBox(height: endHeight),
      ],
    );
  }
}