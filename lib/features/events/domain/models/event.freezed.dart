// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Event _$EventFromJson(Map<String, dynamic> json) {
  return _Event.fromJson(json);
}

/// @nodoc
mixin _$Event {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  String get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_start')
  DateTime get dateStart => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_end')
  DateTime? get dateEnd => throw _privateConstructorUsedError;
  @JsonKey(name: 'venue_name')
  String get venueName => throw _privateConstructorUsedError;
  @JsonKey(name: 'venue_address')
  String? get venueAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'buy_link')
  String? get buyLink => throw _privateConstructorUsedError;
  @JsonKey(name: 'participants_count')
  int get participantsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'external_id')
  String? get externalId => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_promoted')
  bool get isPromoted => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Event to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventCopyWith<Event> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) then) =
      _$EventCopyWithImpl<$Res, Event>;
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    @JsonKey(name: 'category_id') String categoryId,
    @JsonKey(name: 'date_start') DateTime dateStart,
    @JsonKey(name: 'date_end') DateTime? dateEnd,
    @JsonKey(name: 'venue_name') String venueName,
    @JsonKey(name: 'venue_address') String? venueAddress,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'buy_link') String? buyLink,
    @JsonKey(name: 'participants_count') int participantsCount,
    @JsonKey(name: 'external_id') String? externalId,
    String? source,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'is_promoted') bool isPromoted,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class _$EventCopyWithImpl<$Res, $Val extends Event>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? categoryId = null,
    Object? dateStart = null,
    Object? dateEnd = freezed,
    Object? venueName = null,
    Object? venueAddress = freezed,
    Object? imageUrl = freezed,
    Object? buyLink = freezed,
    Object? participantsCount = null,
    Object? externalId = freezed,
    Object? source = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? isPromoted = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String,
            dateStart: null == dateStart
                ? _value.dateStart
                : dateStart // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            dateEnd: freezed == dateEnd
                ? _value.dateEnd
                : dateEnd // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            venueName: null == venueName
                ? _value.venueName
                : venueName // ignore: cast_nullable_to_non_nullable
                      as String,
            venueAddress: freezed == venueAddress
                ? _value.venueAddress
                : venueAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            buyLink: freezed == buyLink
                ? _value.buyLink
                : buyLink // ignore: cast_nullable_to_non_nullable
                      as String?,
            participantsCount: null == participantsCount
                ? _value.participantsCount
                : participantsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            externalId: freezed == externalId
                ? _value.externalId
                : externalId // ignore: cast_nullable_to_non_nullable
                      as String?,
            source: freezed == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String?,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            isPromoted: null == isPromoted
                ? _value.isPromoted
                : isPromoted // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EventImplCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$$EventImplCopyWith(
    _$EventImpl value,
    $Res Function(_$EventImpl) then,
  ) = __$$EventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    @JsonKey(name: 'category_id') String categoryId,
    @JsonKey(name: 'date_start') DateTime dateStart,
    @JsonKey(name: 'date_end') DateTime? dateEnd,
    @JsonKey(name: 'venue_name') String venueName,
    @JsonKey(name: 'venue_address') String? venueAddress,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'buy_link') String? buyLink,
    @JsonKey(name: 'participants_count') int participantsCount,
    @JsonKey(name: 'external_id') String? externalId,
    String? source,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'is_promoted') bool isPromoted,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class __$$EventImplCopyWithImpl<$Res>
    extends _$EventCopyWithImpl<$Res, _$EventImpl>
    implements _$$EventImplCopyWith<$Res> {
  __$$EventImplCopyWithImpl(
    _$EventImpl _value,
    $Res Function(_$EventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? categoryId = null,
    Object? dateStart = null,
    Object? dateEnd = freezed,
    Object? venueName = null,
    Object? venueAddress = freezed,
    Object? imageUrl = freezed,
    Object? buyLink = freezed,
    Object? participantsCount = null,
    Object? externalId = freezed,
    Object? source = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? isPromoted = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$EventImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String,
        dateStart: null == dateStart
            ? _value.dateStart
            : dateStart // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        dateEnd: freezed == dateEnd
            ? _value.dateEnd
            : dateEnd // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        venueName: null == venueName
            ? _value.venueName
            : venueName // ignore: cast_nullable_to_non_nullable
                  as String,
        venueAddress: freezed == venueAddress
            ? _value.venueAddress
            : venueAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        buyLink: freezed == buyLink
            ? _value.buyLink
            : buyLink // ignore: cast_nullable_to_non_nullable
                  as String?,
        participantsCount: null == participantsCount
            ? _value.participantsCount
            : participantsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        externalId: freezed == externalId
            ? _value.externalId
            : externalId // ignore: cast_nullable_to_non_nullable
                  as String?,
        source: freezed == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String?,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        isPromoted: null == isPromoted
            ? _value.isPromoted
            : isPromoted // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EventImpl implements _Event {
  const _$EventImpl({
    required this.id,
    required this.title,
    this.description,
    @JsonKey(name: 'category_id') required this.categoryId,
    @JsonKey(name: 'date_start') required this.dateStart,
    @JsonKey(name: 'date_end') this.dateEnd,
    @JsonKey(name: 'venue_name') required this.venueName,
    @JsonKey(name: 'venue_address') this.venueAddress,
    @JsonKey(name: 'image_url') this.imageUrl,
    @JsonKey(name: 'buy_link') this.buyLink,
    @JsonKey(name: 'participants_count') this.participantsCount = 0,
    @JsonKey(name: 'external_id') this.externalId,
    this.source,
    this.latitude,
    this.longitude,
    @JsonKey(name: 'is_promoted') this.isPromoted = false,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$EventImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  @override
  @JsonKey(name: 'category_id')
  final String categoryId;
  @override
  @JsonKey(name: 'date_start')
  final DateTime dateStart;
  @override
  @JsonKey(name: 'date_end')
  final DateTime? dateEnd;
  @override
  @JsonKey(name: 'venue_name')
  final String venueName;
  @override
  @JsonKey(name: 'venue_address')
  final String? venueAddress;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey(name: 'buy_link')
  final String? buyLink;
  @override
  @JsonKey(name: 'participants_count')
  final int participantsCount;
  @override
  @JsonKey(name: 'external_id')
  final String? externalId;
  @override
  final String? source;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @JsonKey(name: 'is_promoted')
  final bool isPromoted;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Event(id: $id, title: $title, description: $description, categoryId: $categoryId, dateStart: $dateStart, dateEnd: $dateEnd, venueName: $venueName, venueAddress: $venueAddress, imageUrl: $imageUrl, buyLink: $buyLink, participantsCount: $participantsCount, externalId: $externalId, source: $source, latitude: $latitude, longitude: $longitude, isPromoted: $isPromoted, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.dateStart, dateStart) ||
                other.dateStart == dateStart) &&
            (identical(other.dateEnd, dateEnd) || other.dateEnd == dateEnd) &&
            (identical(other.venueName, venueName) ||
                other.venueName == venueName) &&
            (identical(other.venueAddress, venueAddress) ||
                other.venueAddress == venueAddress) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.buyLink, buyLink) || other.buyLink == buyLink) &&
            (identical(other.participantsCount, participantsCount) ||
                other.participantsCount == participantsCount) &&
            (identical(other.externalId, externalId) ||
                other.externalId == externalId) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.isPromoted, isPromoted) ||
                other.isPromoted == isPromoted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    categoryId,
    dateStart,
    dateEnd,
    venueName,
    venueAddress,
    imageUrl,
    buyLink,
    participantsCount,
    externalId,
    source,
    latitude,
    longitude,
    isPromoted,
    createdAt,
  );

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      __$$EventImplCopyWithImpl<_$EventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventImplToJson(this);
  }
}

