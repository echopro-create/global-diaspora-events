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

 String get id; String get title; String get description; String get categoryId; DateTime get dateStart; DateTime? get dateEnd; String get venueName; String? get venueAddress; double? get latitude; double? get longitude; String? get imageUrl; String? get buyLink; bool get isPromoted; String? get externalId; String? get source; int get participantsCount; List<String> get tags; String? get createdBy; DateTime get createdAt;
/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventCopyWith<Event> get copyWith => _$EventCopyWithImpl<Event>(this as Event, _$identity);

  /// Serializes this Event to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Event&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.dateStart, dateStart) || other.dateStart == dateStart)&&(identical(other.dateEnd, dateEnd) || other.dateEnd == dateEnd)&&(identical(other.venueName, venueName) || other.venueName == venueName)&&(identical(other.venueAddress, venueAddress) || other.venueAddress == venueAddress)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.buyLink, buyLink) || other.buyLink == buyLink)&&(identical(other.isPromoted, isPromoted) || other.isPromoted == isPromoted)&&(identical(other.externalId, externalId) || other.externalId == externalId)&&(identical(other.source, source) || other.source == source)&&(identical(other.participantsCount, participantsCount) || other.participantsCount == participantsCount)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,categoryId,dateStart,dateEnd,venueName,venueAddress,latitude,longitude,imageUrl,buyLink,isPromoted,externalId,source,participantsCount,const DeepCollectionEquality().hash(tags),createdBy,createdAt]);

@override
String toString() {
  return 'Event(id: $id, title: $title, description: $description, categoryId: $categoryId, dateStart: $dateStart, dateEnd: $dateEnd, venueName: $venueName, venueAddress: $venueAddress, latitude: $latitude, longitude: $longitude, imageUrl: $imageUrl, buyLink: $buyLink, isPromoted: $isPromoted, externalId: $externalId, source: $source, participantsCount: $participantsCount, tags: $tags, createdBy: $createdBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $EventCopyWith<$Res>  {
  factory $EventCopyWith(Event value, $Res Function(Event) _then) = _$EventCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String categoryId, DateTime dateStart, DateTime? dateEnd, String venueName, String? venueAddress, double? latitude, double? longitude, String? imageUrl, String? buyLink, bool isPromoted, String? externalId, String? source, int participantsCount, List<String> tags, String? createdBy, DateTime createdAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? categoryId = null,Object? dateStart = null,Object? dateEnd = freezed,Object? venueName = null,Object? venueAddress = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? imageUrl = freezed,Object? buyLink = freezed,Object? isPromoted = null,Object? externalId = freezed,Object? source = freezed,Object? participantsCount = null,Object? tags = null,Object? createdBy = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,dateStart: null == dateStart ? _self.dateStart : dateStart // ignore: cast_nullable_to_non_nullable
as DateTime,dateEnd: freezed == dateEnd ? _self.dateEnd : dateEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,venueName: null == venueName ? _self.venueName : venueName // ignore: cast_nullable_to_non_nullable
as String,venueAddress: freezed == venueAddress ? _self.venueAddress : venueAddress // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,buyLink: freezed == buyLink ? _self.buyLink : buyLink // ignore: cast_nullable_to_non_nullable
as String?,isPromoted: null == isPromoted ? _self.isPromoted : isPromoted // ignore: cast_nullable_to_non_nullable
as bool,externalId: freezed == externalId ? _self.externalId : externalId // ignore: cast_nullable_to_non_nullable
as String?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,participantsCount: null == participantsCount ? _self.participantsCount : participantsCount // ignore: cast_nullable_to_non_nullable
as int,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String categoryId,  DateTime dateStart,  DateTime? dateEnd,  String venueName,  String? venueAddress,  double? latitude,  double? longitude,  String? imageUrl,  String? buyLink,  bool isPromoted,  String? externalId,  String? source,  int participantsCount,  List<String> tags,  String? createdBy,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.categoryId,_that.dateStart,_that.dateEnd,_that.venueName,_that.venueAddress,_that.latitude,_that.longitude,_that.imageUrl,_that.buyLink,_that.isPromoted,_that.externalId,_that.source,_that.participantsCount,_that.tags,_that.createdBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String categoryId,  DateTime dateStart,  DateTime? dateEnd,  String venueName,  String? venueAddress,  double? latitude,  double? longitude,  String? imageUrl,  String? buyLink,  bool isPromoted,  String? externalId,  String? source,  int participantsCount,  List<String> tags,  String? createdBy,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Event():
return $default(_that.id,_that.title,_that.description,_that.categoryId,_that.dateStart,_that.dateEnd,_that.venueName,_that.venueAddress,_that.latitude,_that.longitude,_that.imageUrl,_that.buyLink,_that.isPromoted,_that.externalId,_that.source,_that.participantsCount,_that.tags,_that.createdBy,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  String categoryId,  DateTime dateStart,  DateTime? dateEnd,  String venueName,  String? venueAddress,  double? latitude,  double? longitude,  String? imageUrl,  String? buyLink,  bool isPromoted,  String? externalId,  String? source,  int participantsCount,  List<String> tags,  String? createdBy,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Event() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.categoryId,_that.dateStart,_that.dateEnd,_that.venueName,_that.venueAddress,_that.latitude,_that.longitude,_that.imageUrl,_that.buyLink,_that.isPromoted,_that.externalId,_that.source,_that.participantsCount,_that.tags,_that.createdBy,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Event implements Event {
  const _Event({required this.id, required this.title, this.description = '', required this.categoryId, required this.dateStart, this.dateEnd, this.venueName = '', this.venueAddress, this.latitude, this.longitude, this.imageUrl, this.buyLink, this.isPromoted = false, this.externalId, this.source, this.participantsCount = 0, final  List<String> tags = const [], this.createdBy, required this.createdAt}): _tags = tags;
  factory _Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

@override final  String id;
@override final  String title;
@override@JsonKey() final  String description;
@override final  String categoryId;
@override final  DateTime dateStart;
@override final  DateTime? dateEnd;
@override@JsonKey() final  String venueName;
@override final  String? venueAddress;
@override final  double? latitude;
@override final  double? longitude;
@override final  String? imageUrl;
@override final  String? buyLink;
@override@JsonKey() final  bool isPromoted;
@override final  String? externalId;
@override final  String? source;
@override@JsonKey() final  int participantsCount;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  String? createdBy;
@override final  DateTime createdAt;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Event&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.dateStart, dateStart) || other.dateStart == dateStart)&&(identical(other.dateEnd, dateEnd) || other.dateEnd == dateEnd)&&(identical(other.venueName, venueName) || other.venueName == venueName)&&(identical(other.venueAddress, venueAddress) || other.venueAddress == venueAddress)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.buyLink, buyLink) || other.buyLink == buyLink)&&(identical(other.isPromoted, isPromoted) || other.isPromoted == isPromoted)&&(identical(other.externalId, externalId) || other.externalId == externalId)&&(identical(other.source, source) || other.source == source)&&(identical(other.participantsCount, participantsCount) || other.participantsCount == participantsCount)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,categoryId,dateStart,dateEnd,venueName,venueAddress,latitude,longitude,imageUrl,buyLink,isPromoted,externalId,source,participantsCount,const DeepCollectionEquality().hash(_tags),createdBy,createdAt]);

