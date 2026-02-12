import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/theme/app_radius.dart';

/// Цветовая палитра приложения Global Diaspora Events.
///
/// Адаптивная для dark/light, с glass-эффектами (2026 standard).
abstract final class AppColors {
  // ── Primary — фиолет/индиго ────────────────────────────────────
  static const primary = Color(0xFF6C5CE7);
  static const primaryLight = Color(0xFF9B8FEF);
  static const primaryDark = Color(0xFF4A3CB8);

  // ── Secondary — коралловый ─────────────────────────────────────
  static const secondary = Color(0xFFFF6B6B);
  static const secondaryLight = Color(0xFFFF9A9A);

  // ── Accent — солнечный жёлтый ──────────────────────────────────
  static const accent = Color(0xFFFFD93D);

  // ── Dark theme neutrals ────────────────────────────────────────
  static const backgroundDark = Color(0xFF0A0A14);
  static const backgroundDarkAlt = Color(0xFF0F0F1A);
  static const surfaceDark = Color(0xFF1A1A2E);
  static const cardDark = Color(0xFF222240);
  static const textPrimary = Color(0xFFF5F5F5);
  static const textSecondary = Color(0xFFB0B0C8);
  static const textMuted = Color(0xFF6C6C8A);
  static const dividerDark = Color(0xFF2A2A4A);

  // ── Light theme neutrals ───────────────────────────────────────
  static const backgroundLight = Color(0xFFFAFAFC);
  static const backgroundLightAlt = Color(0xFFF5F5F8);
  static const surfaceLight = Color(0xFFFFFFFF);
  static const cardLight = Color(0xFFF8F8FC);
  static const textPrimaryLight = Color(0xFF1C1C2E);
  static const textSecondaryLight = Color(0xFF6B6B80);
  static const textMutedLight = Color(0xFF9A9AB0);
  static const dividerLight = Color(0xFFE8E8F0);

  // ── Glass effect colors ────────────────────────────────────────
  static const glassBorderDark = Color(0x1FFFFFFF);
  static const glassBackgroundDark = Color(0x99000000);
  static const glassBorderLight = Color(0x1F000000);
  static const glassBackgroundLight = Color(0x0D000000);

  // ── Semantic colors ────────────────────────────────────────────
  static const success = Color(0xFF00C853);
  static const successLight = Color(0xFF00897B);
  static const error = Color(0xFFFF5252);
  static const errorLight = Color(0xFFD32F2F);
  static const warning = Color(0xFFFFAB40);
  static const warningLight = Color(0xFFF57C00);

  // ── Backward-compatible aliases (dark-first) ────────────────────
  /// Divider color (dark default, for backward compat).
  static const divider = dividerDark;

  // ── Theme-adaptive helpers ─────────────────────────────────────

  /// Проверить, тёмная ли тема.
  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  /// Адаптивный фон для стёкол.
  static Color adaptiveGlassBackground(BuildContext context) =>
      isDark(context) ? glassBackgroundDark : glassBackgroundLight;

  /// Адаптивная рамка стекла.
  static Color adaptiveGlassBorder(BuildContext context) =>
      isDark(context) ? glassBorderDark : glassBorderLight;

  /// Адаптивный фон карточки.
  static Color adaptiveCard(BuildContext context) =>
      isDark(context) ? cardDark : cardLight;

  /// Адаптивный основной текст.
  static Color adaptiveTextPrimary(BuildContext context) =>
      isDark(context) ? textPrimary : textPrimaryLight;

  /// Адаптивный вторичный текст.
  static Color adaptiveTextSecondary(BuildContext context) =>
      isDark(context) ? textSecondary : textSecondaryLight;

  /// Адаптивный divider.
  static Color adaptiveDivider(BuildContext context) =>
      isDark(context) ? dividerDark : dividerLight;

  /// Адаптивная ошибка.
  static Color adaptiveError(BuildContext context) =>
      isDark(context) ? error : errorLight;

  /// Адаптивный успех.
  static Color adaptiveSuccess(BuildContext context) =>
      isDark(context) ? success : successLight;
}

