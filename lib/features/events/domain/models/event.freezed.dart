// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Event {

 String get id; String get title; String? get description;@JsonKey(name: 'category_id') String get categoryId;@JsonKey(name: 'organizer_id') String get organizerId;@JsonKey(name: 'date_start') DateTime get dateStart;@JsonKey(name: 'date_end') DateTime? get dateEnd;@JsonKey(name: 'venue_name') String get venueName;@JsonKey(name: 'venue_address') String? get venueAddress;@JsonKey(name: 'image_url') String? get imageUrl;@JsonKey(name: 'buy_link') String? get buyLink;@JsonKey(name: 'participants_count') int get participantsCount;@JsonKey(name: 'external_id') String? get externalId; String? get source; double? get latitude; double? get longitude;@JsonKey(name: 'is_promoted') bool get isPromoted;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'is_attending') bool get isAttending;@JsonKey(name: 'is_favorite') bool get isFavorite;
/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventCopyWith<Event> get copyWith => _$EventCopyWithImpl<Event>(this as Event, _$identity);

  /// Serializes this Event to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Event&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.organizerId, organizerId) || other.organizerId == organizerId)&&(identical(other.dateStart, dateStart) || other.dateStart == dateStart)&&(identical(other.dateEnd, dateEnd) || other.dateEnd == dateEnd)&&(identical(other.venueName, venueName) || other.venueName == venueName)&&(identical(other.venueAddress, venueAddress) || other.venueAddress == venueAddress)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.buyLink, buyLink) || other.buyLink == buyLink)&&(identical(other.participantsCount, participantsCount) || other.participantsCount == participantsCount)&&(identical(other.externalId, externalId) || other.externalId == externalId)&&(identical(other.source, source) || other.source == source)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isPromoted, isPromoted) || other.isPromoted == isPromoted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isAttending, isAttending) || other.isAttending == isAttending)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,categoryId,organizerId,dateStart,dateEnd,venueName,venueAddress,imageUrl,buyLink,participantsCount,externalId,source,latitude,longitude,isPromoted,createdAt,isAttending,isFavorite]);

