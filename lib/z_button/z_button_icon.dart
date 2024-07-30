import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ZButtonIcon extends StatefulWidget {
  final String label;
  final IconData icon;
  final GestureTapCallback onTap;

  final double border;
  final double? height;
  final double? width;
  final double? fontSized;
  final double? iconSized;
  
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;

  final Color? color;
  final Color? colorLabel;

  const ZButtonIcon({ 
    super.key, 
    required this.label, 
    required this.icon, 
    required this.onTap,

    this.border = 15.0,
    this.height,
    this.width,
    this.fontSized,
    this.iconSized,
    
    this.style,
    this.padding,

    this.color,
    this.colorLabel = Colors.white,
  });

  @override
  State<ZButtonIcon> createState() => _ZButtonIconState();
}

class _ZButtonIconState extends State<ZButtonIcon> {
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  color: widget.colorLabel,
                  size: widget.iconSized,
                ),

                const SizedBox(width: 5),
                
                Text(
                  widget.label,
                  textAlign: TextAlign.center,
                  style: widget.style ?? GoogleFonts.roboto(
                    fontSize: widget.fontSized ?? 16, 
                    color: widget.colorLabel, 
                    fontWeight: FontWeight.w600,
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