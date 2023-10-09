import 'package:flutter/services.dart';
import 'package:zezis_widget/z_input/z_number_form/src/utils/phone_number/phone_number_util.dart';

typedef OnInputFormatted<T> = void Function(T value);

class AsYouTypeFormatter extends TextInputFormatter {
  final RegExp separatorChars = RegExp(r'[^\d]+');
  final RegExp allowedChars = RegExp(r'[\d+]');

  final int? countryDdi;
  final String countryCode;
  final OnInputFormatted<TextEditingValue> onInputFormatted;

  AsYouTypeFormatter({
    required this.countryDdi,
    required this.countryCode,
    required this.onInputFormatted
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    int oldValueLength = oldValue.text.length;
    int newValueLength = newValue.text.length;

    if (newValueLength > 0 && newValueLength > oldValueLength) {
      String newValueText = newValue.text;
      String rawText = newValueText.replaceAll(separatorChars, '');
      String textToParse = countryDdi.toString() + rawText;

      final _ = newValueText
          .substring(
            oldValue.selection.start == -1 ? 0 : oldValue.selection.start,
            newValue.selection.end == -1 ? 0 : newValue.selection.end)
          .replaceAll(separatorChars, '');

      formatAsYouType(input: textToParse).then(
        (String? value) {
          String parsedText = parsePhoneNumber(value);

          int offset =
              newValue.selection.end == -1 ? 0 : newValue.selection.end;

          if (separatorChars.hasMatch(parsedText)) {
            String valueInInputIndex = parsedText[offset - 1];

            if (offset < parsedText.length) {
              int offsetDifference = parsedText.length - offset;

              if (offsetDifference < 2) {
                if (separatorChars.hasMatch(valueInInputIndex)) {
                  offset += 1;
                } else {
                  bool isLastChar;
                  try {
                    var _ = newValueText[newValue.selection.end];
                    isLastChar = false;
                  } on RangeError {
                    isLastChar = true;
                  }
                  if (isLastChar) {
                    offset += offsetDifference;
                  }
                }
              } else {
                if (parsedText.length > offset - 1) {
                  if (separatorChars.hasMatch(valueInInputIndex)) {
                    offset += 1;
                  }
                }
              }
            }

            onInputFormatted(
              TextEditingValue(
                text: parsedText,
                selection: TextSelection.collapsed(offset: offset),
              ),
            );
          }
        },
      );
    }
    return newValue;
  }

  /// Accepts [input], unformatted phone number and
  /// returns a [Future<String>] of the formatted phone number.
  Future<String?> formatAsYouType({required String input}) async {
    try {
      String? formattedPhoneNumber = await PhoneNumberUtil.formatAsYouType(phoneNumber: input, isoCode: countryCode.toString());
      return formattedPhoneNumber;
    } on Exception {
      return '';
    }
  }

  /// Accepts a formatted [phoneNumber]
  /// returns a [String] of `phoneNumber` with the dialCode replaced with an empty String
  String parsePhoneNumber(String? phoneNumber) {
    if (countryDdi.toString().length > 4) {
      if (isPartOfNorthAmericanNumberingPlan(countryDdi.toString())) {
        String northAmericaDialCode = '+1';
        String countryDialCodeWithSpace = '$northAmericaDialCode ${countryDdi.toString().replaceFirst(northAmericaDialCode, '')}';

        return phoneNumber!
            .replaceFirst(countryDialCodeWithSpace, '')
            .replaceFirst(separatorChars, '')
            .trim();
      }
    }
    return phoneNumber!.replaceFirst(countryDdi.toString(), '').trim();
  }

  /// Accepts a [dialCode]
  /// returns a [bool], true if the `dialCode` is part of North American Numbering Plan
  bool isPartOfNorthAmericanNumberingPlan(String dialCode) {
    return dialCode.contains('+1');
  }
}
