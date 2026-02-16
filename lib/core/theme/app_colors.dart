import 'package:flutter/material.dart';

/// GDE Application color palette with brand identity.
///
/// Primary: Deep Blue (#1E3A8A)
/// Accent: Rainbow Gradient (Pink → Teal → Blue → Coral)
/// Design: iOS 26.3 glassmorphism for both dark & light themes.
class AppColors {
  // ============ Brand Colors ============

  /// GDE Primary Brand Color - Deep Blue
  static const Color gdePrimary = Color(0xFF1E3A8A);

  /// GDE Accent Gradient Colors (Rainbow)
  static const Color gdePink = Color(0xFFFF6B6B);
  static const Color gdeTeal = Color(0xFF4ECDC4);
  static const Color gdeBlue = Color(0xFF45B7D1);
  static const Color gdeCoral = Color(0xFFFFA07A);

  /// Aliases for easier access
  static const Color accentPink = gdePink;
  static const Color accentBlue = gdeBlue;

  // ============ Dark Theme ============

  /// Pure black background
  static const Color background = Color(0xFF000000);

  /// Subtle contrast background
  static const Color backgroundAlt = Color(0xFF0F0F0F);

  /// Card/elevated surface
  static const Color surface = Color(0xFF121212);

  /// Primary text/icons (white)
  static const Color primary = Color(0xFFFFFFFF);

  /// Secondary text (WCAG AAA: 5.5:1)
  static const Color secondary = Color(0xFFC5C5CA);

  // ============ Light Theme ============

  /// Off-white background
  static const Color backgroundLight = Color(0xFFFAFAFA);

  /// Alternative light background
  static const Color backgroundAltLight = Color(0xFFF5F5F5);

  /// Pure white surface
  static const Color surfaceLight = Color(0xFFFFFFFF);

  /// Near-black text
  static const Color primaryLight = Color(0xFF1C1C1E);

  /// Gray text
  static const Color secondaryLight = Color(0xFF6B6B70);

  // ============ Semantic Colors ============

  /// Error - Dark theme (soft red)
  static const Color error = Color(0xFFE57373);

  /// Error - Light theme (4.5:1 contrast)
  static const Color errorLight = Color(0xFFD32F2F);

  /// Success - Dark theme (calm teal)
  static const Color success = Color(0xFF4DB6AC);

  /// Success - Light theme (4.6:1 contrast)
  static const Color successLight = Color(0xFF00897B);

  /// Warning - Dark theme (orange-yellow)
  static const Color warning = Color(0xFFFFB74D);

  /// Warning - Light theme (3.0:1 contrast)
  static const Color warningLight = Color(0xFFF57C00);

  // ============ Glass Effects - Dark ============

  /// Glass border (12% white)
  static const Color glassBorder = Color(0x1FFFFFFF);

  /// Glass background (60% black)
  static const Color glassBackground = Color(0x99000000);

  /// Primary glass button (60% black)
  static const Color glassButtonPrimary = Color(0x99000000);

  /// Secondary glass button (40% black)
  static const Color glassButtonSecondary = Color(0x66000000);

  // ============ Glass Effects - Light ============

  /// Glass border (12% black)
  static const Color glassBorderLight = Color(0x1F000000);

  /// Glass background (5% black)
  static const Color glassBackgroundLight = Color(0x0D000000);

  /// Primary glass button (10% black)
  static const Color glassButtonPrimaryLight = Color(0x1A000000);

  /// Secondary glass button (5% black)
  static const Color glassButtonSecondaryLight = Color(0x0D000000);

  // ============ Event Category Colors ============

  /// Concert category
  static const Color categoryConvert = gdePink;

  /// Art/Exhibition category
  static const Color categoryArt = Color(0xFF9B59B6);

  /// Community/Social category
  static const Color categoryCommunity = gdeTeal;

  /// Sport category
  static const Color categorySport = gdeBlue;

  /// Food/Gastronomy category
  static const Color categoryFood = gdeCoral;

  /// Culture/Festival category
  static const Color categoryCulture = Color(0xFFF39C12);

  // ============ Helper Methods ============

  /// Returns background color based on theme brightness
  static Color getBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? background
        : backgroundLight;
  }

  /// Returns surface color based on theme brightness
  static Color getSurface(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? surface
        : surfaceLight;
  }

  /// Returns primary text color based on theme brightness
  static Color getPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? primary
        : primaryLight;
  }

  /// Returns secondary text color based on theme brightness
  static Color getSecondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? secondary
        : secondaryLight;
  }
}
