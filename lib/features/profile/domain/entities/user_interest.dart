import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_interest.freezed.dart';
part 'user_interest.g.dart';

/// Модель интереса пользователя.
@freezed
abstract class UserInterest with _$UserInterest {
  const factory UserInterest({
    required String id,
    required String profileId,
    required String interestType,
    required String value,
    @Default(1.0) double weight,
    required DateTime createdAt,
  }) = _UserInterest;

  factory UserInterest.fromJson(Map<String, dynamic> json) =>
      _$UserInterestFromJson(json);
}
