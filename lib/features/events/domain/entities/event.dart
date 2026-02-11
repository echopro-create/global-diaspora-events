import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

/// Модель события.
@freezed
abstract class Event with _$Event {
  const factory Event({
    required String id,
    required String title,
    @Default('') String description,
    required String categoryId,
    required DateTime dateStart,
    DateTime? dateEnd,
    @Default('') String venueName,
    String? venueAddress,
    double? latitude,
    double? longitude,
    String? imageUrl,
    String? buyLink,
    @Default(false) bool isPromoted,
    String? externalId,
    String? source,
    @Default(0) int participantsCount,
    @Default([]) List<String> tags,
    String? createdBy,
    required DateTime createdAt,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
