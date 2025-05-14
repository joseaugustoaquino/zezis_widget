import 'package:flutter/material.dart';
import 'package:zezis_widget/src/components/input/z_text_form/z_text_form_field.dart';

class ZDatePicker extends StatelessWidget {
  final String label;
  final String? labelDate;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final Function()? onPressed;
  final WidgetStateProperty<Color?>? backgroundColor;
  final BorderSide? side;
  final Color? borderColor;
  final bool disabled;
  final Color? iconColor;
  final bool prefixIcon;

  const ZDatePicker({
    super.key,
    this.label = "Selecione uma Data",
    this.labelDate,
    this.side,
    this.borderColor,
    this.textStyle,
    this.padding,
    this.onPressed,
    this.backgroundColor,
    this.disabled = false,
    this.iconColor,
    this.prefixIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return ZTextFormField(
      readOnly: true,
      labelText: label,
      contentPadding: const EdgeInsets.all(18),
      controller: TextEditingController(text: labelDate),
      padding: padding ?? const EdgeInsets.fromLTRB(8.5, 5, 8.5, 5),
      
      prefixIcon: prefixIcon ? null : IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.date_range_rounded,
          size: 24.0,
          color: iconColor ?? Theme.of(context).primaryColor,
        ),
      ),

      suffixIcon: IconButton(
        onPressed: onPressed,
        icon: Icon(
          prefixIcon ? Icons.date_range_rounded : Icons.search_rounded,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}