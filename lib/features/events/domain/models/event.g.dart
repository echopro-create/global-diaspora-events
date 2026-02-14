// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventImpl _$$EventImplFromJson(Map<String, dynamic> json) => _$EventImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  categoryId: json['category_id'] as String,
  dateStart: DateTime.parse(json['date_start'] as String),
  dateEnd: json['date_end'] == null
      ? null
      : DateTime.parse(json['date_end'] as String),
  venueName: json['venue_name'] as String,
  venueAddress: json['venue_address'] as String?,
  imageUrl: json['image_url'] as String?,
  buyLink: json['buy_link'] as String?,
  participantsCount: (json['participants_count'] as num?)?.toInt() ?? 0,
  externalId: json['external_id'] as String?,
  source: json['source'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  isPromoted: json['is_promoted'] as bool? ?? false,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$EventImplToJson(_$EventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category_id': instance.categoryId,
      'date_start': instance.dateStart.toIso8601String(),
      'date_end': instance.dateEnd?.toIso8601String(),
      'venue_name': instance.venueName,
      'venue_address': instance.venueAddress,
      'image_url': instance.imageUrl,
      'buy_link': instance.buyLink,
      'participants_count': instance.participantsCount,
      'external_id': instance.externalId,
      'source': instance.source,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'is_promoted': instance.isPromoted,
      'created_at': instance.createdAt?.toIso8601String(),
    };
