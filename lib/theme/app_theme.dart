import 'package:flutter/material.dart';

// VERSIÓN DE EMERGENCIA. Simple, segura y sin errores.

class AppTheme {

  // Se usa un color base simple para ambos temas.
  static const Color _seedColor = Colors.indigo;

  static ThemeData get lightTheme {
    // Usando una definición básica que es imposible que falle.
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: _seedColor, 
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: _seedColor,
    );
  }
}