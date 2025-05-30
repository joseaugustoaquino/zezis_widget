import 'dart:math';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

enum MaskAutoCompletionType {
  lazy,
  eager,
}


class ZInputFormatter implements TextInputFormatter {
  String? _mask;
  List<String> _maskChars = [];
  Map<String, RegExp>? _maskFilter;

  int _maskLength = 0;
  final _TextMatcher _resultTextArray = _TextMatcher();
  String _resultTextMasked = "";

  TextEditingValue? _lastResValue;
  TextEditingValue? _lastNewValue;

  /// Create the [mask] formatter for TextField
  ///
  /// The keys of the [filter] assign which character in the mask should be replaced and the values validate the entered character
  /// By default `#` match to the number and `A` to the letter
  ZInputFormatter({
    String? mask,
    Map<String, RegExp>? filter,
    String? initialText
  }) {
    updateMask(mask: mask, filter: filter ?? {"#": RegExp(r'[0-9]'), "A": RegExp(r'[^0-9]')});
    if (initialText != null) {
      formatEditUpdate(const TextEditingValue(), TextEditingValue(text: initialText));
    }
  }

  /// Change the mask
  TextEditingValue updateMask({ String? mask, Map<String, RegExp>? filter}) {
    _mask = mask;
    if (filter != null) {
      _updateFilter(filter);
    }
    _calcMaskLength();
    final String unmaskedText = getUnmaskedText();
    clear();
    return formatEditUpdate(const TextEditingValue(), TextEditingValue(text: unmaskedText, selection: TextSelection.collapsed(offset: unmaskedText.length)));
  }

  /// Get current mask
  String? getMask() {
    return _mask;
  }

  /// Get masked text, e.g. "+0 (123) 456-78-90"
  String getMaskedText() {
    return _resultTextMasked;
  }

  /// Get unmasked text, e.g. "01234567890"
  String getUnmaskedText() {
    return _resultTextArray.toString();
  }

  /// Check if target mask is filled
  bool isFill() {
    return _resultTextArray.length == _maskLength;
  }

  /// Clear masked text of the formatter
  /// Note: you need to call this method if you clear the text of the TextField because it doesn't call the formatter when it has empty text
  void clear() {
    _resultTextMasked = "";
    _resultTextArray.clear();
    _lastResValue = null;
    _lastNewValue = null;
  }

  /// Mask some text
  String maskText(String text) {
    return ZInputFormatter(mask: _mask, filter: _maskFilter, initialText: text).getMaskedText();
  }

  /// Unmask some text
  String unmaskText(String text) {
    return ZInputFormatter(mask: _mask, filter: _maskFilter, initialText: text).getUnmaskedText();
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (_lastResValue == oldValue && newValue == _lastNewValue) {
      return oldValue;
    }
    if (oldValue.text.isEmpty) {
      _resultTextArray.clear();
    }
    _lastNewValue = newValue;
    return _lastResValue = _format(oldValue, newValue);
  }

