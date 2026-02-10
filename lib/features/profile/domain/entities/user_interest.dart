/// Модель интереса пользователя (artist, tag, category).
class UserInterest {
  final String id;
  final String profileId;
  final String interestType; // 'artist', 'tag', 'category'
  final String value;
  final double weight;
  final DateTime createdAt;

  const UserInterest({
    required this.id,
    required this.profileId,
    required this.interestType,
    required this.value,
    this.weight = 1.0,
    required this.createdAt,
  });

  factory UserInterest.fromJson(Map<String, dynamic> json) {
    return UserInterest(
      id: json['id'] as String,
      profileId: json['profile_id'] as String,
      interestType: json['interest_type'] as String,
      value: json['value'] as String,
      weight: (json['weight'] as num?)?.toDouble() ?? 1.0,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile_id': profileId,
      'interest_type': interestType,
      'value': value,
      'weight': weight,
    };
  }
}
