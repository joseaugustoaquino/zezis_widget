// ignore_for_file: overridden_fieldss
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zezis_widget/data/country_model.dart';
import 'package:zezis_widget/z_input/z_input.dart';
import 'package:zezis_widget/z_input/z_number_form/z_number_form.dart';

class TextInternetionalPhone extends StatefulWidget {
  final TextEditingController? textFieldController;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<bool>? onInputValidated;
  final Function(String)? onInputChanged;
  final Function(PaisModel?)? onChanged;

  final List<PaisModel> countries;
  final PaisModel country;

  final bool? enable;
  final String? hintText;
  final String? errorMessage;

  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? paddingDdi;
  final EdgeInsetsGeometry? paddingText;
  final EdgeInsetsGeometry? padding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? mask;
  final String? initialValue;
  final Color? focusColor;

  final String? Function(dynamic)? validator;

  const TextInternetionalPhone({
    super.key,
    required this.onInputChanged,
    required this.onChanged,

    required this.country,
    required this.countries,

    this.textFieldController,
    this.onInputValidated,
    this.inputFormatters,
    this.contentPadding,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.paddingDdi,
    this.paddingText,
    this.enable,
    this.hintText = 'Celular',
    this.errorMessage = 'Número do Celular Inválido',
    this.mask = "## # ####-####",
    this.initialValue,
    this.focusColor,
    this.padding,
  });

  @override
  State<TextInternetionalPhone> createState() => _TextInternetionalPhoneState();
}

class _TextInternetionalPhoneState extends State<TextInternetionalPhone> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 135,
            child: ZComboBox(
              labelText: "DDI",
              padding: widget.paddingDdi ?? const EdgeInsets.all(0),
              items: widget.countries.map((x) { 
                return DropdownMenuItem<PaisModel>(
                  value: x,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(
                          'assets/flags/${x.sigla2.toLowerCase()}.png',
                        ),
                        width: 30,
                        height: 25,
                      ),
                      
                      const SizedBox(width: 12.0),
    
                      Text(
                        "+${x.ddi}",
                        textDirection: TextDirection.ltr,
                        style: GoogleFonts.roboto(color: Colors.black),
                      ),
                    ],
                  )
                );
              }).toList(),
              
              value: widget.country,
              onChanged: widget.onChanged,
              borderColor: widget.focusColor,
            ),
          ),

          const SizedBox(width: 8.5),
          
          Expanded(
            child: ZTextFormField(
              focusColor: widget.focusColor,
              controller: widget.textFieldController,
              padding: widget.paddingText ?? const EdgeInsets.all(0),
              autofocus: false,
              enable: widget.enable,
              style: GoogleFonts.roboto(),
              textDirection: TextDirection.ltr,
              autovalidateMode: AutovalidateMode.disabled,
              key: const Key(TestHelper.textInputKeyValue),
              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
    
              labelText: widget.hintText,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              validator: widget.validator,
              initialValue: widget.initialValue,
    
              inputFormatters: [
                ZInputFormatter(
                  mask: widget.mask?.replaceAll("0", "#"),
                  filter: {"#": RegExp(r'[0-9]'), "A": RegExp(r'[^0-9]')}
                )
              ],
    
              onChange: widget.onInputChanged,
            ),
          )
        ],
      ),
    );
  }
}
