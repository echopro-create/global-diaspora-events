import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@freezed
abstract class Event with _$Event {
  const factory Event({
    required String id,
    required String title,
    String? description,
    @JsonKey(name: 'category_id') required String categoryId,
    @JsonKey(name: 'organizer_id') required String organizerId,
    @JsonKey(name: 'date_start') required DateTime dateStart,
    @JsonKey(name: 'date_end') DateTime? dateEnd,
    @JsonKey(name: 'venue_name') required String venueName,
    @JsonKey(name: 'venue_address') String? venueAddress,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'buy_link') String? buyLink,
    @JsonKey(name: 'participants_count') @Default(0) int participantsCount,
    @JsonKey(name: 'external_id') String? externalId,
    String? source,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'is_promoted') @Default(false) bool isPromoted,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'is_attending') @Default(false) bool isAttending,
    @JsonKey(name: 'is_favorite') @Default(false) bool isFavorite,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
