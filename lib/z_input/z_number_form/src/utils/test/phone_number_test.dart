import 'dart:async';

import 'package:zezis_widget/z_input/z_number_form/src/utils/phone_number/phone_number_util.dart';

class PhoneNumberTest {
  final String? phoneNumber;
  final String? dialCode;
  final String? isoCode;

  PhoneNumberTest({this.phoneNumber, this.dialCode, this.isoCode});

  @override
  String toString() {
    return phoneNumber!;
  }

  static Future<PhoneNumberTest> getRegionInfoFromPhoneNumber(
    String phoneNumber, [
    String isoCode = '',
  ]) async {
    RegionInfo regionInfo = await PhoneNumberUtil.getRegionInfo(
        phoneNumber: phoneNumber, isoCode: isoCode);

    String? internationalPhoneNumber =
        await PhoneNumberUtil.normalizePhoneNumber(
      phoneNumber: phoneNumber,
      isoCode: regionInfo.isoCode ?? isoCode,
    );

    return PhoneNumberTest(
        phoneNumber: internationalPhoneNumber,
        dialCode: regionInfo.regionPrefix,
        isoCode: regionInfo.isoCode);
  }

  static Future<String> getParsableNumber(PhoneNumberTest phoneNumber) async {
    if (phoneNumber.isoCode != null) {
      PhoneNumberTest number = await getRegionInfoFromPhoneNumber(
        phoneNumber.phoneNumber!,
        phoneNumber.isoCode!,
      );
      String? formattedNumber = await PhoneNumberUtil.formatAsYouType(
        phoneNumber: number.phoneNumber!,
        isoCode: number.isoCode!,
      );
      return formattedNumber!.replaceAll(
        RegExp('^([\\+]?${number.dialCode}[\\s]?)'),
        '',
      );
    } else {
      throw Exception('ISO Code is "${phoneNumber.isoCode}"');
    }
  }

  String parseNumber() {
    return phoneNumber!.replaceAll(RegExp('^([\\+]?$dialCode[\\s]?)'), '');
  }
}
