import 'package:flutter/material.dart';

class SNSMColors {
  static const Color bleuMarin = Color(0xFF003061);
  static const Color bleuOcean = Color(0xFF1E5A96);
  static const Color bleuClair = Color(0xFF4A90C2);
  static const Color rouge = Color(0xFFE31E24);
  static const Color orange = Color(0xFFFF6B35);
  static const Color jaune = Color(0xFFFFD700);
  static const Color blanc = Color(0xFFFFFFFF);
  static const Color gris = Color(0xFF6B7280);
  static const Color grisClair = Color(0xFFD7D9D9);
}

/// ===================================================================
/// ☀️ LIGHT MODE
/// ===================================================================
const ColorScheme snsmLightColorScheme = ColorScheme(
  brightness: Brightness.light,

  // Couleurs principales
  primary: SNSMColors.bleuMarin,
  onPrimary: SNSMColors.blanc,
  primaryContainer: SNSMColors.bleuOcean,
  onPrimaryContainer: SNSMColors.blanc,

  // Couleurs secondaires
  secondary: SNSMColors.rouge,
  onSecondary: SNSMColors.blanc,
  secondaryContainer: SNSMColors.orange,
  onSecondaryContainer: SNSMColors.blanc,

  // Couleurs tertiaires
  tertiary: SNSMColors.bleuOcean,
  onTertiary: SNSMColors.blanc,
  tertiaryContainer: SNSMColors.jaune,
  onTertiaryContainer: SNSMColors.bleuMarin,

  // Couleurs d'erreur
  error: SNSMColors.rouge,
  onError: SNSMColors.blanc,
  errorContainer: Color(0xFFFFEBEE),
  onErrorContainer: SNSMColors.rouge,

  // Couleurs de surface
  surface: SNSMColors.grisClair,
  onSurface: SNSMColors.bleuMarin,
  surfaceContainerHighest: SNSMColors.bleuMarin,
  onSurfaceVariant: SNSMColors.gris,

  // Couleurs d'outline
  outline: SNSMColors.gris,
  outlineVariant: SNSMColors.grisClair,

  // Couleurs inversées
  inverseSurface: SNSMColors.bleuMarin,
  onInverseSurface: SNSMColors.blanc,
  inversePrimary: SNSMColors.bleuClair,

  // Couleurs de shadow et scrim
  shadow: Colors.black26,
  scrim: Colors.black54,
);

/// ===================================================================
///  🌙️ DARK MODE
/// ===================================================================
const ColorScheme snsmDarkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  // Couleurs principales
  primary: SNSMColors.grisClair,
  onPrimary: SNSMColors.bleuMarin,
  primaryContainer: SNSMColors.bleuOcean,
  onPrimaryContainer: SNSMColors.blanc,

  // Couleurs secondaires
  secondary: SNSMColors.rouge,
  onSecondary: SNSMColors.bleuMarin,
  secondaryContainer: SNSMColors.orange,
  onSecondaryContainer: SNSMColors.blanc,

  // Couleurs tertiaires
  tertiary: SNSMColors.jaune,
  onTertiary: SNSMColors.bleuMarin,
  tertiaryContainer: SNSMColors.bleuOcean,
  onTertiaryContainer: SNSMColors.jaune,

  // Couleurs d'erreur
  error: SNSMColors.orange,
  onError: SNSMColors.bleuMarin,
  errorContainer: Color(0xFF5D1A1D),
  onErrorContainer: SNSMColors.orange,

  // Couleurs de surface
  surface: SNSMColors.bleuMarin,
  onSurface: SNSMColors.grisClair,
  surfaceContainerHighest: Color(0xFF1F2937),
  onSurfaceVariant: SNSMColors.gris,

  // Couleurs d'outline
  outline: SNSMColors.blanc,
  outlineVariant: Color(0xFF374151),

  // Couleurs inversées
  inverseSurface: SNSMColors.grisClair,
  onInverseSurface: SNSMColors.bleuMarin,
  inversePrimary: SNSMColors.bleuMarin,

  // Couleurs de shadow et scrim
  shadow: Colors.black54,
  scrim: Colors.black87,
);
