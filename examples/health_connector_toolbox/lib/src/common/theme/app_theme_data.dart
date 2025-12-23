import 'package:flutter/material.dart';

import 'package:health_connector_toolbox/src/common/theme/app_status_colors.dart';

final appThemeData = ThemeData(
  colorScheme:
      ColorScheme.fromSeed(
        seedColor: const Color(0xFF2196F3),
      ).copyWith(
        outline: const Color(0xFFBDBDBD),
        onSurfaceVariant: const Color(0xFF757575),
        surfaceContainerHighest: const Color(0xFFE0E0E0),
        error: Colors.red,
        errorContainer: Colors.red.withValues(
          alpha: 0.1,
        ),
      ),
  extensions: <ThemeExtension<dynamic>>[
    AppStatusColors(
      success: Colors.green,
      onSuccess: Colors.white,
      successContainer: Colors.green.withValues(
        alpha: 0.1,
      ),
      onSuccessContainer: const Color(0xFF388E3C),
      warning: Colors.orange,
      onWarning: Colors.white,
      warningContainer: Colors.amber.withValues(
        alpha: 0.1,
      ),
      onWarningContainer: const Color(0xFFE65100),
      info: Colors.blue,
      onInfo: Colors.white,
      infoContainer: Colors.blue.withValues(alpha: 0.1),
      onInfoContainer: const Color(0xFF1976D2),
    ),
  ],
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    labelLarge: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
    ),
    labelMedium: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      color: Color(0xFF757575),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(64, 48),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(64, 48),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      minimumSize: const Size(64, 48),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
);
