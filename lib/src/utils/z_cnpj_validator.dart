import 'dart:math';

/// Classe utilitária para validação, formatação e geração de CNPJs.
/// 
/// Esta classe fornece métodos para:
/// - Validar CNPJs
/// - Formatar CNPJs
/// - Gerar CNPJs válidos aleatórios
/// - Remover caracteres especiais
class ZCnpjValidator {
  /// Lista de CNPJs inválidos conhecidos
  static const blackList = <String>[
    "00000000000000",
    "11111111111111",
    "22222222222222",
    "33333333333333",
    "44444444444444",
    "55555555555555",
    "66666666666666",
    "77777777777777",
    "88888888888888",
    "99999999999999"
  ];

  /// Expressão regular para remover caracteres não numéricos
  static const stripRegex = r'[^\d]';

  /// Calcula o dígito verificador do CNPJ
  /// 
  /// [cnpj] deve conter apenas números
  /// Retorna o dígito verificador calculado
  static int verifyingDigit(String cnpj) {
    if (cnpj.isEmpty) return 0;
    
    final List<int> digits = cnpj.split('').map((s) => int.parse(s)).toList();
    final List<int> weights = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    
    int sum = 0;
    for (int i = 0; i < digits.length; i++) {
      sum += digits[i] * weights[i];
    }
    
    int mod = sum % 11;
    return mod < 2 ? 0 : 11 - mod;
  }

  /// Formata um CNPJ no padrão XX.XXX.XXX/XXXX-XX
  /// 
  /// [cnpj] pode conter ou não caracteres especiais
  /// Retorna o CNPJ formatado ou string vazia se inválido
  static String format(String cnpj) {
    final cleanCnpj = strip(cnpj);
    if (!isValid(cleanCnpj, false)) return '';
    
    RegExp regExp = RegExp(r'^(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})$');
    return cleanCnpj.replaceAllMapped(
        regExp, (Match m) => "${m[1]}.${m[2]}.${m[3]}/${m[4]}-${m[5]}");
  }

  /// Remove todos os caracteres não numéricos do CNPJ
  /// 
  /// [cnpj] pode ser nulo
  /// Retorna apenas os números do CNPJ
  static String strip(String? cnpj) {
    if (cnpj == null) return '';
    return cnpj.replaceAll(RegExp(stripRegex), '');
  }

  /// Verifica se um CNPJ é válido
  /// 
  /// [cnpj] pode conter ou não caracteres especiais
  /// [stripBeforeValidation] indica se deve remover caracteres especiais antes da validação
  /// Retorna true se o CNPJ for válido
  static bool isValid(String? cnpj, [bool stripBeforeValidation = true]) {
    if (stripBeforeValidation) {
      cnpj = strip(cnpj);
    }

    if (cnpj == null || cnpj.isEmpty || cnpj.length != 14) {
      return false;
    }

    if (blackList.contains(cnpj)) {
      return false;
    }

    String numbers = cnpj.substring(0, 12);
    numbers += verifyingDigit(numbers).toString();
    numbers += verifyingDigit(numbers).toString();

    return numbers.substring(numbers.length - 2) == cnpj.substring(cnpj.length - 2);
  }

  /// Gera um CNPJ válido aleatório
  /// 
  /// [useFormat] indica se o CNPJ deve ser retornado formatado
  /// Retorna um CNPJ válido
  static String generate([bool useFormat = false]) {
    final random = Random();
    String numbers = '';
    
    // Gera os primeiros 12 dígitos
    for (var i = 0; i < 12; i++) {
      numbers += random.nextInt(10).toString();
    }
    
    // Calcula e adiciona os dígitos verificadores
    numbers += verifyingDigit(numbers).toString();
    numbers += verifyingDigit(numbers).toString();

    // Verifica se o CNPJ gerado não está na blacklist
    if (blackList.contains(numbers)) {
      return generate(useFormat);
    }

    return useFormat ? format(numbers) : numbers;
  }
}
