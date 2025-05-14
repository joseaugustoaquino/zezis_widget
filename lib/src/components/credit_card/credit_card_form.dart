// ignore_for_file: must_be_immutable, library_private_types_in_public_api, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zezis_widget/src/components/credit_card/credit_card.dart';
import 'package:zezis_widget/src/utils/z_upper_case.dart';

class CreditCardForm extends StatefulWidget {
  CreditCardForm({
    super.key,
    required this.formKey,
    required this.themeColor,

    this.obscureCvv = false,
    this.obscureNumber = false,
    this.isHolderNameVisible = true,
    this.isCardNumberVisible = true,
    this.isExpiryDateVisible = true,

    this.textColor = Colors.black,
    this.cursorColor,
    
    this.cardNumberKey,
    this.cardHolderKey,
    this.expiryDateKey,
    this.cvvCodeKey,
    this.cardNumberValidator,
    this.expiryDateValidator,
    this.cvvValidator,
    this.cardHolderValidator,
    this.onFormComplete,

    this.onChangedcardCvv,
    this.onChangedcardNumber,
    this.onChangedcardExpiry,
    this.onChangedcardHolder,

    this.cvvValidationMessage = 'Insira um válido CVV',
    this.dateValidationMessage = 'Insira um válido date',
    this.numberValidationMessage = 'Insira um válido number',

    required this.cardCvvFocus,
    required this.cardNumberFocus,
    required this.cardExpiryFocus,
    required this.cardHolderFocus,
    required this.cvvCodeController,
    required this.cardNumberController,
    required this.expiryDateController,
    required this.cardHolderNameController, this.border,
  });

  String cvvValidationMessage;
  String dateValidationMessage;
  String numberValidationMessage;

  TextEditingController cardNumberController = MaskedTextController(mask: '0000 0000 0000 0000');
  TextEditingController expiryDateController = MaskedTextController(mask: '00/00');
  TextEditingController cvvCodeController = MaskedTextController(mask: '0000');
  TextEditingController cardHolderNameController = TextEditingController();
  final InputBorder? border;

  final Color themeColor;
  final Color textColor;
  final Color? cursorColor;

  final bool obscureCvv;
  final bool obscureNumber;
  final bool isHolderNameVisible;
  final bool isCardNumberVisible;
  final bool isExpiryDateVisible;

  FocusNode cardCvvFocus = FocusNode();
  FocusNode cardNumberFocus = FocusNode();
  FocusNode cardExpiryFocus = FocusNode();
  FocusNode cardHolderFocus = FocusNode();

  Function(String)? onChangedcardCvv;
  Function(String)? onChangedcardNumber;
  Function(String)? onChangedcardExpiry;
  Function(String)? onChangedcardHolder;
  

  final Function? onFormComplete;
  final GlobalKey<FormState> formKey;

  final GlobalKey<FormFieldState<String>>? cardNumberKey;
  final GlobalKey<FormFieldState<String>>? cardHolderKey;
  final GlobalKey<FormFieldState<String>>? expiryDateKey;
  final GlobalKey<FormFieldState<String>>? cvvCodeKey;

