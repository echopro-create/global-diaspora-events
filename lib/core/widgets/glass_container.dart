import 'dart:ui';
import 'package:flutter/material.dart';
import '../../app/theme.dart';

class GlassContainer extends StatelessWidget {
  final Widget? child;
  final double blur;
  final double opacity;
  final Color? color;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;

  const GlassContainer({
    super.key,
    this.child,
    this.blur = 10.0,
    this.opacity = 0.1,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.border,
    this.boxShadow,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              color: color ?? AppColors.cardDark.withValues(alpha: opacity),
              borderRadius: borderRadius,
              border:
                  border ??
                  Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 1.0,
                  ),
              gradient: gradient,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