  TextEditingValue _format(TextEditingValue oldValue, TextEditingValue newValue) {
    final mask = _mask;

    if (mask == null || mask.isEmpty == true) {
      _resultTextMasked = newValue.text;
      _resultTextArray.set(newValue.text);
      return newValue;
    }

    final String beforeText = oldValue.text;
    final String afterText = newValue.text;

    final TextSelection beforeSelection = oldValue.selection;
    final TextSelection afterSelection = newValue.selection;

    final int beforeSelectionStart = afterSelection.isValid ? beforeSelection.isValid ? beforeSelection.start : 0 : 0;
    final int beforeSelectionLength = afterSelection.isValid ? beforeSelection.isValid ? beforeSelection.end - beforeSelection.start : 0 : oldValue.text.length;

    final int lengthDifference = afterText.length - (beforeText.length - beforeSelectionLength);
    final int lengthRemoved = lengthDifference < 0 ? lengthDifference.abs() : 0;
    final int lengthAdded = lengthDifference > 0 ? lengthDifference : 0;

    final int afterChangeStart = max(0, beforeSelectionStart - lengthRemoved);
    final int afterChangeEnd = max(0, afterChangeStart + lengthAdded);

    final int beforeReplaceStart = max(0, beforeSelectionStart - lengthRemoved);
    final int beforeReplaceLength = beforeSelectionLength + lengthRemoved;

    final int beforeResultTextLength = _resultTextArray.length;

    int currentResultTextLength = _resultTextArray.length;
    int currentResultSelectionStart = 0;
    int currentResultSelectionLength = 0;

    for (var i = 0; i < min(beforeReplaceStart + beforeReplaceLength, mask.length); i++) {
      if (_maskChars.contains(mask[i]) && currentResultTextLength > 0) {
        currentResultTextLength -= 1;
        if (i < beforeReplaceStart) {
          currentResultSelectionStart += 1;
        }
        if (i >= beforeReplaceStart) {
          currentResultSelectionLength += 1;
        }
      }
    }

    final String replacementText = afterText.substring(afterChangeStart, afterChangeEnd);
    int targetCursorPosition = currentResultSelectionStart;
    if (replacementText.isEmpty) {
      _resultTextArray.removeRange(currentResultSelectionStart, currentResultSelectionStart + currentResultSelectionLength);
    } else {
      if (currentResultSelectionLength > 0) {
        _resultTextArray.removeRange(currentResultSelectionStart, currentResultSelectionStart + currentResultSelectionLength);
      }
      _resultTextArray.insert(currentResultSelectionStart, replacementText);
      targetCursorPosition += replacementText.length;
    }

    if (beforeResultTextLength == 0 && _resultTextArray.length  > 1) {
      for (var i = 0; i < mask.length; i++) {
        if (_maskChars.contains(mask[i]) || _resultTextArray.isEmpty) {
          break;
        } else if (mask[i] == _resultTextArray[0]) {
          _resultTextArray.removeAt(0);
        }
      }
    }

    int curTextPos = 0;
    int maskPos = 0;
    _resultTextMasked = "";
    int cursorPos = -1;
    int nonMaskedCount = 0;

    while (maskPos < mask.length) {
      final String curMaskChar = mask[maskPos];
      final bool isMaskChar = _maskChars.contains(curMaskChar);

      bool curTextInRange = curTextPos < _resultTextArray.length;

      String? curTextChar;
      if (isMaskChar && curTextInRange) {
        while (curTextChar == null && curTextInRange) {
          final String potentialTextChar = _resultTextArray[curTextPos];
          if (_maskFilter?[curMaskChar]?.hasMatch(potentialTextChar) == true) {
            curTextChar = potentialTextChar;
          } else {
            _resultTextArray.removeAt(curTextPos);
            curTextInRange = curTextPos < _resultTextArray.length;
            if (curTextPos <= targetCursorPosition) {
              targetCursorPosition -= 1;
            }
          }
        }
      }

      if (isMaskChar && curTextInRange && curTextChar != null) {
        _resultTextMasked += curTextChar;
        if (curTextPos == targetCursorPosition && cursorPos == -1) {
          cursorPos = maskPos - nonMaskedCount;
        }
        nonMaskedCount = 0;
        curTextPos += 1;
      } else {
        if (curTextPos == targetCursorPosition && cursorPos == -1 && !curTextInRange) {
          cursorPos = maskPos;
        }

        if (!curTextInRange) {
          break;
        } else {
          _resultTextMasked += mask[maskPos];
        }

        nonMaskedCount++;
      }

      maskPos += 1;
    }

    if (nonMaskedCount > 0) {
      _resultTextMasked = _resultTextMasked.substring(0, _resultTextMasked.length - nonMaskedCount);
      cursorPos -= nonMaskedCount;
    }

    if (_resultTextArray.length > _maskLength) {
      _resultTextArray.removeRange(_maskLength, _resultTextArray.length);
    }

    final int finalCursorPosition = cursorPos < 0 ? _resultTextMasked.length : cursorPos;

    return TextEditingValue(
      text: _resultTextMasked,
      selection: TextSelection(
        baseOffset: finalCursorPosition,
        extentOffset: finalCursorPosition,
        affinity: newValue.selection.affinity,
        isDirectional: newValue.selection.isDirectional
      )
    );
  }

  void _calcMaskLength() {
    _maskLength = 0;
    final mask = _mask;
    if (mask != null) {
      for (int i = 0; i < mask.length; i++) {
        if (_maskChars.contains(mask[i])) {
          _maskLength++;
        }
      }
    }
  }

  void _updateFilter(Map<String, RegExp> filter) {
    _maskFilter = filter;
    _maskChars = _maskFilter?.keys.toList(growable: false) ?? [];
  }
}

class _TextMatcher {

  final List<String> _symbolArray = <String>[];

  int get length => _symbolArray.fold(0, (prev, match) => prev + match.length);

  void removeRange(int start, int end) => _symbolArray.removeRange(start, end);

  void insert(int start, String substring) {
    for (var i = 0; i < substring.length; i++) {
      _symbolArray.insert(start + i, substring[i]);
    }
  }

  bool get isEmpty => _symbolArray.isEmpty;

  void removeAt(int index) => _symbolArray.removeAt(index);

  String operator[](int index) => _symbolArray[index];

  void clear() => _symbolArray.clear();

  @override
  String toString() => _symbolArray.join();

  void set(String text) {
    _symbolArray.clear();
    for (int i = 0; i < text.length; i++) {
      _symbolArray.add(text[i]);
    }
  }

}

class ZInputFormatterCurrency extends TextInputFormatter {
  final String? locale;
  final String? name;
  final String? symbol;
  final String? customPattern;

  final int? decimalDigits;

  final bool turnOffGrouping;
  final bool enableNegative;

  ZInputFormatterCurrency({
    this.locale = "pt_BR",
    this.name,
    this.symbol = "R\$",
    this.customPattern,

    this.decimalDigits = 2,
    
    this.turnOffGrouping = false,
    this.enableNegative = true,
  });

  num    _newNum = 0;
  String _newString = '';
  bool   _isNegative = false;

