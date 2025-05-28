import 'package:flutter/material.dart';

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
  final bool clearButton;
  final Function()? onTapClean;

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
    this.clearButton = false,
    this.onTapClean,
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
                enabled: enabled,
                hintText: hintText,
                labelText: labelText,
                prefixIcon: prefixIcon,
                focusColor: Theme.of(context).focusColor,
                hoverColor: Theme.of(context).hoverColor,
                errorText: state.hasError ? state.errorText : null,
                labelStyle: labelStyle ?? const TextStyle(color: Colors.grey),
                contentPadding: contentPadding ?? const EdgeInsets.only(left: 15.0, right: 10),
                
                enabledBorder: border ?? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: borderColor ?? Theme.of(context).primaryColor),
                ),

                border: border ?? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: borderColor ?? Theme.of(context).primaryColor),
                ),
              ),

              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isDense: true,
                  isExpanded: true,
                  dropdownColor: dropdownColor,
                  style: style ?? const TextStyle(),
                  focusColor: Theme.of(context).focusColor,

                  value: value,
                  items: items,
                  onChanged: onChanged,

                  icon: SizedBox(
                    width: 30,
                    height: 30,
                    child: InkWell(
                      onTap: onTapClean,
                      child: Icon(
                        (clearButton && value != null) ? Icons.delete_outline : Icons.arrow_drop_down, 
                        color: color ?? Theme.of(context).primaryColor 
                      ),
                    ),
                  ),
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
      // ignore: deprecated_member_use
      color: Colors.grey.withOpacity(0.4),
      spreadRadius: 5,
      blurRadius: 7,
      offset: const Offset(0, 3), // changes position of shadow
    ),
  ],
);