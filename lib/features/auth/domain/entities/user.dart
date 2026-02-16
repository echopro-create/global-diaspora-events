import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// User entity representing an authenticated user.
@freezed
abstract class User with _$User {
  const factory User({
    /// Unique user ID (from Supabase Auth).
    required String id,

    /// User email address.
    required String email,

    /// Full name (optional).
    String? fullName,

    /// Avatar URL (from Supabase Storage).
    String? avatarUrl,

    /// Country code (ISO 3166-1 alpha-2, e.g., "UA", "RU").
    String? countryCode,

    /// City of residence.
    @Default('Paris') String city,

    /// List of user interests/categories.
    @Default([]) List<String> interests,

    /// Account creation timestamp.
    DateTime? createdAt,

    /// Last updated timestamp.
    DateTime? updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
