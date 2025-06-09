import 'package:flutter/material.dart';
import 'package:movie_app/core/init/theme/app_colors.dart';

class AppTheme {
  static AppTheme? _instance;
  static AppTheme get instance {
    _instance ??= AppTheme._init();
    return _instance!;
  }

  AppTheme._init();

  ThemeData get lightTheme => _buildTheme(Brightness.light);
  ThemeData get darkTheme => _buildTheme(Brightness.dark);

  ThemeData _buildTheme(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    final colors = AppColors.instance;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.primary,
        brightness: brightness,
        primary: colors.primary,
        onPrimary: Colors.white,
        secondary: isLight ? colors.buttonSecondaryLight : colors.buttonSecondaryDark,
        onSecondary: isLight ? colors.textPrimaryLight : colors.textPrimaryDark,
        surface: isLight ? colors.surfaceLight : colors.surfaceDark,
        onSurface: isLight ? colors.textPrimaryLight : colors.textPrimaryDark,
        background: isLight ? colors.backgroundLight : colors.backgroundDark,
        onBackground: isLight ? colors.textPrimaryLight : colors.textPrimaryDark,
        error: colors.error,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: isLight ? colors.backgroundLight : colors.backgroundDark,
      
      // AppBar Theme
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: isLight ? colors.surfaceLight : colors.surfaceDark,
        foregroundColor: isLight ? colors.textPrimaryLight : colors.textPrimaryDark,
        iconTheme: IconThemeData(
          color: isLight ? colors.iconPrimaryLight : colors.iconPrimaryDark,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isLight ? colors.inputBackgroundLight : colors.inputBackgroundDark,
        hintStyle: TextStyle(
          color: isLight ? colors.inputHintLight : colors.inputHintDark,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isLight ? colors.inputBorderLight : colors.inputBorderDark,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isLight ? colors.inputBorderLight : colors.inputBorderDark,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isLight ? colors.inputFocusedLight : colors.inputFocusedDark,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.error),
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colors.buttonPrimaryDark,
          foregroundColor: isLight ? colors.buttonTextLight : colors.buttonTextDark,
          disabledBackgroundColor: isLight ? colors.buttonDisabledLight : colors.buttonDisabledDark,
          disabledForegroundColor: isLight ? colors.textTertiaryLight : colors.textTertiaryDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(double.infinity, 48),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: isLight ? colors.textPrimaryLight : colors.textPrimaryDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Icon Theme
      iconTheme: IconThemeData(
        color: isLight ? colors.iconPrimaryLight : colors.iconPrimaryDark,
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: isLight ? colors.textPrimaryLight : colors.textPrimaryDark,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: isLight ? colors.textPrimaryLight : colors.textPrimaryDark,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: isLight ? colors.textPrimaryLight : colors.textPrimaryDark,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: isLight ? colors.textPrimaryLight : colors.textPrimaryDark,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: isLight ? colors.textPrimaryLight : colors.textPrimaryDark,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: isLight ? colors.textSecondaryLight : colors.textSecondaryDark,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: isLight ? colors.textSecondaryLight : colors.textSecondaryDark,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: isLight ? colors.textPrimaryLight : colors.textPrimaryDark,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: isLight ? colors.textSecondaryLight : colors.textSecondaryDark,
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          color: isLight ? colors.textTertiaryLight : colors.textTertiaryDark,
          fontSize: 12,
        ),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: isLight ? colors.surfaceLight : colors.surfaceDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isLight ? colors.borderLight : colors.borderDark,
            width: 1,
          ),
        ),
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: isLight ? colors.dividerLight : colors.dividerDark,
        thickness: 1,
        space: 1,
      ),

      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isLight ? colors.surfaceDark : colors.surfaceLight,
        contentTextStyle: TextStyle(
          color: isLight ? colors.textPrimaryDark : colors.textPrimaryLight,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
