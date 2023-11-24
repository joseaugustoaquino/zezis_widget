import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ZButton extends StatefulWidget {
  final String label;
  final GestureTapCallback onTap;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double border;

  const ZButton({ 
    super.key, 
    required this.label, 
    required this.onTap,
    this.height,
    this.width,
    this.padding,
    this.color,
    this.border = 15.0,
  });

  @override
  State<ZButton> createState() => _ZButtonState();
}

class _ZButtonState extends State<ZButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(8.0),
      child: Material(
        elevation: 3.0,
        borderRadius: BorderRadius.all(Radius.circular(widget.border)),
        child: InkWell(
          onTap: widget.onTap,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              color: widget.color ?? Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(widget.border)),
            ),
            height: widget.height ?? 50,
            width: widget.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      widget.label,
                      style: GoogleFonts.roboto(
                        fontSize: 16, 
                        color: Colors.white, 
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}