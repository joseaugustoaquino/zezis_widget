import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zezis_widget/z_input/z_text_form/z_text_form.dart';
import 'package:zezis_widget/z_input/z_formatter/z_input_formatter.dart';

class ZMaskedFormatter extends ZTextForm {
  ZMaskedFormatter({
    Key? key,
    String? initialValue,
    String? mask,
    Map<String, RegExp>? maskFilter,
    TextAlign textAlign = TextAlign.start,
    bool autocorrect = true,
    Iterable<String>? autofillHints = const [],
    bool autofocus = false,
    InputCounterWidgetBuilder? buildCounter,
    TextEditingController? controller,
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
    TextInputType? keyboardType,
    int? maxLength,
    MaxLengthEnforcement? maxLengthEnforcement,
    int? maxLines,
    int? minLines,
    MouseCursor? mouseCursor,
    bool obscureText = false,
    String obscuringCharacter = "*",
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    GestureTapCallback? onTap,
    bool readOnly = false,
    String? restorationId,
    ScrollController? scrollController,
    EdgeInsets scrollPadding = const EdgeInsets.all(20),
    ScrollPhysics? scrollPhysics,
    TextSelectionControls? selectionControls,
    bool? showCursor,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    StrutStyle? strutStyle,
    TextStyle? style,
    TextAlignVertical? textAlignVertical,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextDirection? textDirection,
    TextInputAction? textInputAction,
    AutovalidateMode? autovalidateMode,
    ValueChanged<String>? onFieldSubmitted,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
  }) : super(
            key: key,
            textAlign: textAlign,
            // autocorrect: autocorrect,
            autofillHints: autofillHints,
            autofocus: autofocus,
            // buildCounter: buildCounter,
            controller: controller,
            // cursorColor: cursorColor,
            // cursorHeight: cursorHeight,
            // cursorRadius: cursorRadius,
            // cursorWidth: cursorWidth,
            // decoration: decoration,
            // enabled: enabled,
            // enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
            // enableInteractiveSelection: enableInteractiveSelection,
            // enableSuggestions: enableSuggestions,
            // expands: expands,
            // focusNode: focusNode,
            inputFormatters: [
              ...?inputFormatters,
              ZInputFormatter(
                mask: mask,
                filter: maskFilter
              )
            ],
            // keyboardAppearance: keyboardAppearance,
            keyboardType: keyboardType,
            // maxLength: maxLength,
            // maxLengthEnforcement: maxLengthEnforcement,
            maxLines: maxLines,
            // minLines: minLines,
            // mouseCursor: mouseCursor,
            obscureText: obscureText,
            // obscuringCharacter: obscuringCharacter,
            // onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            // onTap: onTap,
            readOnly: readOnly,
            // restorationId: restorationId,
            // scrollController: scrollController,
            scrollPadding: scrollPadding,
            // scrollPhysics: scrollPhysics,
            // selectionControls: selectionControls,
            // showCursor: showCursor,
            // smartDashesType: smartDashesType,
            // smartQuotesType: smartQuotesType,
            // strutStyle: strutStyle,
            style: style,
            textAlignVertical: textAlignVertical,
            textCapitalization: textCapitalization,
            textDirection: textDirection,
            textInputAction: textInputAction,
            autovalidateMode: autovalidateMode,
            initialValue: initialValue,
            onFieldSubmitted: onFieldSubmitted,
            onSaved: onSaved,
            // validator: validator
  );
}
