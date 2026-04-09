import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // ─── Color Palette ───────────────────────────────────────────────────────────

  /// Fundo geral da tela (off-white levemente azulado)
  static const Color scaffoldBackground = Color(0xFFF2F2F8);

  /// Superfície dos cards / itens da lista
  static const Color cardBackground = Color(0xFFFFFFFF);

  /// Cor primária (roxo/violeta dos checkboxes e estrelas ativas)
  static const Color primary = Color(0xFF6C63D5);

  /// Variação mais clara do primário (ícone de estrela favorita preenchida)
  static const Color primaryLight = Color(0xFF9B95E0);

  /// Cor de texto principal (títulos e itens não concluídos)
  static const Color textPrimary = Color(0xFF1E1E2D);

  /// Cor de texto secundário (subtítulos, hints, itens concluídos)
  static const Color textSecondary = Color(0xFF9090A8);

  /// Cor de texto do hint do campo "Add a task..."
  static const Color textHint = Color(0xFFB0B0C3);

  /// Cor da borda dos cards e do checkbox não marcado
  static const Color border = Color(0xFFE4E4EF);

  /// Cor do ícone "+" do campo de adicionar tarefa
  static const Color iconAdd = Color(0xFFB0B0C3);

  /// Cor dos ícones da AppBar (menu hambúrguer e lupa)
  static const Color iconAppBar = Color(0xFFB0B0C3);

  // ─── Typography ─────────────────────────────────────────────────────────────

  static const String _fontFamily = 'SF Pro Display'; // troque pela sua fonte

  static const TextTheme textTheme = TextTheme(
    /// Título da lista ("Groceries")
    headlineMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: textPrimary,
      letterSpacing: -0.5,
    ),

    /// Contador de itens ("8/9" ao lado do título)
    labelSmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: textSecondary,
    ),

    /// Texto dos itens da lista
    bodyMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: textPrimary,
      height: 1.4,
    ),

    /// Texto dos itens concluídos (com strikethrough aplicado no widget)
    bodySmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: textSecondary,
      decoration: TextDecoration.lineThrough,
      decorationColor: textSecondary,
    ),

    /// Placeholder "Add a task..."
    titleMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: textHint,
    ),
  );

  // ─── Component Themes ────────────────────────────────────────────────────────

  static CheckboxThemeData get checkboxTheme => CheckboxThemeData(
        shape: const CircleBorder(),
        side: const BorderSide(color: border, width: 1.5),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return primary;
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        // overlayColor: WidgetStateProperty.all(primary.withOpacity(0.08)),
        overlayColor: WidgetStateProperty.all(primary.withValues(alpha: 0.08)),
      );

  static CardThemeData get cardTheme => CardThemeData(
        color: cardBackground,
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: border, width: 0.8),
        ),
      );

  static InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        filled: true,
        fillColor: cardBackground,
        hintStyle: textTheme.titleMedium,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: border, width: 0.8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: border, width: 0.8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 1.2),
        ),
      );

  // ─── ThemeData principal ─────────────────────────────────────────────────────

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: primary,
          onPrimary: Colors.white,
          surface: cardBackground,
          onSurface: textPrimary,
          outline: border,
        ),
        scaffoldBackgroundColor: scaffoldBackground,
        fontFamily: _fontFamily,
        textTheme: textTheme,
        checkboxTheme: checkboxTheme,
        cardTheme: cardTheme,
        inputDecorationTheme: inputDecorationTheme,
        dividerColor: border,
        dividerTheme: const DividerThemeData(
          color: border,
          thickness: 0.5,
          space: 0,
        ),
        iconTheme: const IconThemeData(color: iconAppBar, size: 20),
      );
}
