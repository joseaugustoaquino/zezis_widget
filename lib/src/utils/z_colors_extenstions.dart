import 'package:flutter/material.dart';

/// Converte uma string hexadecimal para Color
Color hexToColor(String hexColor) {
  // Remove o caractere '#' do início, se presente
  if (hexColor.startsWith('#')) {
    hexColor = hexColor.substring(1);
  }

  // Verifique se a string possui um comprimento válido
  if (hexColor.length != 6 && hexColor.length != 8) {
    throw const FormatException('Formato de cor hexadecimal inválido');
  }

  // Parse a string hexadecimal em valores RGB/RGBA
  final int red = int.parse(hexColor.substring(0, 2), radix: 16);
  final int green = int.parse(hexColor.substring(2, 4), radix: 16);
  final int blue = int.parse(hexColor.substring(4, 6), radix: 16);
  final double opacity = hexColor.length == 8 
      ? int.parse(hexColor.substring(6, 8), radix: 16) / 255 
      : 1.0;

  return Color.fromRGBO(red, green, blue, opacity);
}

/// Extensão para converter strings em cores
extension StringToColor on String? {
  /// Converte uma string em Color
  /// 
  /// Suporta os seguintes formatos:
  /// - RGB: "255,255,255"
  /// - RGBA: "255,255,255,1.0"
  /// - Hex: "#FFFFFF" ou "FFFFFF"
  /// - Nome da cor: "red", "blue", etc.
  Color toColor() {
    if (this == null || this!.isEmpty) {
      return Colors.white;
    }

    final String colorString = this!.trim();

    // Tenta converter como nome de cor
    try {
      final Color? namedColor = _getColorFromName(colorString);
      if (namedColor != null) return namedColor;
    } catch (_) {}

    // Tenta converter como hexadecimal
    if (colorString.startsWith('#') || RegExp(r'^[0-9A-Fa-f]{6}$').hasMatch(colorString)) {
      try {
        return hexToColor(colorString);
      } catch (_) {}
    }

    // Tenta converter como RGB/RGBA
    try {
      final cleanedString = colorString.replaceAll(RegExp(r'[^\d,.]'), '');
      final values = cleanedString.split(',').map((v) => v.trim()).toList();
      
      if (values.length >= 3) {
        final red = int.parse(values[0]);
        final green = int.parse(values[1]);
        final blue = int.parse(values[2]);
        final opacity = values.length > 3 ? double.parse(values[3]) : 1.0;

        if (_isValidRGBValue(red) && _isValidRGBValue(green) && _isValidRGBValue(blue) && 
            opacity >= 0 && opacity <= 1) {
          return Color.fromRGBO(red, green, blue, opacity);
        }
      }
    } catch (_) {}

    return Colors.white;
  }

  /// Converte uma string RGB para hexadecimal
  String toColorHexa() {
    try {
      final color = toColor();
      return '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}';
    } catch (e) {
      throw FormatException('Erro na conversão da string para hexadecimal: $e');
    }
  }

  /// Verifica se a string representa uma cor válida
  bool isValidColor() {
    try {
      toColor();
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Retorna a luminosidade da cor (0-1)
  double getLuminance() {
    return toColor().computeLuminance();
  }

  /// Retorna se a cor é clara ou escura
  bool isLight() {
    return getLuminance() > 0.5;
  }
}

/// Funções auxiliares
Color? _getColorFromName(String name) {
  final Map<String, Color> colorMap = {
    'red': Colors.red,
    'blue': Colors.blue,
    'green': Colors.green,
    'yellow': Colors.yellow,
    'purple': Colors.purple,
    'orange': Colors.orange,
    'pink': Colors.pink,
    'brown': Colors.brown,
    'grey': Colors.grey,
    'black': Colors.black,
    'white': Colors.white,
  };

  return colorMap[name.toLowerCase()];
}

bool _isValidRGBValue(int value) {
  return value >= 0 && value <= 255;
}

