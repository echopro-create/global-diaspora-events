import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

/// Модель категории событий.
@freezed
abstract class Category with _$Category {
  const factory Category({
    required String id,
    required String name,
    required String slug,
    String? icon,
    @Default(0) int sortOrder,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
