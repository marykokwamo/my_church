// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';
SharedPreferences? _prefs;

enum DeviceSize {
  mobile,
  tablet,
  desktop,
}

abstract class FlutterFlowTheme {
  static DeviceSize deviceSize = DeviceSize.mobile;

  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? _prefs?.remove(kThemeModeKey)
      : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static FlutterFlowTheme of(BuildContext context) {
    deviceSize = getDeviceSize(context);
    return LightModeTheme();
  }

  // Primary and Secondary Colors
  Color get primary => const Color(0xFFE31E24);
  Color get secondary => const Color(0xFF39D2C0);
  Color get alternate => const Color(0xFFE31E24);

  // Text Colors
  Color get primaryText => const Color(0xFF14181B);
  Color get secondaryText => const Color(0xFF57636C);

  // Background Colors
  Color get primaryBackground => const Color(0xFFF1F4F8);
  Color get secondaryBackground => const Color(0xFFFFFFFF);

  // Utility Colors
  Color get success => const Color(0xFF22C55E);
  Color get warning => const Color(0xFFF59E0B);
  Color get error => const Color(0xFFEF4444);
  Color get info => const Color(0xFF3B82F6);

  // Font Families
  String get displayLargeFamily => 'Plus Jakarta Sans';
  String get displayMediumFamily => 'Plus Jakarta Sans';
  String get displaySmallFamily => 'Plus Jakarta Sans';
  String get headlineLargeFamily => 'Plus Jakarta Sans';
  String get headlineMediumFamily => 'Plus Jakarta Sans';
  String get headlineSmallFamily => 'Plus Jakarta Sans';
  String get titleLargeFamily => 'Plus Jakarta Sans';
  String get titleMediumFamily => 'Plus Jakarta Sans';
  String get titleSmallFamily => 'Plus Jakarta Sans';
  String get labelLargeFamily => 'Plus Jakarta Sans';
  String get labelMediumFamily => 'Plus Jakarta Sans';
  String get labelSmallFamily => 'Plus Jakarta Sans';
  String get bodyLargeFamily => 'Plus Jakarta Sans';
  String get bodyMediumFamily => 'Plus Jakarta Sans';
  String get bodySmallFamily => 'Plus Jakarta Sans';

  // Text Styles
  TextStyle get displayLarge => GoogleFonts.getFont(
        displayLargeFamily,
        color: primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 57.0,
      );
  TextStyle get displayMedium => GoogleFonts.getFont(
        displayMediumFamily,
        color: primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 45.0,
      );
  TextStyle get displaySmall => GoogleFonts.getFont(
        displaySmallFamily,
        color: primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 36.0,
      );
  TextStyle get headlineLarge => GoogleFonts.getFont(
        headlineLargeFamily,
        color: primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 32.0,
      );
  TextStyle get headlineMedium => GoogleFonts.getFont(
        headlineMediumFamily,
        color: primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 28.0,
      );
  TextStyle get headlineSmall => GoogleFonts.getFont(
        headlineSmallFamily,
        color: primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 24.0,
      );
  TextStyle get titleLarge => GoogleFonts.getFont(
        titleLargeFamily,
        color: primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      );
  TextStyle get titleMedium => GoogleFonts.getFont(
        titleMediumFamily,
        color: primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );
  TextStyle get titleSmall => GoogleFonts.getFont(
        titleSmallFamily,
        color: primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      );
  TextStyle get labelLarge => GoogleFonts.getFont(
        labelLargeFamily,
        color: primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      );
  TextStyle get labelMedium => GoogleFonts.getFont(
        labelMediumFamily,
        color: primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
      );
  TextStyle get labelSmall => GoogleFonts.getFont(
        labelSmallFamily,
        color: primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 11.0,
      );
  TextStyle get bodyLarge => GoogleFonts.getFont(
        bodyLargeFamily,
        color: primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      );
  TextStyle get bodyMedium => GoogleFonts.getFont(
        bodyMediumFamily,
        color: primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
  TextStyle get bodySmall => GoogleFonts.getFont(
        bodySmallFamily,
        color: primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      );
}

class LightModeTheme extends FlutterFlowTheme {
  // Add any light mode specific overrides here
}

DeviceSize getDeviceSize(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  if (width < 479) {
    return DeviceSize.mobile;
  } else if (width < 991) {
    return DeviceSize.tablet;
  } else {
    return DeviceSize.desktop;
  }
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
    List<Shadow>? shadows,
    required double letterSpacing,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily!,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
              shadows: shadows,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
              shadows: shadows,
            );
}
