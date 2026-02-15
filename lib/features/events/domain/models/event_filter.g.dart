// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventFilter _$EventFilterFromJson(Map<String, dynamic> json) => _EventFilter(
  categoryId: json['categoryId'] as String?,
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  city: json['city'] as String?,
);

Map<String, dynamic> _$EventFilterToJson(_EventFilter instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'date': instance.date?.toIso8601String(),
      'city': instance.city,
    };
