import 'package:latlong2/latlong.dart';

class Event {
  final String id;
  final String title;
  final String? description;
  final String categoryId;
  final DateTime startTime;
  final LatLng? location;
  final String? address;
  final String? imageUrl;
  final String? buyLink;
  final bool isPromoted;
  final int participantsCount;
  final bool isUserJoined;

  Event({
    required this.id,
    required this.title,
    this.description,
    required this.categoryId,
    required this.startTime,
    this.location,
    this.address,
    this.imageUrl,
    this.buyLink,
    this.isPromoted = false,
    this.participantsCount = 0,
    this.isUserJoined = false,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    LatLng? loc;
    final geo = json['location'];
    if (geo != null && geo is Map) {
      final coords = geo['coordinates'] as List;
      loc = LatLng(coords[1].toDouble(), coords[0].toDouble());
    }

    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      categoryId: json['category_id'].toString(),
      startTime: DateTime.parse(json['start_time']),
      location: loc,
      address: json['address'],
      imageUrl: json['image_url'],
      buyLink: json['buy_link'],
      isPromoted: json['is_promoted'] ?? false,
      participantsCount: json['participants_count'] ?? 0,
      isUserJoined: json['is_user_joined'] ?? false,
    );
  }
}
