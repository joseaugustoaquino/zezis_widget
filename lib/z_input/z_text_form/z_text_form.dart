import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ZTextForm extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final double borderRadius;
  final bool obscureText;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final Color? focusColor;
  final Color? disabledColor;
  final Color? hoverColor;
  final Color? fillColor;
  final Color? defocusColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? padding;
  final bool? enable;
  final ValueChanged<String>? onChange;
  final Function(String?)? onSaved;
  final String? initialValue;
  final bool visible;
  final bool clearButton;
  final bool clearButtonAlwaysShow;
  final int? maxLines;
  final bool? isLogin;
  final bool? readOnly;
  final TextCapitalization textCapitalization;
  final InputBorder? border;
  final EdgeInsetsGeometry? contentPadding;
  final Color? textStyle;
  final TextStyle? style;
  final bool autofocus;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final Function()? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final AutovalidateMode? autovalidateMode;
  final Iterable<String>? autofillHints;
  final EdgeInsets? scrollPadding;
  final TextAlignVertical? textAlignVertical;

  const ZTextForm({super.key,
    this.textDirection,
    this.textAlign,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.autovalidateMode,
    this.autofillHints,
    this.scrollPadding,
    this.textAlignVertical, 
    this.labelStyle,
    
    this.isLogin,
    this.controller,
    this.autofocus = true,
    this.textStyle,
    this.contentPadding,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.style,
    this.border,
    this.disabledColor,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.borderRadius = 10.0,
    this.obscureText = false,
    this.labelText,
    this.hintText,
    this.errorText,
    this.focusColor,
    this.hoverColor,
    this.fillColor,
    this.defocusColor,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.enable,
    this.onChange,
    this.onSaved,
    this.initialValue,
    this.visible = true,
    this.clearButton = false,
    this.maxLines = 1,
    this.clearButtonAlwaysShow = false, this.readOnly,
  });

  @override
  State<ZTextForm> createState() => _ZTextFormState();
}

class _ZTextFormState extends State<ZTextForm> {
  final _controller = TextEditingController();

  FocusNode _focusNode = FocusNode();
  late bool _passwordVisible;
  bool _focused = false;

  @override
  void initState() {
    _passwordVisible = widget.obscureText;

    if(widget.controller == null){
      if(widget.initialValue != null) {
        _controller.text = widget.initialValue!;
      } else { 
        _controller.text = "";
      }
    }

    super.initState();

    _focusNode = FocusNode(debugLabel: 'Button');
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus != _focused) {
      setState(() {
        _focused = _focusNode.hasFocus;
      });
    }
  }

  void clear(){
    setState(() {
      _controller.clear();
    });

    widget.onChange!(_controller.text);
  }

  Widget _getSuffix(){
    if(widget.suffixIcon is Icon){
      return Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Icon(
          (widget.suffixIcon as Icon).icon,
          color: Theme.of(context).primaryColor,
        ),
      );
    }

    if(widget.suffixIcon is IconButton){
      return Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: IconButton(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(
            ((widget.suffixIcon as IconButton).icon as Icon).icon,
            color: Theme.of(context).primaryColor,
          ),

          onPressed: (widget.suffixIcon as IconButton).onPressed,
        ),
      );
    }

    return const SizedBox(width: 0, height: 0);
  }

  @override
  Widget build(BuildContext context) {
    final List<TextInputFormatter> formatters = widget.inputFormatters ?? <TextInputFormatter>[];

    return Visibility(
      visible: widget.visible,

      child: Padding(
        padding: (widget.padding ?? const EdgeInsets.fromLTRB(8.5, 5.0, 8.5, 5.0)),

        child: TextFormField(
          maxLines: widget.maxLines,
          textCapitalization: widget.textCapitalization,
          autofocus: widget.autofocus,
          readOnly: widget.readOnly ?? false,
          controller: widget.controller ?? _controller,
          validator: widget.validator,
          obscureText: (widget.obscureText ? _passwordVisible : widget.obscureText),
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          inputFormatters: formatters,
          enabled: (widget.enable ?? true),
          onChanged: widget.onChange,
          onSaved: widget.onSaved,
          style: widget.style ?? GoogleFonts.roboto(color: widget.textStyle ?? Colors.black),
          textDirection: widget.textDirection,
          textAlign: widget.textAlign ?? TextAlign.start,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onFieldSubmitted,
          autovalidateMode: widget.autovalidateMode,
          autofillHints: widget.autofillHints,
          textAlignVertical: widget.textAlignVertical,
          scrollPadding: widget.scrollPadding ?? const EdgeInsets.all(20.0),

          decoration: InputDecoration(
            focusColor: (widget.focusColor ?? Theme.of(context).focusColor),
            hoverColor: (widget.hoverColor ?? Theme.of(context).primaryColor),
            fillColor: (widget.fillColor ?? Theme.of(context).primaryColor),
            contentPadding: widget.contentPadding ?? const EdgeInsets.only(left: 15.0),
            labelText: widget.labelText,
            labelStyle: widget.labelStyle ?? GoogleFonts.roboto(color: Colors.grey),
            hintText: widget.hintText,
            errorText: widget.errorText,
            prefixIcon: (widget.prefixIcon == null ? null : FocusScope(
              canRequestFocus: false,
              child: widget.prefixIcon!,
            )),

            suffixIcon: FocusScope(
              canRequestFocus: false,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    (widget.obscureText ? Container(
                      padding: const EdgeInsets.all(0.0),
                      width: 40.0,
                      child: IconButton(
                        icon: Icon(
                          (_passwordVisible ? Icons.visibility_off : Icons.visibility),
                          color: Theme.of(context).primaryColor,
                        ), 
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ) : const SizedBox(width: 0, height: 0)),

                    (((widget.clearButton && _focused) || widget.clearButtonAlwaysShow) ? Container(
                      padding: const EdgeInsets.all(0.0),
                      width: 40.0,
                      child: IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Theme.of(context).primaryColor,
                        ),
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: clear,
                      ),
                    ) : const SizedBox(width: 0, height: 0)),

                    _getSuffix(),
                  ],
                ),
              ),
            ),

            enabledBorder: widget.border ?? OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: (widget.focusColor ?? Theme.of(context).primaryColor)
              ),
            ),

            disabledBorder: widget.border ?? OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: (widget.disabledColor ?? Theme.of(context).disabledColor)
              ),
            ),

            border: widget.border ?? OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: (widget.defocusColor ?? Theme.of(context).primaryColor)
              ),
            ),
          ),
        ),
      ),
    );
  }
}