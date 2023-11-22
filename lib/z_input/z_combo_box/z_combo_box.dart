import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ZComboBox<T> extends StatelessWidget {
  final T? value;
  final ValueChanged<T?>? onChanged;
  final List<DropdownMenuItem<T>>? items;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  final String? labelText;
  final String? hintText;
  final InputBorder? border;
  final Color? borderColor;
  final Widget? prefixIcon;
  final Color? color;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final Color? dropdownColor;
  final String? errorText;
  final bool enabled;
  final Color? focusColor;
  final String? Function(String?)? validator;
  final bool visible;

  const ZComboBox({ 
    super.key, 
    this.value, 
    this.border, 
    this.onChanged, 
    this.items, 
    this.borderColor, 
    this.width, 
    this.padding, 
    this.contentPadding, 
    this.labelText, 
    this.hintText,
    this.prefixIcon,
    this.labelStyle,
    this.style,
    this.color,
    this.dropdownColor,
    this.focusColor,
    this.visible = true,

    this.errorText,
    this.enabled = true,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,

      child: Padding(
        padding: (padding ?? const EdgeInsets.fromLTRB(8.5, 5.0, 8.5, 5.0)),

        child: FormField<String>(
         validator: validator,
         builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                enabledBorder: border ?? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: borderColor ?? Theme.of(context).primaryColor
                  ),
                ),

                border: border ?? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: borderColor ?? Get.theme.primaryColor
                  ),
                ),
        
                contentPadding: contentPadding ?? const EdgeInsets.only(left: 15.0, right: 10),
                enabled: enabled,
        
                errorText: state.hasError ? state.errorText : null,
                hintText: hintText,
                labelText: labelText,
                prefixIcon: prefixIcon,
                hoverColor: Colors.transparent,
                labelStyle: labelStyle ?? GoogleFonts.roboto(color: Colors.grey),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  icon: Icon(Icons.arrow_drop_down, color: color ?? Get.theme.primaryColor),
                  focusColor: Colors.transparent,
                  isExpanded: true,
                  isDense: true,
                  style: style ?? GoogleFonts.roboto(),
                  dropdownColor: dropdownColor,
                  onChanged: onChanged,
                  value: value,
                  items: items,
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}

BoxDecoration zBoxDecoration({Color? color}) => BoxDecoration(
  color: color,
  borderRadius: const BorderRadius.all(Radius.circular(10)),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.4),
      spreadRadius: 5,
      blurRadius: 7,
      offset: const Offset(0, 3), // changes position of shadow
    ),
  ],
);