@override
String toString() {
  return 'Event(id: $id, title: $title, description: $description, categoryId: $categoryId, organizerId: $organizerId, dateStart: $dateStart, dateEnd: $dateEnd, venueName: $venueName, venueAddress: $venueAddress, imageUrl: $imageUrl, buyLink: $buyLink, participantsCount: $participantsCount, externalId: $externalId, source: $source, latitude: $latitude, longitude: $longitude, isPromoted: $isPromoted, createdAt: $createdAt, isAttending: $isAttending, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class $EventCopyWith<$Res>  {
  factory $EventCopyWith(Event value, $Res Function(Event) _then) = _$EventCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? description,@JsonKey(name: 'category_id') String categoryId,@JsonKey(name: 'organizer_id') String organizerId,@JsonKey(name: 'date_start') DateTime dateStart,@JsonKey(name: 'date_end') DateTime? dateEnd,@JsonKey(name: 'venue_name') String venueName,@JsonKey(name: 'venue_address') String? venueAddress,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'buy_link') String? buyLink,@JsonKey(name: 'participants_count') int participantsCount,@JsonKey(name: 'external_id') String? externalId, String? source, double? latitude, double? longitude,@JsonKey(name: 'is_promoted') bool isPromoted,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'is_attending') bool isAttending,@JsonKey(name: 'is_favorite') bool isFavorite
});




}
/// @nodoc
class _$EventCopyWithImpl<$Res>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._self, this._then);

  final Event _self;
  final $Res Function(Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? categoryId = null,Object? organizerId = null,Object? dateStart = null,Object? dateEnd = freezed,Object? venueName = null,Object? venueAddress = freezed,Object? imageUrl = freezed,Object? buyLink = freezed,Object? participantsCount = null,Object? externalId = freezed,Object? source = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? isPromoted = null,Object? createdAt = freezed,Object? isAttending = null,Object? isFavorite = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,organizerId: null == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as String,dateStart: null == dateStart ? _self.dateStart : dateStart // ignore: cast_nullable_to_non_nullable
as DateTime,dateEnd: freezed == dateEnd ? _self.dateEnd : dateEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,venueName: null == venueName ? _self.venueName : venueName // ignore: cast_nullable_to_non_nullable
as String,venueAddress: freezed == venueAddress ? _self.venueAddress : venueAddress // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,buyLink: freezed == buyLink ? _self.buyLink : buyLink // ignore: cast_nullable_to_non_nullable
as String?,participantsCount: null == participantsCount ? _self.participantsCount : participantsCount // ignore: cast_nullable_to_non_nullable
as int,externalId: freezed == externalId ? _self.externalId : externalId // ignore: cast_nullable_to_non_nullable
as String?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,isPromoted: null == isPromoted ? _self.isPromoted : isPromoted // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isAttending: null == isAttending ? _self.isAttending : isAttending // ignore: cast_nullable_to_non_nullable
as bool,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Event].
extension EventPatterns on Event {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Event value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Event value)  $default,){
final _that = this;
switch (_that) {
case _Event():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Event value)?  $default,){
final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? description, @JsonKey(name: 'category_id')  String categoryId, @JsonKey(name: 'organizer_id')  String organizerId, @JsonKey(name: 'date_start')  DateTime dateStart, @JsonKey(name: 'date_end')  DateTime? dateEnd, @JsonKey(name: 'venue_name')  String venueName, @JsonKey(name: 'venue_address')  String? venueAddress, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'buy_link')  String? buyLink, @JsonKey(name: 'participants_count')  int participantsCount, @JsonKey(name: 'external_id')  String? externalId,  String? source,  double? latitude,  double? longitude, @JsonKey(name: 'is_promoted')  bool isPromoted, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'is_attending')  bool isAttending, @JsonKey(name: 'is_favorite')  bool isFavorite)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.categoryId,_that.organizerId,_that.dateStart,_that.dateEnd,_that.venueName,_that.venueAddress,_that.imageUrl,_that.buyLink,_that.participantsCount,_that.externalId,_that.source,_that.latitude,_that.longitude,_that.isPromoted,_that.createdAt,_that.isAttending,_that.isFavorite);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? description, @JsonKey(name: 'category_id')  String categoryId, @JsonKey(name: 'organizer_id')  String organizerId, @JsonKey(name: 'date_start')  DateTime dateStart, @JsonKey(name: 'date_end')  DateTime? dateEnd, @JsonKey(name: 'venue_name')  String venueName, @JsonKey(name: 'venue_address')  String? venueAddress, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'buy_link')  String? buyLink, @JsonKey(name: 'participants_count')  int participantsCount, @JsonKey(name: 'external_id')  String? externalId,  String? source,  double? latitude,  double? longitude, @JsonKey(name: 'is_promoted')  bool isPromoted, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'is_attending')  bool isAttending, @JsonKey(name: 'is_favorite')  bool isFavorite)  $default,) {final _that = this;
switch (_that) {
case _Event():
return $default(_that.id,_that.title,_that.description,_that.categoryId,_that.organizerId,_that.dateStart,_that.dateEnd,_that.venueName,_that.venueAddress,_that.imageUrl,_that.buyLink,_that.participantsCount,_that.externalId,_that.source,_that.latitude,_that.longitude,_that.isPromoted,_that.createdAt,_that.isAttending,_that.isFavorite);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? description, @JsonKey(name: 'category_id')  String categoryId, @JsonKey(name: 'organizer_id')  String organizerId, @JsonKey(name: 'date_start')  DateTime dateStart, @JsonKey(name: 'date_end')  DateTime? dateEnd, @JsonKey(name: 'venue_name')  String venueName, @JsonKey(name: 'venue_address')  String? venueAddress, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'buy_link')  String? buyLink, @JsonKey(name: 'participants_count')  int participantsCount, @JsonKey(name: 'external_id')  String? externalId,  String? source,  double? latitude,  double? longitude, @JsonKey(name: 'is_promoted')  bool isPromoted, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'is_attending')  bool isAttending, @JsonKey(name: 'is_favorite')  bool isFavorite)?  $default,) {final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.categoryId,_that.organizerId,_that.dateStart,_that.dateEnd,_that.venueName,_that.venueAddress,_that.imageUrl,_that.buyLink,_that.participantsCount,_that.externalId,_that.source,_that.latitude,_that.longitude,_that.isPromoted,_that.createdAt,_that.isAttending,_that.isFavorite);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Event implements Event {
  const _Event({required this.id, required this.title, this.description, @JsonKey(name: 'category_id') required this.categoryId, @JsonKey(name: 'organizer_id') required this.organizerId, @JsonKey(name: 'date_start') required this.dateStart, @JsonKey(name: 'date_end') this.dateEnd, @JsonKey(name: 'venue_name') required this.venueName, @JsonKey(name: 'venue_address') this.venueAddress, @JsonKey(name: 'image_url') this.imageUrl, @JsonKey(name: 'buy_link') this.buyLink, @JsonKey(name: 'participants_count') this.participantsCount = 0, @JsonKey(name: 'external_id') this.externalId, this.source, this.latitude, this.longitude, @JsonKey(name: 'is_promoted') this.isPromoted = false, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'is_attending') this.isAttending = false, @JsonKey(name: 'is_favorite') this.isFavorite = false});
  factory _Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? description;
