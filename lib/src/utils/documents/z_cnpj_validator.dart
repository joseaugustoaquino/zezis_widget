import 'dart:math';

class CnpjValidator {
  static const _weightsFirst = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  static const _weightsSecond = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

  /// Remove qualquer caractere inválido
  static String strip(String? value) {
    if (value == null) return '';

    return value
        .replaceAll(RegExp(r'[^A-Za-z0-9]'), '')
        .toUpperCase();
  }

  /// Converte caractere seguindo regra oficial da Receita:
  /// ASCII - 48
  ///
  /// Ex:
  /// 0 => 0
  /// 9 => 9
  /// A => 17
  /// B => 18
  /// Z => 42
  static int _charToValue(String char) {
    return char.codeUnitAt(0) - 48;
  }

  static int _calculateDigit(
    String base,
    List<int> weights,
  ) {
    int sum = 0;

    for (int i = 0; i < base.length; i++) {
      final value = _charToValue(base[i]);

      sum += value * weights[i];
    }

    final remainder = sum % 11;

    return remainder < 2 ? 0 : 11 - remainder;
  }

  /// Validação oficial Receita Federal
  static bool isValid(
    String? cnpj, [
    bool stripBeforeValidation = true,
  ]) {
    if (cnpj == null || cnpj.isEmpty) {
      return false;
    }

    if (stripBeforeValidation) {
      cnpj = strip(cnpj);
    }

    /// Deve possuir exatamente 14 caracteres
    if (cnpj.length != 14) {
      return false;
    }

    /// Apenas letras e números
    if (!RegExp(r'^[A-Z0-9]{14}$').hasMatch(cnpj)) {
      return false;
    }

    final base = cnpj.substring(0, 12);

    final digit1 = _calculateDigit(
      base,
      _weightsFirst,
    );

    final digit2 = _calculateDigit(
      '$base$digit1',
      _weightsSecond,
    );

    final calculatedDigits = '$digit1$digit2';

    final informedDigits = cnpj.substring(12);

    return calculatedDigits == informedDigits;
  }

  /// Formatação oficial:
  /// XX.XXX.XXX/XXXX-XX
  static String format(String value) {
    final cnpj = strip(value);

    if (cnpj.length != 14) {
      return cnpj;
    }

    final match = RegExp(
      r'^([A-Z0-9]{2})([A-Z0-9]{3})([A-Z0-9]{3})([A-Z0-9]{4})([0-9]{2})$',
    ).firstMatch(cnpj);

    if (match == null) {
      return cnpj;
    }

    return '${match.group(1)}.'
        '${match.group(2)}.'
        '${match.group(3)}/'
        '${match.group(4)}-'
        '${match.group(5)}';
  }

  /// Geração aleatória válida
  static String generate([bool useFormat = false]) {
    const chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    final random = Random();

    String base = '';

    for (int i = 0; i < 12; i++) {
      base += chars[random.nextInt(chars.length)];
    }

    final digit1 = _calculateDigit(
      base,
      _weightsFirst,
    );

    final digit2 = _calculateDigit(
      '$base$digit1',
      _weightsSecond,
    );

    final result = '$base$digit1$digit2';

    return useFormat ? format(result) : result;
  }
}