/// Тема приложения — dark + light, шрифт Outfit, glass aesthetic.
abstract final class AppTheme {
  /// Градиент фона — тёмная тема.
  static const LinearGradient backgroundGradientDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.backgroundDark, AppColors.backgroundDarkAlt],
  );

  /// Градиент фона — светлая тема.
  static const LinearGradient backgroundGradientLight = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.backgroundLight, AppColors.backgroundLightAlt],
  );

  // ─────────────────── DARK THEME ────────────────────────────────

  static ThemeData get darkTheme {
    final textTheme = GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      textTheme: textTheme.copyWith(
        displayLarge: textTheme.displayLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 34,
          letterSpacing: -1.0,
        ),
        headlineLarge: textTheme.headlineLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 28,
          letterSpacing: -0.5,
        ),
        headlineMedium: textTheme.headlineMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 22,
        ),
        titleLarge: textTheme.titleLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        titleMedium: textTheme.titleMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: textTheme.bodyLarge?.copyWith(
          color: AppColors.textSecondary,
          fontSize: 17,
          letterSpacing: -0.4,
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
          fontSize: 15,
          letterSpacing: -0.2,
        ),
        labelLarge: textTheme.labelLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryDark,
        secondary: AppColors.secondary,
        secondaryContainer: AppColors.secondaryLight,
        surface: AppColors.surfaceDark,
        surfaceContainerHighest: AppColors.cardDark,
        outline: AppColors.dividerDark,
        outlineVariant: AppColors.textMuted,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      cardTheme: CardThemeData(
        color: AppColors.glassBackgroundDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.lgAll,
          side: const BorderSide(color: AppColors.glassBorderDark, width: 0.5),
        ),
        margin: EdgeInsets.zero,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.cardDark,
        contentTextStyle: const TextStyle(color: AppColors.textPrimary),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.smAll),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surfaceDark,
        titleTextStyle: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        contentTextStyle: const TextStyle(color: AppColors.textSecondary),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        indicatorColor: AppColors.primary.withValues(alpha: 0.2),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: Colors.white);
          }
          return const IconThemeData(color: AppColors.textMuted);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            );
          }
          return const TextStyle(color: AppColors.textMuted, fontSize: 12);
        }),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.black.withValues(alpha: 0.3);
            }
            return AppColors.primary;
          }),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          overlayColor: WidgetStateProperty.all(
            Colors.white.withValues(alpha: 0.08),
          ),
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
          minimumSize: WidgetStateProperty.all(const Size(0, 52)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: AppRadius.smAll),
          ),
          textStyle: WidgetStateProperty.all(
            const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.smAll),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceDark,
        selectedColor: AppColors.primary.withValues(alpha: 0.2),
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        secondaryLabelStyle: const TextStyle(color: AppColors.primary),
        brightness: Brightness.dark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.dividerDark),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerDark,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.08),
        border: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(
            color: Colors.white.withValues(alpha: 0.12),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.35)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
    );
  }

  // ─────────────────── LIGHT THEME ───────────────────────────────

  static ThemeData get lightTheme {
    final textTheme = GoogleFonts.outfitTextTheme(ThemeData.light().textTheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      textTheme: textTheme.copyWith(
        displayLarge: textTheme.displayLarge?.copyWith(
          color: AppColors.textPrimaryLight,
          fontWeight: FontWeight.bold,
          fontSize: 34,
          letterSpacing: -1.0,
        ),
        headlineLarge: textTheme.headlineLarge?.copyWith(
          color: AppColors.textPrimaryLight,
          fontWeight: FontWeight.w700,
          fontSize: 28,
          letterSpacing: -0.5,
        ),
        headlineMedium: textTheme.headlineMedium?.copyWith(
          color: AppColors.textPrimaryLight,
          fontWeight: FontWeight.w600,
          fontSize: 22,
        ),
        titleLarge: textTheme.titleLarge?.copyWith(
          color: AppColors.textPrimaryLight,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        titleMedium: textTheme.titleMedium?.copyWith(
          color: AppColors.textPrimaryLight,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: textTheme.bodyLarge?.copyWith(
          color: AppColors.textSecondaryLight,
          fontSize: 17,
          letterSpacing: -0.4,
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondaryLight,
          fontSize: 15,
          letterSpacing: -0.2,
        ),
        labelLarge: textTheme.labelLarge?.copyWith(
          color: AppColors.textPrimaryLight,
          fontWeight: FontWeight.w600,
        ),
      ),
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryLight,
        secondary: AppColors.secondary,
        secondaryContainer: AppColors.secondaryLight,
        surface: AppColors.surfaceLight,
        surfaceContainerHighest: AppColors.cardLight,
        outline: AppColors.dividerLight,
        outlineVariant: AppColors.textMutedLight,
        error: AppColors.errorLight,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimaryLight,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        foregroundColor: AppColors.textPrimaryLight,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: AppColors.textPrimaryLight,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimaryLight),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceLight,
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.lgAll,
          side: const BorderSide(color: AppColors.glassBorderLight, width: 0.5),
        ),
        margin: EdgeInsets.zero,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.cardLight,
        contentTextStyle: const TextStyle(color: AppColors.textPrimaryLight),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.smAll),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surfaceLight,
        titleTextStyle: const TextStyle(
          color: AppColors.textPrimaryLight,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        contentTextStyle: const TextStyle(color: AppColors.textSecondaryLight),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceLight,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMutedLight,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surfaceLight,
        indicatorColor: AppColors.primary.withValues(alpha: 0.1),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primary);
          }
          return const IconThemeData(color: AppColors.textSecondaryLight);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            );
          }
          return const TextStyle(
            color: AppColors.textSecondaryLight,
            fontSize: 12,
          );
        }),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.primary.withValues(alpha: 0.3);
            }
            return AppColors.primary;
          }),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          overlayColor: WidgetStateProperty.all(
            Colors.black.withValues(alpha: 0.05),
          ),
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
          minimumSize: WidgetStateProperty.all(const Size(0, 52)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: AppRadius.smAll),
          ),
          textStyle: WidgetStateProperty.all(
            const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.smAll),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceLight,
        selectedColor: AppColors.primary.withValues(alpha: 0.15),
        labelStyle: const TextStyle(color: AppColors.textSecondaryLight),
        secondaryLabelStyle: const TextStyle(color: AppColors.primary),
        brightness: Brightness.light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.dividerLight),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerLight,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.black.withValues(alpha: 0.04),
        border: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(
            color: Colors.black.withValues(alpha: 0.12),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: const BorderSide(color: AppColors.errorLight, width: 1),
        ),
        hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.35)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
    );
  }
}
