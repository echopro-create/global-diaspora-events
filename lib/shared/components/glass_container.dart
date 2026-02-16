import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Container with glassmorphism effect.
///
/// Applies blur and semi-transparent background for premium design.
class GlassContainer extends StatelessWidget {
  /// Child widget.
  final Widget child;

  /// Background blur strength.
  final double blur;

  /// Border radius.
  final double borderRadius;

  /// Internal padding.
  final EdgeInsetsGeometry padding;

  /// Background color (optional override).
  final Color? color;

  /// Border color (optional override).
  final Color? borderColor;

  /// Background opacity (0.0 - 1.0).
  final double? opacity;

  /// Creates [GlassContainer] instance.
  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 20,
    this.borderRadius = 24,
    this.padding = const EdgeInsets.all(24),
    this.color,
    this.borderColor,
    this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Use theme-appropriate base colors
    final defaultColor =
        isDark ? AppColors.glassBackground : AppColors.glassBackgroundLight;
    final defaultBorder =
        isDark ? AppColors.glassBorder : AppColors.glassBorderLight;

    final baseColor = color ?? defaultColor;
    final backgroundColor =
        opacity != null ? baseColor.withValues(alpha: opacity!) : baseColor;

    // Reduce blur for light theme - subtler glass effect
    final effectiveBlur = isDark ? blur : blur * 0.5;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: effectiveBlur, sigmaY: effectiveBlur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor ?? defaultBorder,
              width: 0.5,
            ),
            // Add subtle shadow for light theme depth
            boxShadow: isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: child,
        ),
      ),
    );
  }
}
