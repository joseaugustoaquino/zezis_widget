// ignore_for_file: overridden_fieldss
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zezis_widget/src/models/country_model.dart';
import 'package:zezis_widget/src/components/input/z_combo_box/z_combo_box.dart';
import 'package:zezis_widget/src/utils/z_input_formatter.dart';
import 'package:zezis_widget/src/components/input/z_text_form/z_text_form_field.dart';

class ZTextFormFieldPhone extends StatefulWidget {
  final TextEditingController? textFieldController;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<bool>? onInputValidated;
  final Function(String)? onInputChanged;
  final Function(PaisModel?)? onChanged;

  final List<PaisModel> countries;
  final PaisModel country;

  final bool? enable;
  final bool enableIcon;
  final String? hintText;
  final String? errorMessage;

  final double width;
  final double orderDdi;
  final double orderContact;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? paddingDdi;
  final EdgeInsetsGeometry? paddingText;
  final EdgeInsetsGeometry? padding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? focusColor;

  final String maskCellPhone;
  final String maskPhone;

  final String? Function(dynamic)? validator;

  const ZTextFormFieldPhone({
    super.key,
    required this.onInputChanged,
    required this.onChanged,

    required this.country,
    required this.countries,

    this.orderDdi = 1.0,
    this.orderContact = 2.0,
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
    this.width = 135.0,
    this.enableIcon = true,
    this.hintText = 'Celular',
    this.errorMessage = 'Número do Celular Inválido',
    this.focusColor,
    this.padding,

    this.maskCellPhone = "## # ####-####",
    this.maskPhone = "## ####-####",
  });

  @override
  State<ZTextFormFieldPhone> createState() => _ZTextFormFieldPhoneState();
}

class _ZTextFormFieldPhoneState extends State<ZTextFormFieldPhone> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: widget.width,
            child: ZComboBox(
              labelText: "DDI",
              padding: widget.paddingDdi ?? const EdgeInsets.all(0),
              items: widget.countries.map((x) { 
                return DropdownMenuItem<PaisModel>(
                  value: x,
                  child: !widget.enableIcon 
                  ? Text(
                      "+${x.ddi}",
                      textDirection: TextDirection.ltr,
                      style: const TextStyle(color: Colors.black),
                    ) 
                  : Row(
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
                          style: const TextStyle(color: Colors.black),
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
              autofocus: false,
              enable: widget.enable,
              style: const TextStyle(),
              focusColor: widget.focusColor,
              textDirection: TextDirection.ltr,
              controller: widget.textFieldController,
              autovalidateMode: AutovalidateMode.disabled,
              padding: widget.paddingText ?? const EdgeInsets.all(0),
              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                
              labelText: widget.hintText,
              validator: widget.validator,
              prefixIcon: widget.prefixIcon,  
              suffixIcon: widget.suffixIcon,
                
              inputFormatters: [
                PhoneInputFormatter(
                  maskCellPhone: widget.maskCellPhone,
                  maskPhone: widget.maskPhone,
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
