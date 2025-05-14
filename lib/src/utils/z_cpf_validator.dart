import 'dart:math';

/// Classe utilitária para validação, formatação e geração de CPF.
/// 
/// Esta classe fornece métodos para:
/// - Validar CPF
/// - Formatar CPF
/// - Gerar CPF válido
/// - Remover caracteres especiais
class ZCpfValidator {
  /// Lista de CPFs inválidos conhecidos
  static const List<String> blackList = [
    "00000000000",
    "11111111111",
    "22222222222",
    "33333333333",
    "44444444444",
    "55555555555",
    "66666666666",
    "77777777777",
    "88888888888",
    "99999999999",
    "12345678909"
  ];

  /// Regex para remover caracteres não numéricos
  static const String stripRegex = r'[^\d]';
  
  /// Tamanho padrão de um CPF válido
  static const int cpfLength = 11;
  
  /// Tamanho da parte numérica do CPF (sem dígitos verificadores)
  static const int cpfNumbersLength = 9;

  /// Calcula o dígito verificador do CPF
  /// 
  /// [cpf] - String contendo os números do CPF
  /// Retorna o dígito verificador calculado
  static int verifyingDigit(String cpf) {
    final numbers = cpf.split("").map((number) => int.parse(number)).toList();
    final modulus = numbers.length + 1;

    final multiplied = List.generate(
      numbers.length,
      (i) => numbers[i] * (modulus - i),
    );

    final mod = multiplied.reduce((buffer, number) => buffer + number) % 11;
    return mod < 2 ? 0 : 11 - mod;
  }

  /// Formata um CPF no padrão XXX.XXX.XXX-XX
  /// 
  /// [cpf] - String contendo o CPF a ser formatado
  /// Retorna o CPF formatado
  static String format(String cpf) {
    final cleanCpf = strip(cpf);
    if (!isValid(cleanCpf, false)) {
      throw const FormatException('CPF inválido para formatação');
    }

    final regExp = RegExp(r'^(\d{3})(\d{3})(\d{3})(\d{2})$');
    return cleanCpf.replaceAllMapped(
      regExp,
      (Match m) => "${m[1]}.${m[2]}.${m[3]}-${m[4]}",
    );
  }

  /// Remove caracteres não numéricos do CPF
  /// 
  /// [cpf] - String contendo o CPF a ser limpo
  /// Retorna o CPF apenas com números
  static String strip(String? cpf) {
    if (cpf == null) return '';
    return cpf.replaceAll(RegExp(stripRegex), '');
  }

  /// Verifica se um CPF é válido
  /// 
  /// [cpf] - String contendo o CPF a ser validado
  /// [stripBeforeValidation] - Se deve remover caracteres especiais antes da validação
  /// Retorna true se o CPF for válido, false caso contrário
  static bool isValid(String? cpf, [bool stripBeforeValidation = true]) {
    if (stripBeforeValidation) {
      cpf = strip(cpf);
    }

    if (cpf == null || cpf.isEmpty || cpf.length != cpfLength) {
      return false;
    }

    if (blackList.contains(cpf)) {
      return false;
    }

    final numbers = cpf.substring(0, cpfNumbersLength);
    final firstDigit = verifyingDigit(numbers);
    final secondDigit = verifyingDigit(numbers + firstDigit.toString());

    return cpf.substring(cpfLength - 2) == '$firstDigit$secondDigit';
  }

  /// Gera um CPF válido aleatório
  /// 
  /// [useFormat] - Se deve retornar o CPF formatado
  /// Retorna um CPF válido
  static String generate([bool useFormat = false]) {
    final random = Random();
    final numbers = List.generate(
      cpfNumbersLength,
      (_) => random.nextInt(10).toString(),
    ).join();

    final firstDigit = verifyingDigit(numbers);
    final secondDigit = verifyingDigit(numbers + firstDigit.toString());
    final cpf = numbers + firstDigit.toString() + secondDigit.toString();

    return useFormat ? format(cpf) : cpf;
  }

  /// Verifica se um CPF está formatado corretamente (XXX.XXX.XXX-XX)
  /// 
  /// [cpf] - String contendo o CPF a ser verificado
  /// Retorna true se o CPF estiver formatado corretamente
  static bool isFormatted(String cpf) {
    final regExp = RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$');
    return regExp.hasMatch(cpf);
  }
}