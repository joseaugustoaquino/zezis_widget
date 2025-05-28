import 'package:flutter/material.dart';

class ZButton extends StatelessWidget {
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

          child: Container(
            width: width,
            height: height ?? 50,
            
            decoration: BoxDecoration(
              color: color ?? Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(border)),
            ),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      label,
                      style: const TextStyle(
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