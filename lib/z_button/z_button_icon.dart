import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ZButtonIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  final GestureTapCallback onTap;

  final double space;
  final double border;
  final double? height;
  final double? width;
  final double? fontSized;
  final double? iconSized;
  
  final bool disableText;
  final TextStyle? style;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  final Color? color;
  final Color? colorLabel;

  const ZButtonIcon({ 
    super.key, 
    required this.label, 
    required this.icon, 
    required this.onTap,

    this.space = 5.0,
    this.border = 15.0,
    this.height,
    this.width,
    this.fontSized,
    this.iconSized,
    
    this.disableText = false,
    this.style,
    this.margin,
    this.padding,
        
    this.color,
    this.colorLabel = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(8.0),

      child: Material(
        elevation: 3.0,
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(border)),

        child: InkWell(
          onTap: onTap,
          focusColor: Theme.of(context).focusColor,
          hoverColor: Theme.of(context).hoverColor,
          splashColor: Theme.of(context).splashColor,
          highlightColor: Theme.of(context).highlightColor,

          child: Ink(
            width: width,
            height: height ?? 50,
            decoration: BoxDecoration(
              color: color ?? Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(border)),
            ),
            
            child: Padding(
              padding: margin ?? const EdgeInsets.all(5.0),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: colorLabel,
                    size: iconSized,
                  ),
              
                  disableText ? const SizedBox() : SizedBox(width: space),
                  
                  disableText ? const SizedBox() : Expanded(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    
                      style: style ?? GoogleFonts.roboto(
                        fontSize: fontSized ?? 16, 
                        color: colorLabel, 
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}