  void _formatter(String newText) {
    final NumberFormat format = NumberFormat.currency(
      locale: locale,
      name: name,
      symbol: symbol,
      decimalDigits: decimalDigits,
      customPattern: customPattern,
    );
    if (turnOffGrouping) {
      format.turnOffGrouping();
    }

    _newNum = num.tryParse(newText) ?? 0;
    if (format.decimalDigits! > 0) {
      _newNum /= pow(10, format.decimalDigits!);
    }
    _newString = (_isNegative ? '-' : '') + format.format(_newNum).trim();
  }


  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final bool isRemovedCharacter =
        oldValue.text.length - 1 == newValue.text.length &&
            oldValue.text.startsWith(newValue.text);

    if (enableNegative) {
      _isNegative = newValue.text.startsWith('-');
    } else {
      _isNegative = false;
    }

    String newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');

    // the digit manually.
    if (isRemovedCharacter && !_lastCharacterIsDigit(oldValue.text)) {
      final int length = newText.length - 1;
      newText = newText.substring(0, length > 0 ? length : 0);
    }

    _formatter(newText);

    if (newText.trim() == '' || newText == '00' || newText == '000') {
      return TextEditingValue(
        text: _isNegative ? '-' : '',
        selection: TextSelection.collapsed(offset: _isNegative ? 1 : 0),
      );
    }

    return TextEditingValue(
      text: _newString,
      selection: TextSelection.collapsed(offset: _newString.length),
    );
  }

  static bool _lastCharacterIsDigit(String text) {
    final String lastChar = text.substring(text.length - 1);
    return RegExp('[0-9]').hasMatch(lastChar);
  }

}

class ZDecimalTextInputFormatter extends TextInputFormatter {
  ZDecimalTextInputFormatter({
    required this.decimalRange
  }) : assert(decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    TextSelection newSelection = newValue.selection;
    
    String truncated = newValue.text.replaceAll(",", ".");
    String value = newValue.text.replaceAll(",", ".");

    if (value.contains(".") &&
        value.substring(value.indexOf(".") + 1).length > decimalRange) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    } else if (value == ".") {
      truncated = "0.";

      newSelection = newValue.selection.copyWith(
        baseOffset: min(truncated.length, truncated.length + 1),
        extentOffset: min(truncated.length, truncated.length + 1),
      );
    }

    return TextEditingValue(
      text: truncated,
      selection: newSelection,
      composing: TextRange.empty,
    );
  }
}

/// Formata números de telefone e celular com máscaras personalizadas.
/// 
/// Suporta dois tipos de máscaras:
/// - Telefone fixo (## ####-####)
/// - Celular (## # ####-####)
class PhoneInputFormatter extends TextInputFormatter {
  /// Máscara para números de celular
  final String maskCellPhone;
  
  /// Máscara para números de telefone fixo
  final String maskPhone;

  /// Construtor que recebe as máscaras personalizadas
  PhoneInputFormatter({
    this.maskCellPhone = "## # ####-####",
    this.maskPhone = "## ####-####",
  });

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    try {
      // Remove caracteres não numéricos
      final String cleanText = newValue.text.replaceAll(RegExp(r'\D'), '');
      
      // Limita o tamanho máximo do número
      if (cleanText.length > 11) {
        return oldValue;
      }

      // Determina qual máscara usar
      final String mask = cleanText.length > 10 ? maskCellPhone : maskPhone;
      
      // Aplica a máscara
      final String formattedText = _applyMask(cleanText, mask);
      
      // Calcula a posição do cursor
      final int cursorPosition = _calculateCursorPosition(
        oldValue: oldValue,
        newValue: newValue,
        formattedText: formattedText,
      );

      return TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: cursorPosition),
      );
    } catch (e) {
      // Em caso de erro, retorna o valor antigo
      return oldValue;
    }
  }

  /// Aplica a máscara ao texto limpo
  String _applyMask(String text, String mask) {
    final buffer = StringBuffer();
    int textIndex = 0;

    for (int i = 0; i < mask.length && textIndex < text.length; i++) {
      if (mask[i] == '#') {
        buffer.write(text[textIndex]);
        textIndex++;
      } else {
        buffer.write(mask[i]);
      }
    }

    return buffer.toString();
  }

  /// Calcula a posição correta do cursor após a formatação
  int _calculateCursorPosition({
    required TextEditingValue oldValue,
    required TextEditingValue newValue,
    required String formattedText,
  }) {
    // Se estiver apagando, mantém a posição do cursor
    if (oldValue.text.length > newValue.text.length) {
      return newValue.selection.baseOffset;
    }

    // Conta caracteres não numéricos até a posição do cursor
    int nonDigitCount = 0;
    int cursorPosition = newValue.selection.baseOffset;

    for (int i = 0; i < cursorPosition && i < formattedText.length; i++) {
      if (!RegExp(r'\d').hasMatch(formattedText[i])) {
        nonDigitCount++;
      }
    }

    // Ajusta a posição do cursor considerando os caracteres não numéricos
    cursorPosition += nonDigitCount;

    // Garante que o cursor não ultrapasse o tamanho do texto
    return cursorPosition.clamp(0, formattedText.length);
  }
}