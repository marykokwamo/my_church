import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme {
  static const String _themePreferenceKey = 'theme_mode';
  static ThemeMode _themeMode = ThemeMode.light;
  
  // Primary Colors
  static const Color primary = Color(0xFFE31E24);
  static const Color secondary = Color(0xFFFFC107);
  
  // Background Colors
  static const Color background = Colors.white;
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFF5F5F5);
  
  // Text Colors
  static const Color text = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDisabled = Color(0xFFBDBDBD);
  
  // UI Element Colors
  static const Color divider = Color(0xFFEEEEEE);
  static const Color border = Color(0xFFE0E0E0);
  static const Color error = Color(0xFFB00020);
  static const Color success = Color(0xFF4CAF50);
  
  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF2A2A2A);
  
  // Elevation Colors
  static const Color shadow = Color(0x1F000000);

  static ThemeMode get themeMode => _themeMode;
  static bool get isSystemDarkMode => _themeMode == ThemeMode.dark;

  static Future<void> saveThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themePreferenceKey, mode.toString());
  }

  static Future<void> initializeThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMode = prefs.getString(_themePreferenceKey);
    if (savedMode != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == savedMode,
        orElse: () => ThemeMode.light,
      );
    }
  }

  static AppTheme of(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppTheme._(isDark);
  }

  static ThemeData getLightTheme() => _createTheme(false);
  static ThemeData getDarkTheme() => _createTheme(true);

  final bool isDark;
  
  const AppTheme._(this.isDark);

  Color get primaryBackground => isDark ? darkBackground : background;
  Color get primaryText => isDark ? Colors.white : text;
  Color get secondaryText => isDark ? Colors.white70 : textSecondary;
  Color get surfaceColor => isDark ? darkSurface : surface;

  static ThemeData _createTheme(bool isDark) {
    final colorScheme = isDark 
        ? ColorScheme.dark(
            primary: primary,
            secondary: secondary,
            surface: darkSurface,
            background: darkBackground,
            error: error,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Colors.white,
            onBackground: Colors.white,
            onError: Colors.white,
          )
        : ColorScheme.light(
            primary: primary,
            secondary: secondary,
            surface: surface,
            background: background,
            error: error,
            onPrimary: Colors.white,
            onSecondary: text,
            onSurface: text,
            onBackground: text,
            onError: Colors.white,
          );

    final primaryText = isDark ? Colors.white : text;
    final secondaryText = isDark ? Colors.white70 : textSecondary;
    final surfaceColor = isDark ? darkSurface : surface;
    final backgroundColor = isDark ? darkBackground : background;

    return ThemeData(
      useMaterial3: true,
      primaryColor: primary,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: primaryText,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: primaryText,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: primaryText,
        ),
        titleMedium: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: primaryText,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 16,
          color: primaryText,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 14,
          color: primaryText,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surfaceColor,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryText),
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: primaryText,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: error, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: error, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: secondaryText,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
