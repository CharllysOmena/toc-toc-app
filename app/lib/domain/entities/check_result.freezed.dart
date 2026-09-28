// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckResult {

 ChecklistItem get item; bool get detected; DateTime get timestamp; String? get photoPath;
/// Create a copy of CheckResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckResultCopyWith<CheckResult> get copyWith => _$CheckResultCopyWithImpl<CheckResult>(this as CheckResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckResult&&(identical(other.item, item) || other.item == item)&&(identical(other.detected, detected) || other.detected == detected)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath));
}


@override
int get hashCode => Object.hash(runtimeType,item,detected,timestamp,photoPath);

@override
String toString() {
  return 'CheckResult(item: $item, detected: $detected, timestamp: $timestamp, photoPath: $photoPath)';
}


}

/// @nodoc
abstract mixin class $CheckResultCopyWith<$Res>  {
  factory $CheckResultCopyWith(CheckResult value, $Res Function(CheckResult) _then) = _$CheckResultCopyWithImpl;
@useResult
$Res call({
 ChecklistItem item, bool detected, DateTime timestamp, String? photoPath
});


$ChecklistItemCopyWith<$Res> get item;

}
/// @nodoc
class _$CheckResultCopyWithImpl<$Res>
    implements $CheckResultCopyWith<$Res> {
  _$CheckResultCopyWithImpl(this._self, this._then);

  final CheckResult _self;
  final $Res Function(CheckResult) _then;

/// Create a copy of CheckResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? item = null,Object? detected = null,Object? timestamp = null,Object? photoPath = freezed,}) {
  return _then(_self.copyWith(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as ChecklistItem,detected: null == detected ? _self.detected : detected // ignore: cast_nullable_to_non_nullable
as bool,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CheckResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChecklistItemCopyWith<$Res> get item {
  
  return $ChecklistItemCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}


/// Adds pattern-matching-related methods to [CheckResult].
extension CheckResultPatterns on CheckResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckResult value)  $default,){
final _that = this;
switch (_that) {
case _CheckResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckResult value)?  $default,){
final _that = this;
switch (_that) {
case _CheckResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ChecklistItem item,  bool detected,  DateTime timestamp,  String? photoPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckResult() when $default != null:
return $default(_that.item,_that.detected,_that.timestamp,_that.photoPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ChecklistItem item,  bool detected,  DateTime timestamp,  String? photoPath)  $default,) {final _that = this;
switch (_that) {
case _CheckResult():
return $default(_that.item,_that.detected,_that.timestamp,_that.photoPath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ChecklistItem item,  bool detected,  DateTime timestamp,  String? photoPath)?  $default,) {final _that = this;
switch (_that) {
case _CheckResult() when $default != null:
return $default(_that.item,_that.detected,_that.timestamp,_that.photoPath);case _:
  return null;

}
}

}

/// @nodoc


class _CheckResult implements CheckResult {
  const _CheckResult({required this.item, required this.detected, required this.timestamp, this.photoPath});
  

@override final  ChecklistItem item;
@override final  bool detected;
@override final  DateTime timestamp;
@override final  String? photoPath;

/// Create a copy of CheckResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckResultCopyWith<_CheckResult> get copyWith => __$CheckResultCopyWithImpl<_CheckResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckResult&&(identical(other.item, item) || other.item == item)&&(identical(other.detected, detected) || other.detected == detected)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath));
}


@override
int get hashCode => Object.hash(runtimeType,item,detected,timestamp,photoPath);

@override
String toString() {
  return 'CheckResult(item: $item, detected: $detected, timestamp: $timestamp, photoPath: $photoPath)';
}


}

/// @nodoc
abstract mixin class _$CheckResultCopyWith<$Res> implements $CheckResultCopyWith<$Res> {
  factory _$CheckResultCopyWith(_CheckResult value, $Res Function(_CheckResult) _then) = __$CheckResultCopyWithImpl;
@override @useResult
$Res call({
 ChecklistItem item, bool detected, DateTime timestamp, String? photoPath
});


@override $ChecklistItemCopyWith<$Res> get item;

}
/// @nodoc
class __$CheckResultCopyWithImpl<$Res>
    implements _$CheckResultCopyWith<$Res> {
  __$CheckResultCopyWithImpl(this._self, this._then);

  final _CheckResult _self;
  final $Res Function(_CheckResult) _then;

/// Create a copy of CheckResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? item = null,Object? detected = null,Object? timestamp = null,Object? photoPath = freezed,}) {
  return _then(_CheckResult(
item: null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as ChecklistItem,detected: null == detected ? _self.detected : detected // ignore: cast_nullable_to_non_nullable
as bool,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,photoPath: freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CheckResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChecklistItemCopyWith<$Res> get item {
  
  return $ChecklistItemCopyWith<$Res>(_self.item, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}

// dart format on
