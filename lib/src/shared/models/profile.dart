import 'package:latlong2/latlong.dart';

class Profile {
  final String id;
  final String? fullName;
  final LatLng? currentLocation;
  final String? originCountry;
  final bool spotifyConnected;
  final String? avatarUrl;
  final DateTime createdAt;

  Profile({
    required this.id,
    this.fullName,
    this.currentLocation,
    this.originCountry,
    this.spotifyConnected = false,
    this.avatarUrl,
    required this.createdAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      fullName: json['full_name'],
      originCountry: json['origin_country'],
      spotifyConnected: json['spotify_connected'] ?? false,
      avatarUrl: json['avatar_url'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'origin_country': originCountry,
      'spotify_connected': spotifyConnected,
      'avatar_url': avatarUrl,
    };
  }
}
