// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  id: json['id'] as String,
  displayName: json['display_name'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  originCountry: json['origin_country'] as String?,
  currentCity: json['current_city'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'display_name': instance.displayName,
      'avatar_url': instance.avatarUrl,
      'origin_country': instance.originCountry,
      'current_city': instance.currentCity,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'created_at': instance.createdAt.toIso8601String(),
    };