abstract class _Event implements Event {
  const factory _Event({
    required final String id,
    required final String title,
    final String? description,
    @JsonKey(name: 'category_id') required final String categoryId,
    @JsonKey(name: 'date_start') required final DateTime dateStart,
    @JsonKey(name: 'date_end') final DateTime? dateEnd,
    @JsonKey(name: 'venue_name') required final String venueName,
    @JsonKey(name: 'venue_address') final String? venueAddress,
    @JsonKey(name: 'image_url') final String? imageUrl,
    @JsonKey(name: 'buy_link') final String? buyLink,
    @JsonKey(name: 'participants_count') final int participantsCount,
    @JsonKey(name: 'external_id') final String? externalId,
    final String? source,
    final double? latitude,
    final double? longitude,
    @JsonKey(name: 'is_promoted') final bool isPromoted,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$EventImpl;

  factory _Event.fromJson(Map<String, dynamic> json) = _$EventImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  @JsonKey(name: 'category_id')
  String get categoryId;
  @override
  @JsonKey(name: 'date_start')
  DateTime get dateStart;
  @override
  @JsonKey(name: 'date_end')
  DateTime? get dateEnd;
  @override
  @JsonKey(name: 'venue_name')
  String get venueName;
  @override
  @JsonKey(name: 'venue_address')
  String? get venueAddress;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(name: 'buy_link')
  String? get buyLink;
  @override
  @JsonKey(name: 'participants_count')
  int get participantsCount;
  @override
  @JsonKey(name: 'external_id')
  String? get externalId;
  @override
  String? get source;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  @JsonKey(name: 'is_promoted')
  bool get isPromoted;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
