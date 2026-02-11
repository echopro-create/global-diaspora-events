// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_interest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserInterest {

 String get id; String get profileId; String get interestType; String get value; double get weight; DateTime get createdAt;
/// Create a copy of UserInterest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserInterestCopyWith<UserInterest> get copyWith => _$UserInterestCopyWithImpl<UserInterest>(this as UserInterest, _$identity);

  /// Serializes this UserInterest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserInterest&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.interestType, interestType) || other.interestType == interestType)&&(identical(other.value, value) || other.value == value)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,interestType,value,weight,createdAt);

@override
String toString() {
  return 'UserInterest(id: $id, profileId: $profileId, interestType: $interestType, value: $value, weight: $weight, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $UserInterestCopyWith<$Res>  {
  factory $UserInterestCopyWith(UserInterest value, $Res Function(UserInterest) _then) = _$UserInterestCopyWithImpl;
@useResult
$Res call({
 String id, String profileId, String interestType, String value, double weight, DateTime createdAt
});




}
/// @nodoc
class _$UserInterestCopyWithImpl<$Res>
    implements $UserInterestCopyWith<$Res> {
  _$UserInterestCopyWithImpl(this._self, this._then);

  final UserInterest _self;
  final $Res Function(UserInterest) _then;

/// Create a copy of UserInterest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? profileId = null,Object? interestType = null,Object? value = null,Object? weight = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,interestType: null == interestType ? _self.interestType : interestType // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [UserInterest].
extension UserInterestPatterns on UserInterest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserInterest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserInterest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserInterest value)  $default,){
final _that = this;
switch (_that) {
case _UserInterest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserInterest value)?  $default,){
final _that = this;
switch (_that) {
case _UserInterest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String profileId,  String interestType,  String value,  double weight,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserInterest() when $default != null:
return $default(_that.id,_that.profileId,_that.interestType,_that.value,_that.weight,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String profileId,  String interestType,  String value,  double weight,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _UserInterest():
return $default(_that.id,_that.profileId,_that.interestType,_that.value,_that.weight,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String profileId,  String interestType,  String value,  double weight,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _UserInterest() when $default != null:
return $default(_that.id,_that.profileId,_that.interestType,_that.value,_that.weight,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserInterest implements UserInterest {
  const _UserInterest({required this.id, required this.profileId, required this.interestType, required this.value, this.weight = 1.0, required this.createdAt});
  factory _UserInterest.fromJson(Map<String, dynamic> json) => _$UserInterestFromJson(json);

@override final  String id;
@override final  String profileId;
@override final  String interestType;
@override final  String value;
@override@JsonKey() final  double weight;
@override final  DateTime createdAt;

/// Create a copy of UserInterest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserInterestCopyWith<_UserInterest> get copyWith => __$UserInterestCopyWithImpl<_UserInterest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserInterestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserInterest&&(identical(other.id, id) || other.id == id)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.interestType, interestType) || other.interestType == interestType)&&(identical(other.value, value) || other.value == value)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,profileId,interestType,value,weight,createdAt);

@override
String toString() {
  return 'UserInterest(id: $id, profileId: $profileId, interestType: $interestType, value: $value, weight: $weight, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$UserInterestCopyWith<$Res> implements $UserInterestCopyWith<$Res> {
  factory _$UserInterestCopyWith(_UserInterest value, $Res Function(_UserInterest) _then) = __$UserInterestCopyWithImpl;
@override @useResult
$Res call({
 String id, String profileId, String interestType, String value, double weight, DateTime createdAt
});




}
/// @nodoc
class __$UserInterestCopyWithImpl<$Res>
    implements _$UserInterestCopyWith<$Res> {
  __$UserInterestCopyWithImpl(this._self, this._then);

  final _UserInterest _self;
  final $Res Function(_UserInterest) _then;

/// Create a copy of UserInterest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? profileId = null,Object? interestType = null,Object? value = null,Object? weight = null,Object? createdAt = null,}) {
  return _then(_UserInterest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,interestType: null == interestType ? _self.interestType : interestType // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
