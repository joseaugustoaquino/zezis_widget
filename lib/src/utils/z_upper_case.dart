import 'package:flutter/services.dart';

/// Um formatador de texto que converte automaticamente todo o texto para maiúsculas.
/// 
/// Este formatador pode ser usado com qualquer campo de texto do Flutter para garantir
/// que todo o texto inserido seja convertido para maiúsculas.
/// 
/// Características:
/// - Converte automaticamente todo o texto para maiúsculas
/// - Preserva a posição do cursor
/// - Mantém a composição de texto (importante para IMEs)
/// - Trata caracteres especiais e acentos
/// - Otimizado para evitar conversões desnecessárias
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Validação de entrada
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Se o texto não mudou, retorna o valor original
    if (oldValue.text == newValue.text) {
      return newValue;
    }

    // Verifica se o texto já está em maiúsculas
    final String upperText = newValue.text.toUpperCase();
    if (upperText == newValue.text) {
      return newValue;
    }

    // Calcula a nova posição do cursor
    final int cursorPosition = newValue.selection.baseOffset;
    final int textLength = upperText.length;
    
    // Ajusta a posição do cursor se necessário
    final TextSelection newSelection = TextSelection(
      baseOffset: cursorPosition > textLength ? textLength : cursorPosition,
      extentOffset: cursorPosition > textLength ? textLength : cursorPosition,
    );

    return TextEditingValue(
      text: upperText,
      selection: newSelection,
      composing: newValue.composing,
    );
  }
}