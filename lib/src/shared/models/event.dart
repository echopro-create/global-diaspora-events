import 'package:latlong2/latlong.dart';
import 'package:global_diaspora_events/src/shared/models/category.dart';
import 'package:global_diaspora_events/src/shared/models/tag.dart';

class Event {
  final String id;
  final String title;
  final String? description;
  final String categoryId;
  final Category? category;
  final List<Tag> tags;
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
    this.category,
    this.tags = const [],
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

    final categoryJson = json['categories'];
    final category = categoryJson != null
        ? Category.fromJson(categoryJson)
        : null;

    final tagsJson = json['event_tags'] as List?;
    final tags = tagsJson != null
        ? tagsJson.map((t) => Tag.fromJson(t['tags'])).toList()
        : <Tag>[];

    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      categoryId: json['category_id'].toString(),
      category: category,
      tags: tags,
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
