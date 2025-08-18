import 'package:flutter/material.dart';

class AppConfig {
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final TypographyConfig typography;
  final bool isDarkTheme;

  AppConfig({
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.typography,
    required this.isDarkTheme,
  });

  factory AppConfig.fromMap(Map<String, dynamic> json) {
    return AppConfig(
      primaryColor: _hexToColor(json['primaryColor'] ?? '#6200EE'),
      secondaryColor: _hexToColor(json['secondaryColor'] ?? '#03DAC5'),
      backgroundColor: _hexToColor(json['backgroundColor'] ?? '#FFFFFF'),
      typography: TypographyConfig.fromMap(json['typography']),
      isDarkTheme: json['isDarkTheme'] ?? false,
    );
  }

  factory AppConfig.defaultConfig() {
    return AppConfig(
      primaryColor: Colors.deepPurple,
      secondaryColor: Colors.teal,
      backgroundColor: Colors.white,
      typography: TypographyConfig.defaultConfig(),
      isDarkTheme: false,
    );
  }

  static Color _hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse(hex, radix: 16));
  }
}

class TypographyConfig {
  final SerializableTextStyle bodyLarge;
  final SerializableTextStyle titleLarge;
  final SerializableTextStyle labelSmall;

  TypographyConfig({
    required this.bodyLarge,
    required this.titleLarge,
    required this.labelSmall,
  });

  factory TypographyConfig.fromMap(Map<String, dynamic>? json) {
    if (json == null) return TypographyConfig.defaultConfig();

    return TypographyConfig(
      bodyLarge: SerializableTextStyle.fromMap(json['bodyLarge']),
      titleLarge: SerializableTextStyle.fromMap(json['titleLarge']),
      labelSmall: SerializableTextStyle.fromMap(json['labelSmall']),
    );
  }

  factory TypographyConfig.defaultConfig() {
    return TypographyConfig(
      bodyLarge: SerializableTextStyle(fontSize: 16, lineHeight: 24, letterSpacing: 0.5),
      titleLarge: SerializableTextStyle(fontSize: 22, lineHeight: 28, letterSpacing: 0),
      labelSmall: SerializableTextStyle(fontSize: 11, lineHeight: 16, letterSpacing: 0.5),
    );
  }
}

class SerializableTextStyle {
  final double fontSize;
  final double lineHeight;
  final double letterSpacing;
  final int? fontWeight; // NEW
  final String? fontFamily; // NEW

  SerializableTextStyle({
    required this.fontSize,
    required this.lineHeight,
    required this.letterSpacing,
    this.fontWeight,
    this.fontFamily,
  });

  factory SerializableTextStyle.fromMap(Map<String, dynamic>? json) {
    if (json == null) return SerializableTextStyle(fontSize: 16, lineHeight: 24, letterSpacing: 0.5);
    return SerializableTextStyle(
      fontSize: (json['fontSize'] ?? 16).toDouble(),
      lineHeight: (json['lineHeight'] ?? 24).toDouble(),
      letterSpacing: (json['letterSpacing'] ?? 0.5).toDouble(),
      fontWeight: json['fontWeight'] != null ? (json['fontWeight'] as num).toInt() : null,
      fontFamily: json['fontFamily'] as String?,
    );
  }
}
