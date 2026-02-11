// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_interest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserInterest _$UserInterestFromJson(Map<String, dynamic> json) =>
    _UserInterest(
      id: json['id'] as String,
      profileId: json['profile_id'] as String,
      interestType: json['interest_type'] as String,
      value: json['value'] as String,
      weight: (json['weight'] as num?)?.toDouble() ?? 1.0,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$UserInterestToJson(_UserInterest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profile_id': instance.profileId,
      'interest_type': instance.interestType,
      'value': instance.value,
      'weight': instance.weight,
      'created_at': instance.createdAt.toIso8601String(),
    };
