import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zezis_widget/z_input/z_text_form/z_text_form.dart';
import 'package:zezis_widget/z_input/z_formatter/z_input_formatter.dart';

class ZMaskedFormatter extends ZTextForm {
  ZMaskedFormatter({
    super.key,
    super.initialValue,
    String? mask,
    Map<String, RegExp>? maskFilter,
    TextAlign super.textAlign = TextAlign.start,
    bool autocorrect = true,
    super.autofillHints = const [],
    super.autofocus = false,
    InputCounterWidgetBuilder? buildCounter,
    super.controller,
    Color? cursorColor,
    double? cursorHeight,
    Radius? cursorRadius,
    double cursorWidth = 2.0,
    InputDecoration? decoration,
    bool? enabled,
    bool enableIMEPersonalizedLearning = true,
    bool? enableInteractiveSelection,
    bool enableSuggestions = true,
    bool expands = false,
    FocusNode? focusNode,
    List<TextInputFormatter>? inputFormatters,
    Brightness? keyboardAppearance,
    super.keyboardType,
    int? maxLength,
    MaxLengthEnforcement? maxLengthEnforcement,
    super.maxLines = null,
    int? minLines,
    MouseCursor? mouseCursor,
    super.obscureText,
    String obscuringCharacter = "*",
    ValueChanged<String>? onChanged,
    VoidCallback? super.onEditingComplete,
    GestureTapCallback? onTap,
    bool super.readOnly = false,
    String? restorationId,
    ScrollController? scrollController,
    EdgeInsets super.scrollPadding = const EdgeInsets.all(20),
    ScrollPhysics? scrollPhysics,
    TextSelectionControls? selectionControls,
    bool? showCursor,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    StrutStyle? strutStyle,
    super.style,
    super.textAlignVertical,
    super.textCapitalization,
    super.textDirection,
    super.textInputAction,
    super.autovalidateMode,
    ValueChanged<String>? super.onFieldSubmitted,
    FormFieldSetter<String>? super.onSaved,
    FormFieldValidator<String>? validator,
  }) : super(
            inputFormatters: [
              ...?inputFormatters,
              ZInputFormatter(
                mask: mask,
                filter: maskFilter
              )
            ],
            // validator: validator
  );
}