@override@JsonKey(name: 'category_id') final  String categoryId;
@override@JsonKey(name: 'organizer_id') final  String organizerId;
@override@JsonKey(name: 'date_start') final  DateTime dateStart;
@override@JsonKey(name: 'date_end') final  DateTime? dateEnd;
@override@JsonKey(name: 'venue_name') final  String venueName;
@override@JsonKey(name: 'venue_address') final  String? venueAddress;
@override@JsonKey(name: 'image_url') final  String? imageUrl;
@override@JsonKey(name: 'buy_link') final  String? buyLink;
@override@JsonKey(name: 'participants_count') final  int participantsCount;
@override@JsonKey(name: 'external_id') final  String? externalId;
@override final  String? source;
@override final  double? latitude;
@override final  double? longitude;
@override@JsonKey(name: 'is_promoted') final  bool isPromoted;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'is_attending') final  bool isAttending;
@override@JsonKey(name: 'is_favorite') final  bool isFavorite;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventCopyWith<_Event> get copyWith => __$EventCopyWithImpl<_Event>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Event&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.organizerId, organizerId) || other.organizerId == organizerId)&&(identical(other.dateStart, dateStart) || other.dateStart == dateStart)&&(identical(other.dateEnd, dateEnd) || other.dateEnd == dateEnd)&&(identical(other.venueName, venueName) || other.venueName == venueName)&&(identical(other.venueAddress, venueAddress) || other.venueAddress == venueAddress)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.buyLink, buyLink) || other.buyLink == buyLink)&&(identical(other.participantsCount, participantsCount) || other.participantsCount == participantsCount)&&(identical(other.externalId, externalId) || other.externalId == externalId)&&(identical(other.source, source) || other.source == source)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isPromoted, isPromoted) || other.isPromoted == isPromoted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isAttending, isAttending) || other.isAttending == isAttending)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,categoryId,organizerId,dateStart,dateEnd,venueName,venueAddress,imageUrl,buyLink,participantsCount,externalId,source,latitude,longitude,isPromoted,createdAt,isAttending,isFavorite]);

@override
String toString() {
  return 'Event(id: $id, title: $title, description: $description, categoryId: $categoryId, organizerId: $organizerId, dateStart: $dateStart, dateEnd: $dateEnd, venueName: $venueName, venueAddress: $venueAddress, imageUrl: $imageUrl, buyLink: $buyLink, participantsCount: $participantsCount, externalId: $externalId, source: $source, latitude: $latitude, longitude: $longitude, isPromoted: $isPromoted, createdAt: $createdAt, isAttending: $isAttending, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class _$EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$EventCopyWith(_Event value, $Res Function(_Event) _then) = __$EventCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? description,@JsonKey(name: 'category_id') String categoryId,@JsonKey(name: 'organizer_id') String organizerId,@JsonKey(name: 'date_start') DateTime dateStart,@JsonKey(name: 'date_end') DateTime? dateEnd,@JsonKey(name: 'venue_name') String venueName,@JsonKey(name: 'venue_address') String? venueAddress,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'buy_link') String? buyLink,@JsonKey(name: 'participants_count') int participantsCount,@JsonKey(name: 'external_id') String? externalId, String? source, double? latitude, double? longitude,@JsonKey(name: 'is_promoted') bool isPromoted,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'is_attending') bool isAttending,@JsonKey(name: 'is_favorite') bool isFavorite
});




}
/// @nodoc
class __$EventCopyWithImpl<$Res>
    implements _$EventCopyWith<$Res> {
  __$EventCopyWithImpl(this._self, this._then);

  final _Event _self;
  final $Res Function(_Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? categoryId = null,Object? organizerId = null,Object? dateStart = null,Object? dateEnd = freezed,Object? venueName = null,Object? venueAddress = freezed,Object? imageUrl = freezed,Object? buyLink = freezed,Object? participantsCount = null,Object? externalId = freezed,Object? source = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? isPromoted = null,Object? createdAt = freezed,Object? isAttending = null,Object? isFavorite = null,}) {
  return _then(_Event(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,organizerId: null == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as String,dateStart: null == dateStart ? _self.dateStart : dateStart // ignore: cast_nullable_to_non_nullable
as DateTime,dateEnd: freezed == dateEnd ? _self.dateEnd : dateEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,venueName: null == venueName ? _self.venueName : venueName // ignore: cast_nullable_to_non_nullable
as String,venueAddress: freezed == venueAddress ? _self.venueAddress : venueAddress // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,buyLink: freezed == buyLink ? _self.buyLink : buyLink // ignore: cast_nullable_to_non_nullable
as String?,participantsCount: null == participantsCount ? _self.participantsCount : participantsCount // ignore: cast_nullable_to_non_nullable
as int,externalId: freezed == externalId ? _self.externalId : externalId // ignore: cast_nullable_to_non_nullable
as String?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,isPromoted: null == isPromoted ? _self.isPromoted : isPromoted // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isAttending: null == isAttending ? _self.isAttending : isAttending // ignore: cast_nullable_to_non_nullable
as bool,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
