import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  const factory Comment({
    required String id,
    @JsonKey(name: 'event_id') required String eventId,
    @JsonKey(name: 'profile_id') required String profileId,
    required String text,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    // Optional: Include author details if joined
    @JsonKey(name: 'author_name') String? authorName,
    @JsonKey(name: 'author_avatar') String? authorAvatar,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
