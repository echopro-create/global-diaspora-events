// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_interest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserInterest _$UserInterestFromJson(Map<String, dynamic> json) =>
    _UserInterest(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$UserInterestToJson(_UserInterest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'isSelected': instance.isSelected,
    };