@override
String toString() {
  return 'Event(id: $id, title: $title, description: $description, categoryId: $categoryId, dateStart: $dateStart, dateEnd: $dateEnd, venueName: $venueName, venueAddress: $venueAddress, latitude: $latitude, longitude: $longitude, imageUrl: $imageUrl, buyLink: $buyLink, isPromoted: $isPromoted, externalId: $externalId, source: $source, participantsCount: $participantsCount, tags: $tags, createdBy: $createdBy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$EventCopyWith(_Event value, $Res Function(_Event) _then) = __$EventCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String categoryId, DateTime dateStart, DateTime? dateEnd, String venueName, String? venueAddress, double? latitude, double? longitude, String? imageUrl, String? buyLink, bool isPromoted, String? externalId, String? source, int participantsCount, List<String> tags, String? createdBy, DateTime createdAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? categoryId = null,Object? dateStart = null,Object? dateEnd = freezed,Object? venueName = null,Object? venueAddress = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? imageUrl = freezed,Object? buyLink = freezed,Object? isPromoted = null,Object? externalId = freezed,Object? source = freezed,Object? participantsCount = null,Object? tags = null,Object? createdBy = freezed,Object? createdAt = null,}) {
  return _then(_Event(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,dateStart: null == dateStart ? _self.dateStart : dateStart // ignore: cast_nullable_to_non_nullable
as DateTime,dateEnd: freezed == dateEnd ? _self.dateEnd : dateEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,venueName: null == venueName ? _self.venueName : venueName // ignore: cast_nullable_to_non_nullable
as String,venueAddress: freezed == venueAddress ? _self.venueAddress : venueAddress // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,buyLink: freezed == buyLink ? _self.buyLink : buyLink // ignore: cast_nullable_to_non_nullable
as String?,isPromoted: null == isPromoted ? _self.isPromoted : isPromoted // ignore: cast_nullable_to_non_nullable
as bool,externalId: freezed == externalId ? _self.externalId : externalId // ignore: cast_nullable_to_non_nullable
as String?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,participantsCount: null == participantsCount ? _self.participantsCount : participantsCount // ignore: cast_nullable_to_non_nullable
as int,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
