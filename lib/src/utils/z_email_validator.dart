library email_validator;

import 'dart:core';

/// Enum que define os tipos possíveis de subdomínio
enum SubdomainType { none, alphabetic, numeric, alphaNumeric }

/// Classe responsável por validar endereços de email
/// Implementa as especificações RFC 5322 e RFC 6530 (para emails internacionais)
class ZEmailValidator {
  static int _index = 0;

  // Constantes para validação
  static const String _atomCharacters = "!#\$%&'*+-/=?^_`{|}~";
  static const int _maxEmailLength = 254; // RFC 5321
  static const int _maxLocalPartLength = 64;
  
  static SubdomainType _domainType = SubdomainType.none;

  /// Verifica se um caractere é um dígito
  static bool _isDigit(String c) {
    return c.codeUnitAt(0) >= 48 && c.codeUnitAt(0) <= 57;
  }

  /// Verifica se um caractere é uma letra
  static bool _isLetter(String c) {
    return (c.codeUnitAt(0) >= 65 && c.codeUnitAt(0) <= 90) ||
        (c.codeUnitAt(0) >= 97 && c.codeUnitAt(0) <= 122);
  }

  /// Verifica se um caractere é uma letra ou dígito
  static bool _isLetterOrDigit(String c) {
    return _isLetter(c) || _isDigit(c);
  }

  /// Verifica se um caractere é válido para a parte local do email
  static bool _isAtom(String c, bool allowInternational) {
    return c.codeUnitAt(0) < 128
        ? _isLetterOrDigit(c) || _atomCharacters.contains(c)
        : allowInternational;
  }

  /// Verifica se um caractere é válido para o domínio
  static bool _isDomain(String c, bool allowInternational) {
    if (c.codeUnitAt(0) < 128) {
      if (_isLetter(c) || c == '-') {
        _domainType = SubdomainType.alphabetic;
        return true;
      }

      if (_isDigit(c)) {
        _domainType = SubdomainType.numeric;
        return true;
      }

      return false;
    }

    if (allowInternational) {
      _domainType = SubdomainType.alphabetic;
      return true;
    }

    return false;
  }

  /// Verifica se um caractere é válido para o início do domínio
  static bool _isDomainStart(String c, bool allowInternational) {
    if (c.codeUnitAt(0) < 128) {
      if (_isLetter(c)) {
        _domainType = SubdomainType.alphabetic;
        return true;
      }

      if (_isDigit(c)) {
        _domainType = SubdomainType.numeric;
        return true;
      }

      _domainType = SubdomainType.none;
      return false;
    }

    if (allowInternational) {
      _domainType = SubdomainType.alphabetic;
      return true;
    }

    _domainType = SubdomainType.none;
    return false;
  }

  /// Valida um endereço de email
  /// 
  /// [email] - O endereço de email a ser validado
  /// [allowTopLevelDomains] - Se true, permite domínios de primeiro nível (ex: email@example)
  /// [allowInternational] - Se true, permite caracteres internacionais no email
  /// 
  /// Retorna true se o email for válido, false caso contrário
  static bool validate(String email,
      [bool allowTopLevelDomains = false, bool allowInternational = true]) {
    _index = 0;

    // Validações básicas
    if (email.isEmpty || 
        email.length > _maxEmailLength ||
        !email.contains('@')) {
      return false;
    }

    // Validação da parte local
    if (email[_index] == '"') {
      if (!_skipQuoted(email, allowInternational) || _index >= email.length) {
        return false;
      }
    } else {
      if (!_skipAtom(email, allowInternational) || _index >= email.length) {
        return false;
      }

      while (email[_index] == '.') {
        _index++;

        if (_index >= email.length || _index > _maxLocalPartLength) {
          return false;
        }

        if (!_skipAtom(email, allowInternational)) {
          return false;
        }
      }
    }

    // Validação do @
    if (_index + 1 >= email.length || 
        _index > _maxLocalPartLength || 
        email[_index++] != '@') {
      return false;
    }

    // Validação do domínio
    if (email[_index] != '[') {
      if (!_skipDomain(email, allowTopLevelDomains, allowInternational)) {
        return false;
      }
      return _index == email.length;
    }

    // Validação de endereço literal (IPv4/IPv6)
    _index++;
    if (_index + 8 >= email.length) {
      return false;
    }

    final ipv6 = email.substring(_index - 1).toLowerCase();
    if (ipv6.contains('ipv6:')) {
      _index += 'IPv6:'.length;
      if (!_skipIPv6Literal(email)) {
        return false;
      }
    } else {
      if (!_skipIPv4Literal(email)) {
        return false;
      }
    }

    if (_index >= email.length || email[_index++] != ']') {
      return false;
    }

    return _index == email.length;
  }

  static bool _skipAtom(String text, bool allowInternational) {
    final startIndex = _index;

    while (_index < text.length && _isAtom(text[_index], allowInternational)) {
      _index++;
    }

    return _index > startIndex;
  }

