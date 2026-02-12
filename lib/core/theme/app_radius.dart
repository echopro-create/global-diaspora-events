import 'package:flutter/material.dart';

/// Стандартизированные значения border radius для единообразного UI.
///
/// 4px/8px grid system (стандарт 2026).
class AppRadius {
  /// Extra small radius (8px) — чипы, мелкие элементы.
  static const double xs = 8;

  /// Small radius (12px) — list tiles, мелкие карточки.
  static const double sm = 12;

  /// Medium radius (16px) — кнопки, инпуты.
  static const double md = 16;

  /// Large radius (24px) — карточки, контейнеры.
  static const double lg = 24;

  /// Extra large radius (32px) — модалки, sheets.
  static const double xl = 32;

  /// BorderRadius для всех углов — xs.
  static BorderRadius get xsAll => BorderRadius.circular(xs);

  /// BorderRadius для всех углов — sm.
  static BorderRadius get smAll => BorderRadius.circular(sm);

  /// BorderRadius для всех углов — md.
  static BorderRadius get mdAll => BorderRadius.circular(md);

  /// BorderRadius для всех углов — lg.
  static BorderRadius get lgAll => BorderRadius.circular(lg);

  /// BorderRadius для всех углов — xl.
  static BorderRadius get xlAll => BorderRadius.circular(xl);
}