  final String? Function(String?)? cvvValidator;
  final String? Function(String?)? cardNumberValidator;
  final String? Function(String?)? expiryDateValidator;
  final String? Function(String?)? cardHolderValidator;

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: widget.themeColor.withOpacity(0.8),
        primaryColorDark: widget.themeColor,
      ),
      
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            Visibility(
              visible: widget.isCardNumberVisible,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                margin: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: TextFormField(
                  key: widget.cardNumberKey,
                  focusNode: widget.cardNumberFocus,
                  controller: widget.cardNumberController,

                  obscureText: widget.obscureNumber,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.disabled,
                  style: GoogleFonts.roboto(color: widget.textColor),
                  cursorColor: widget.cursorColor ?? widget.themeColor,
                  autofillHints: const <String>[AutofillHints.creditCardNumber],
                  onEditingComplete: () => FocusScope.of(context).requestFocus(widget.cardExpiryFocus),
                  onChanged: widget.onChangedcardNumber,
                  
                  decoration: InputDecoration(
                    labelText: 'Número do Cartão',
                    hintText: 'XXXX XXXX XXXX XXXX',
                    hintStyle: GoogleFonts.roboto(),
                    labelStyle: GoogleFonts.roboto(),
                    focusedBorder: widget.border,
                    enabledBorder: widget.border,
                  ),

                  validator: widget.cardNumberValidator ??
                  (String? value) {
                    if (value!.isEmpty || value.length < 16) {
                      return widget.numberValidationMessage;
                    }
                    return null;
                  },
                ),
              ),
            ),
            
            Row(
              children: [
                Visibility(
                  visible: widget.isExpiryDateVisible,
                  child: Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
                      child: TextFormField(
                        key: widget.expiryDateKey,
                        focusNode: widget.cardExpiryFocus,
                        controller: widget.expiryDateController,

                        onChanged: widget.onChangedcardExpiry,

                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        cursorColor: widget.cursorColor ?? widget.themeColor,
                        style: GoogleFonts.roboto(color: widget.textColor),
                        autofillHints: const <String>[AutofillHints.creditCardExpirationDate],
                        onEditingComplete: () => FocusScope.of(context).requestFocus(widget.cardCvvFocus),

                        decoration: InputDecoration(
                          hintStyle: GoogleFonts.roboto(),
                          labelStyle: GoogleFonts.roboto(),
                          focusedBorder: widget.border,
                          enabledBorder: widget.border,
                          labelText: 'MM/YY',
                          hintText: 'XX/XX',
                        ),

                        validator: widget.expiryDateValidator ??
                        (String? value) {
                          if (value!.isEmpty) {
                            return widget.dateValidationMessage;
                          }
                          final DateTime now = DateTime.now();
                          final List<String> date = value.split(RegExp(r'/'));
                          final int month = int.parse(date.first);
                          final int year = int.parse('20${date.last}');
                          final int lastDayOfMonth = month < 12
                            ? DateTime(year, month + 1, 0).day
                            : DateTime(year + 1, 1, 0).day;
                          final DateTime cardDate = DateTime(year, month, lastDayOfMonth, 23, 59, 59, 999);

                          if (cardDate.isBefore(now) || month > 12 || month == 0) {
                            return widget.dateValidationMessage;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
                    child: TextFormField(
                      key: widget.cvvCodeKey,
                      focusNode: widget.cardCvvFocus,
                      controller: widget.cvvCodeController,

                      obscureText: widget.obscureCvv,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.roboto(color: widget.textColor),
                      cursorColor: widget.cursorColor ?? widget.themeColor,
                      autofillHints: const <String>[AutofillHints.creditCardSecurityCode],
                      onEditingComplete: () => FocusScope.of(context).requestFocus(widget.cardHolderFocus),
                      textInputAction: widget.isHolderNameVisible ? TextInputAction.next : TextInputAction.done,
                      onChanged: widget.onChangedcardCvv,
                      
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.roboto(),
                        labelStyle: GoogleFonts.roboto(),
                        focusedBorder: widget.border,
                        enabledBorder: widget.border,
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      
                      validator: widget.cvvValidator ??
                      (String? value) {
                        if (value!.isEmpty || value.length < 3) {
                          return widget.cvvValidationMessage;
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            
            Visibility(
              visible: widget.isHolderNameVisible,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
                child: TextFormField(
                  key: widget.cardHolderKey,
                  focusNode: widget.cardHolderFocus,
                  controller: widget.cardHolderNameController,

                  keyboardType: TextInputType.text,
                  validator: widget.cardHolderValidator,
                  textInputAction: TextInputAction.done,
                  style: GoogleFonts.roboto(color: widget.textColor),
                  cursorColor: widget.cursorColor ?? widget.themeColor,
                  autofillHints: const <String>[AutofillHints.creditCardName],
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                  onChanged: widget.onChangedcardHolder,
                  inputFormatters: [UpperCaseTextFormatter()],

                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.roboto(),
                    labelStyle: GoogleFonts.roboto(),
                    focusedBorder: widget.border,
                    enabledBorder: widget.border,
                    labelText: 'Nome Impresso no Cartão',
                  ),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
