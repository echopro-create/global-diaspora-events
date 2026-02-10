/// Модель профиля пользователя.
class UserProfile {
  final String id;
  final String? displayName;
  final String? avatarUrl;
  final String? originCountry;
  final String? currentCity;
  final double? latitude;
  final double? longitude;
  final DateTime createdAt;

  const UserProfile({
    required this.id,
    this.displayName,
    this.avatarUrl,
    this.originCountry,
    this.currentCity,
    this.latitude,
    this.longitude,
    required this.createdAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      displayName: json['display_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      originCountry: json['origin_country'] as String?,
      currentCity: json['current_city'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (displayName != null) 'display_name': displayName,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (originCountry != null) 'origin_country': originCountry,
      if (currentCity != null) 'current_city': currentCity,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    };
  }

  UserProfile copyWith({
    String? id,
    String? displayName,
    String? avatarUrl,
    String? originCountry,
    String? currentCity,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      originCountry: originCountry ?? this.originCountry,
      currentCity: currentCity ?? this.currentCity,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
