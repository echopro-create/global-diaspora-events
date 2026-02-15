// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Comment _$CommentFromJson(Map<String, dynamic> json) => _Comment(
  id: json['id'] as String,
  eventId: json['event_id'] as String,
  profileId: json['profile_id'] as String,
  text: json['text'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  authorName: json['author_name'] as String?,
  authorAvatar: json['author_avatar'] as String?,
);

Map<String, dynamic> _$CommentToJson(_Comment instance) => <String, dynamic>{
  'id': instance.id,
  'event_id': instance.eventId,
  'profile_id': instance.profileId,
  'text': instance.text,
  'created_at': instance.createdAt.toIso8601String(),
  'author_name': instance.authorName,
  'author_avatar': instance.authorAvatar,
};