  // Skips checking of subdomain and returns false if domainType is None
  // Otherwise returns true
  static bool _skipSubDomain(String text, bool allowInternational) {
    final startIndex = _index;

    if (!_isDomainStart(text[_index], allowInternational)) {
      return false;
    }

    _index++;

    while (
        _index < text.length && _isDomain(text[_index], allowInternational)) {
      _index++;
    }

    // 1 letter tld is not valid
    if (_index == text.length && (_index - startIndex) == 1) {
      return false;
    }

    return (_index - startIndex) < 64 && text[_index - 1] != '-';
  }

  // Skips checking of domain if domainType is numeric and returns false
  // Otherwise, return true
  static bool _skipDomain(
      String text, bool allowTopLevelDomains, bool allowInternational) {
    if (!_skipSubDomain(text, allowInternational)) {
      return false;
    }

    if (_index < text.length && text[_index] == '.') {
      do {
        _index++;

        if (_index == text.length) {
          return false;
        }

        if (!_skipSubDomain(text, allowInternational)) {
          return false;
        }
      } while (_index < text.length && text[_index] == '.');
    } else if (!allowTopLevelDomains) {
      return false;
    }

    // Note: by allowing AlphaNumeric,
    // we get away with not having to support punycode.
    if (_domainType == SubdomainType.numeric) {
      return false;
    }

    return true;
  }

  // Function skips over quoted text where if quoted text is in the string
  // the function returns true
  // otherwise the function returns false
  static bool _skipQuoted(String text, bool allowInternational) {
    var escaped = false;

    // skip over leading '"'
    _index++;

    while (_index < text.length) {
      if (text[_index].codeUnitAt(0) >= 128 && !allowInternational) {
        return false;
      }

      if (text[_index] == '\\') {
        escaped = !escaped;
      } else if (!escaped) {
        if (text[_index] == '"') {
          break;
        }
      } else {
        escaped = false;
      }

      _index++;
    }

    if (_index >= text.length || text[_index] != '"') {
      return false;
    }

    _index++;

    return true;
  }

  static bool _skipIPv4Literal(String text) {
    var groups = 0;

    while (_index < text.length && groups < 4) {
      final startIndex = _index;
      var value = 0;

      while (_index < text.length &&
          text[_index].codeUnitAt(0) >= 48 &&
          text[_index].codeUnitAt(0) <= 57) {
        value = (value * 10) + (text[_index].codeUnitAt(0) - 48);
        _index++;
      }

      if (_index == startIndex || _index - startIndex > 3 || value > 255) {
        return false;
      }

      groups++;

      if (groups < 4 && _index < text.length && text[_index] == '.') {
        _index++;
      }
    }

    return groups == 4;
  }

  static bool _isHexDigit(String str) {
    final c = str.codeUnitAt(0);
    return (c >= 65 && c <= 70) ||
        (c >= 97 && c <= 102) ||
        (c >= 48 && c <= 57);
  }

  // This needs to handle the following forms:
  //
  // IPv6-addr = IPv6-full / IPv6-comp / IPv6v4-full / IPv6v4-comp
  // IPv6-hex  = 1*4HEXDIG
  // IPv6-full = IPv6-hex 7(":" IPv6-hex)
  // IPv6-comp = [IPv6-hex *5(":" IPv6-hex)] "::" [IPv6-hex *5(":" IPv6-hex)]
  //             ; The "::" represents at least 2 16-bit groups of zeros
  //             ; No more than 6 groups in addition to the "::" may be
  //             ; present
  // IPv6v4-full = IPv6-hex 5(":" IPv6-hex) ":" IPv4-address-literal
  // IPv6v4-comp = [IPv6-hex *3(":" IPv6-hex)] "::"
  //               [IPv6-hex *3(":" IPv6-hex) ":"] IPv4-address-literal
  //             ; The "::" represents at least 2 16-bit groups of zeros
  //             ; No more than 4 groups in addition to the "::" and
  //             ; IPv4-address-literal may be present
  static bool _skipIPv6Literal(String text) {
    var compact = false;
    var colons = 0;

    while (_index < text.length) {
      var startIndex = _index;

      while (_index < text.length && _isHexDigit(text[_index])) {
        _index++;
      }

      if (_index >= text.length) {
        break;
      }

      if (_index > startIndex && colons > 2 && text[_index] == '.') {
        // IPv6v4
        _index = startIndex;

        if (!_skipIPv4Literal(text)) {
          return false;
        }

        return compact ? colons < 6 : colons == 6;
      }

      var count = _index - startIndex;
      if (count > 4) {
        return false;
      }

      if (text[_index] != ':') {
        break;
      }

      startIndex = _index;
      while (_index < text.length && text[_index] == ':') {
        _index++;
      }

      count = _index - startIndex;
      if (count > 2) {
        return false;
      }

      if (count == 2) {
        if (compact) {
          return false;
        }

        compact = true;
        colons += 2;
      } else {
        colons++;
      }
    }

    if (colons < 2) {
      return false;
    }

    return compact ? colons < 7 : colons == 7;
  }
}
