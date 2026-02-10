/// Модель события.
class Event {
  final String id;
  final String title;
  final String description;
  final String categoryId;
  final DateTime dateStart;
  final DateTime? dateEnd;
  final String venueName;
  final String? venueAddress;
  final double? latitude;
  final double? longitude;
  final String? imageUrl;
  final String? buyLink;
  final bool isPromoted;
  final String? externalId;
  final String? source;
  final int participantsCount;
  final List<String> tags;
  final String? createdBy;
  final DateTime createdAt;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.dateStart,
    this.dateEnd,
    required this.venueName,
    this.venueAddress,
    this.latitude,
    this.longitude,
    this.imageUrl,
    this.buyLink,
    this.isPromoted = false,
    this.externalId,
    this.source,
    this.participantsCount = 0,
    this.tags = const [],
    this.createdBy,
    required this.createdAt,
  });

  /// Создание из JSON (Supabase row).
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      categoryId: json['category_id'] as String,
      dateStart: DateTime.parse(json['date_start'] as String),
      dateEnd: json['date_end'] != null
          ? DateTime.parse(json['date_end'] as String)
          : null,
      venueName: json['venue_name'] as String? ?? '',
      venueAddress: json['venue_address'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      imageUrl: json['image_url'] as String?,
      buyLink: json['buy_link'] as String?,
      isPromoted: json['is_promoted'] as bool? ?? false,
      externalId: json['external_id'] as String?,
      source: json['source'] as String?,
      participantsCount: json['participants_count'] as int? ?? 0,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
          const [],
      createdBy: json['created_by'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'category_id': categoryId,
      'date_start': dateStart.toIso8601String(),
      if (dateEnd != null) 'date_end': dateEnd!.toIso8601String(),
      'venue_name': venueName,
      if (venueAddress != null) 'venue_address': venueAddress,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (imageUrl != null) 'image_url': imageUrl,
      if (buyLink != null) 'buy_link': buyLink,
      'is_promoted': isPromoted,
      if (externalId != null) 'external_id': externalId,
      if (source != null) 'source': source,
    };
  }

  Event copyWith({
    String? id,
    String? title,
    String? description,
    String? categoryId,
    DateTime? dateStart,
    DateTime? dateEnd,
    String? venueName,
    String? venueAddress,
    double? latitude,
    double? longitude,
    String? imageUrl,
    String? buyLink,
    bool? isPromoted,
    String? externalId,
    String? source,
    int? participantsCount,
    List<String>? tags,
    String? createdBy,
    DateTime? createdAt,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      venueName: venueName ?? this.venueName,
      venueAddress: venueAddress ?? this.venueAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      imageUrl: imageUrl ?? this.imageUrl,
      buyLink: buyLink ?? this.buyLink,
      isPromoted: isPromoted ?? this.isPromoted,
      externalId: externalId ?? this.externalId,
      source: source ?? this.source,
      participantsCount: participantsCount ?? this.participantsCount,
      tags: tags ?? this.tags,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
