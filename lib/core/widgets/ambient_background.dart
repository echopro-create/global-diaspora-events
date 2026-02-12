import 'dart:math';

import 'package:flutter/material.dart';

import '../../app/theme.dart';

/// Premium анимированный фон с плавающими орбами.
///
/// Особенности:
/// - 4 слоя с орбами разных цветов (primary, secondary, accent, faded)
/// - Пульсирующая анимация (scale)
/// - Gaussian blur для мягкого свечения
/// - Оптимизация через RepaintBoundary
/// - Theme-adaptive: dark orbs on dark, subtle tints on light
class AmbientBackground extends StatefulWidget {
  const AmbientBackground({super.key});

  @override
  State<AmbientBackground> createState() => _AmbientBackgroundState();
}

class _AmbientBackgroundState extends State<AmbientBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_Orb> _orbs;
  final _random = Random(42);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _orbs = _generateOrbs();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<_Orb> _generateOrbs() {
    final colors = [
      AppColors.primary.withValues(alpha: 0.15),
      AppColors.secondary.withValues(alpha: 0.12),
      AppColors.accent.withValues(alpha: 0.08),
      AppColors.primaryLight.withValues(alpha: 0.10),
    ];

    return List.generate(4, (i) {
      return _Orb(
        color: colors[i],
        dx: _random.nextDouble(),
        dy: _random.nextDouble(),
        radius: 80 + _random.nextDouble() * 100,
        speed: 0.3 + _random.nextDouble() * 0.5,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _OrbPainter(
              orbs: _orbs,
              progress: _controller.value,
              isDark: AppColors.isDark(context),
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class _Orb {
  final Color color;
  final double dx;
  final double dy;
  final double radius;
  final double speed;

  const _Orb({
    required this.color,
    required this.dx,
    required this.dy,
    required this.radius,
    required this.speed,
  });
}

class _OrbPainter extends CustomPainter {
  final List<_Orb> orbs;
  final double progress;
  final bool isDark;

  _OrbPainter({
    required this.orbs,
    required this.progress,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final orb in orbs) {
      final x = orb.dx * size.width + sin(progress * pi * 2 * orb.speed) * 40;
      final y = orb.dy * size.height + cos(progress * pi * 2 * orb.speed) * 30;

      final scaleFactor = 1.0 + sin(progress * pi * 2) * 0.15;
      final adjustedRadius = orb.radius * scaleFactor;

      final paint = Paint()
        ..color = isDark ? orb.color : orb.color.withValues(alpha: 0.05)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 50);

      canvas.drawCircle(Offset(x, y), adjustedRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _OrbPainter old) => old.progress != progress;
}
