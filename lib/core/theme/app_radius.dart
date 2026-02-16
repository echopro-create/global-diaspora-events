import 'package:flutter/material.dart';

/// Standardized border radius values for consistent UI design.
///
/// Following the 4px/8px grid system for design consistency (2026 standard).
class AppRadius {
  /// Extra small radius (8px) - for small elements like chips.
  static const double xs = 8;

  /// Small radius (12px) - for list tiles, small cards.
  static const double sm = 12;

  /// Medium radius (16px) - for inputs, buttons.
  static const double md = 16;

  /// Large radius (24px) - for cards, containers, modals.
  static const double lg = 24;

  /// Extra large radius (32px) - for large modals, sheets.
  static const double xl = 32;

  /// BorderRadius with extra small radius for all corners.
  static BorderRadius get xsAll => BorderRadius.circular(xs);

  /// BorderRadius with small radius for all corners.
  static BorderRadius get smAll => BorderRadius.circular(sm);

  /// BorderRadius with medium radius for all corners.
  static BorderRadius get mdAll => BorderRadius.circular(md);

  /// BorderRadius with large radius for all corners.
  static BorderRadius get lgAll => BorderRadius.circular(lg);

  /// BorderRadius with extra large radius for all corners.
  static BorderRadius get xlAll => BorderRadius.circular(xl);
}
