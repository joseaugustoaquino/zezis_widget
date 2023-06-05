import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ZCheckCustom extends StatelessWidget {
  final bool value;
  final Color? color;
  final String label;
  final Function()? onTap;
  final Function(bool)? onChanged;
  final EdgeInsetsGeometry? padding;
  
  const ZCheckCustom({
    Key? key,
    this.value = false,
    this.color,
    this.label = "",
    this.onTap,
    this.onChanged,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: color ?? Colors.black
                )
              ),
            ),
      
            Switch(
              value: value,
              activeColor: const Color.fromARGB(255, 119, 225, 105).withOpacity(0.6),
              inactiveThumbColor: const Color.fromARGB(255, 225, 105, 105).withOpacity(0.6),
              onChanged: onChanged,

              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}