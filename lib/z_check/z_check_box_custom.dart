import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ZCheckBoxCustom extends StatelessWidget {
  final bool value;
  final Color? color;
  final String label;
  final Function()? onTap;
  final Function(bool?)? onChanged;
  final EdgeInsetsGeometry? padding;
  
  const ZCheckBoxCustom({
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
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                value: value,
                onChanged: onChanged,
              ),
            ),
            InkWell(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.only(left: 16),
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