// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Event _$EventFromJson(Map<String, dynamic> json) => _Event(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String? ?? '',
  categoryId: json['category_id'] as String,
  dateStart: DateTime.parse(json['date_start'] as String),
  dateEnd: json['date_end'] == null
      ? null
      : DateTime.parse(json['date_end'] as String),
  venueName: json['venue_name'] as String? ?? '',
  venueAddress: json['venue_address'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  imageUrl: json['image_url'] as String?,
  buyLink: json['buy_link'] as String?,
  isPromoted: json['is_promoted'] as bool? ?? false,
  externalId: json['external_id'] as String?,
  source: json['source'] as String?,
  participantsCount: (json['participants_count'] as num?)?.toInt() ?? 0,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  createdBy: json['created_by'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$EventToJson(_Event instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'category_id': instance.categoryId,
  'date_start': instance.dateStart.toIso8601String(),
  'date_end': instance.dateEnd?.toIso8601String(),
  'venue_name': instance.venueName,
  'venue_address': instance.venueAddress,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'image_url': instance.imageUrl,
  'buy_link': instance.buyLink,
  'is_promoted': instance.isPromoted,
  'external_id': instance.externalId,
  'source': instance.source,
  'participants_count': instance.participantsCount,
  'tags': instance.tags,
  'created_by': instance.createdBy,
  'created_at': instance.createdAt.toIso8601String(),
};
