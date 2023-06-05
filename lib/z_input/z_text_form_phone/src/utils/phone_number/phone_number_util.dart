// ignore_for_file: no_duplicate_case_values
import 'package:libphonenumber_plugin/libphonenumber_plugin.dart' as p;
import 'package:zezis_widget/z_input/z_text_form_phone/src/utils/phone_number.dart';

/// A wrapper class [PhoneNumberUtil] that basically switch between plugin available for `Web` or `Android or IOS` and `Other platforms` when available.
class PhoneNumberUtil {
  /// Accepts [phoneNumber] and [isoCode]
  /// Returns [Future<String>]
  static Future<Future<p.PhoneNumberType>> getNameForNumber(
      {required String phoneNumber, required String isoCode}) async {
        var a = p.PhoneNumberUtil.getNumberType(phoneNumber, isoCode);
    return a;
  }

  /// [isValidNumber] checks if a [phoneNumber] is valid.
  /// Accepts [phoneNumber] and [isoCode]
  /// Returns [Future<bool>].
  static Future<bool?> isValidNumber(
      {required String phoneNumber, required String isoCode}) async {
    if (phoneNumber.length < 2) {
      return false;
    }
    return p.PhoneNumberUtil.isValidPhoneNumber(phoneNumber, isoCode);
  }

  /// [normalizePhoneNumber] normalizes a string of characters representing a phone number
  /// Accepts [phoneNumber] and [isoCode]
  /// Returns [Future<String>]
  static Future<String?> normalizePhoneNumber(
      {required String phoneNumber, required String isoCode}) async {
    return p.PhoneNumberUtil.normalizePhoneNumber(phoneNumber, isoCode);
  }

  /// Accepts [phoneNumber] and [isoCode]
  /// Returns [Future<RegionInfo>] of all information available about the [phoneNumber]
  static Future<RegionInfo> getRegionInfo(
      {required String phoneNumber, required String isoCode}) async {
    var response = await p.PhoneNumberUtil.getRegionInfo(phoneNumber, isoCode);

    return RegionInfo(
        regionPrefix: response.regionPrefix,
        isoCode: response.isoCode,
        formattedPhoneNumber: response.formattedPhoneNumber);
  }

  /// Accepts [phoneNumber] and [isoCode]
  /// Returns [Future<PhoneNumberType>] type of phone number
  static Future<PhoneNumberType> getNumberType(
      {required String phoneNumber, required String isoCode}) async {
    final dynamic type =
        await p.PhoneNumberUtil.getNumberType(phoneNumber, isoCode);

    return PhoneNumberTypeUtil.getType(type.index);
  }

  /// [formatAsYouType] uses Google's libphonenumber input format as you type.
  /// Accepts [phoneNumber] and [isoCode]
  /// Returns [Future<String>]
  static Future<String?> formatAsYouType({required String phoneNumber, required String isoCode}) async {
    return p.PhoneNumberUtil.formatAsYouType(phoneNumber, isoCode);
  }
}

/// [RegionInfo] contains regional information about a phone number.
/// [isoCode] current region/country code of the phone number
/// [regionPrefix] dialCode of the phone number
/// [formattedPhoneNumber] national level formatting rule apply to the phone number
class RegionInfo {
  String? regionPrefix;
  String? isoCode;
  String? formattedPhoneNumber;

  RegionInfo({this.regionPrefix, this.isoCode, this.formattedPhoneNumber});

  RegionInfo.fromJson(Map<String, dynamic> json) {
    regionPrefix = json['regionCode'];
    isoCode = json['isoCode'];
    formattedPhoneNumber = json['formattedPhoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['regionCode'] = regionPrefix;
    data['isoCode'] = isoCode;
    data['formattedPhoneNumber'] = formattedPhoneNumber;
    return data;
  }

  @override
  String toString() {
    return '[RegionInfo prefix=$regionPrefix, iso=$isoCode, formatted=$formattedPhoneNumber]';
  }
}

/// [PhoneNumberTypeUtil] helper class for `PhoneNumberType`
class PhoneNumberTypeUtil {
  /// Returns [PhoneNumberType] for index [value]
  static PhoneNumberType getType(int? value) {
    switch (value) {
      case 0:
        return PhoneNumberType.fixedLine;
      case 1:
        return PhoneNumberType.mobile;
      case 2:
        return PhoneNumberType.fixedLineOrMobile;
      case 3:
        return PhoneNumberType.tollFree;
      case 4:
        return PhoneNumberType.premiumRate;
      case 5:
        return PhoneNumberType.sharedCost;
      case 6:
        return PhoneNumberType.voip;
      case 7:
        return PhoneNumberType.personalNumber;
      case 8:
        return PhoneNumberType.pager;
      case 9:
        return PhoneNumberType.uan;
      case 10:
        return PhoneNumberType.voicemail;
      default:
        return PhoneNumberType.unknown;
    }
  }
}

/// Extension on PhoneNumberType
extension PhoneNumberTypeProperties on PhoneNumberType {
  /// Returns the index [int] of the current `PhoneNumberType`
  int get value {
    switch (this) {
      case PhoneNumberType.fixedLine:
        return 0;
      case PhoneNumberType.mobile:
        return 1;
      case PhoneNumberType.fixedLineOrMobile:
        return 2;
      case PhoneNumberType.tollFree:
        return 3;
      case PhoneNumberType.premiumRate:
        return 4;
      case PhoneNumberType.sharedCost:
        return 5;
      case PhoneNumberType.voip:
        return 6;
      case PhoneNumberType.personalNumber:
        return 7;
      case PhoneNumberType.premiumRate:
        return 8;
      case PhoneNumberType.uan:
        return 9;
      case PhoneNumberType.voicemail:
        return 10;
      default:
        return -1;
    }
  }
}
