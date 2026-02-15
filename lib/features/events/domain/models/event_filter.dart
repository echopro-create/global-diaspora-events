import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_filter.freezed.dart';
part 'event_filter.g.dart';

@freezed
class EventFilter with _$EventFilter {
  const factory EventFilter({
    String? categoryId,
    DateTime? date,
    String? city,
  }) = _EventFilter;

  factory EventFilter.fromJson(Map<String, dynamic> json) =>
      _$EventFilterFromJson(json);
}
