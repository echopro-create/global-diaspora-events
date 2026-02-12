import 'package:flutter/material.dart';

/// Staggered-анимация для элементов списка.
///
/// Каждый элемент появляется с задержкой на основе index.
/// Стандарт premium UI 2026.
class StaggeredListItem extends StatefulWidget {
  /// Индекс элемента (для задержки).
  final int index;

  /// Дочерний виджет.
  final Widget child;

  /// Задержка между элементами.
  final Duration staggerDelay;

  /// Длительность анимации.
  final Duration duration;

  /// Начальное смещение по вертикали.
  final double verticalOffset;

  const StaggeredListItem({
    super.key,
    required this.index,
    required this.child,
    this.staggerDelay = const Duration(milliseconds: 80),
    this.duration = const Duration(milliseconds: 400),
    this.verticalOffset = 24.0,
  });

  @override
  State<StaggeredListItem> createState() => _StaggeredListItemState();
}

class _StaggeredListItemState extends State<StaggeredListItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, widget.verticalOffset),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    // Stagger delay
    Future.delayed(widget.staggerDelay * widget.index, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: _slideAnimation.value,
          child: Opacity(opacity: _fadeAnimation.value, child: child),
        );
      },
      child: widget.child,
    );
  }
}
