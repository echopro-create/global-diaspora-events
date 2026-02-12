import 'dart:ui';
import 'package:flutter/material.dart';
import '../../app/theme.dart';

/// Контейнер с эффектом матового стекла (glassmorphism).
///
/// Автоматически адаптируется под dark/light тему.
/// Применяет backdrop blur и полупрозрачный фон.
class GlassContainer extends StatelessWidget {
  /// Дочерний виджет.
  final Widget? child;

  /// Сила размытия фона. По умолчaniu 12, что даёт мягкий стеклянный эффект.
  final double blur;

  /// Непрозрачность фона (0.0 - 1.0).
  final double opacity;

  /// Ручной цвет фона. Если null — берётся из темы.
  final Color? color;

  /// Радиус скругления. Если null — по умолчанию ноль.
  final BorderRadius? borderRadius;

  /// Внутренние отступы.
  final EdgeInsetsGeometry? padding;

  /// Внешние отступы.
  final EdgeInsetsGeometry? margin;

  /// Рамка контейнера.
  final BoxBorder? border;

  /// Тени.
  final List<BoxShadow>? boxShadow;

  /// Gradient overlay.
  final Gradient? gradient;

  /// Ширина контейнера.
  final double? width;

  /// Высота контейнера.
  final double? height;

  const GlassContainer({
    super.key,
    this.child,
    this.blur = 12.0,
    this.opacity = 0.1,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.border,
    this.boxShadow,
    this.gradient,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final effectiveColor =
        color ??
        (isDark
            ? AppColors.cardDark.withValues(alpha: opacity)
            : AppColors.cardLight.withValues(alpha: opacity + 0.3));
    final effectiveBorder =
        border ??
        Border.all(
          color: isDark
              ? AppColors.glassBorderDark
              : AppColors.glassBorderLight,
          width: 0.5,
        );

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: effectiveColor,
              borderRadius: borderRadius,
              border: effectiveBorder,
              gradient: gradient,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
