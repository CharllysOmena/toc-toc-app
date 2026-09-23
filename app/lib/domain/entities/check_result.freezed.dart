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

 DateTime get timestamp; List<ChecklistItem> get items; List<String> get missingIds;
/// Create a copy of CheckResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckResultCopyWith<CheckResult> get copyWith => _$CheckResultCopyWithImpl<CheckResult>(this as CheckResult, _$identity);

  /// Serializes this CheckResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckResult&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.items, items)&&const DeepCollectionEquality().equals(other.missingIds, missingIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timestamp,const DeepCollectionEquality().hash(items),const DeepCollectionEquality().hash(missingIds));

@override
String toString() {
  return 'CheckResult(timestamp: $timestamp, items: $items, missingIds: $missingIds)';
}


}

/// @nodoc
abstract mixin class $CheckResultCopyWith<$Res>  {
  factory $CheckResultCopyWith(CheckResult value, $Res Function(CheckResult) _then) = _$CheckResultCopyWithImpl;
@useResult
$Res call({
 DateTime timestamp, List<ChecklistItem> items, List<String> missingIds
});




}
/// @nodoc
class _$CheckResultCopyWithImpl<$Res>
    implements $CheckResultCopyWith<$Res> {
  _$CheckResultCopyWithImpl(this._self, this._then);

  final CheckResult _self;
  final $Res Function(CheckResult) _then;

/// Create a copy of CheckResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timestamp = null,Object? items = null,Object? missingIds = null,}) {
  return _then(_self.copyWith(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ChecklistItem>,missingIds: null == missingIds ? _self.missingIds : missingIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime timestamp,  List<ChecklistItem> items,  List<String> missingIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckResult() when $default != null:
return $default(_that.timestamp,_that.items,_that.missingIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime timestamp,  List<ChecklistItem> items,  List<String> missingIds)  $default,) {final _that = this;
switch (_that) {
case _CheckResult():
return $default(_that.timestamp,_that.items,_that.missingIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime timestamp,  List<ChecklistItem> items,  List<String> missingIds)?  $default,) {final _that = this;
switch (_that) {
case _CheckResult() when $default != null:
return $default(_that.timestamp,_that.items,_that.missingIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckResult implements CheckResult {
  const _CheckResult({required this.timestamp, required  List<ChecklistItem> items, required  List<String> missingIds}): _items = items,_missingIds = missingIds;
  factory _CheckResult.fromJson(Map<String, dynamic> json) => _$CheckResultFromJson(json);

@override final  DateTime timestamp;
 final  List<ChecklistItem> _items;
@override List<ChecklistItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  List<String> _missingIds;
@override List<String> get missingIds {
  if (_missingIds is EqualUnmodifiableListView) return _missingIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_missingIds);
}


/// Create a copy of CheckResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckResultCopyWith<_CheckResult> get copyWith => __$CheckResultCopyWithImpl<_CheckResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckResult&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._items, _items)&&const DeepCollectionEquality().equals(other._missingIds, _missingIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timestamp,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(_missingIds));

@override
String toString() {
  return 'CheckResult(timestamp: $timestamp, items: $items, missingIds: $missingIds)';
}


}

/// @nodoc
abstract mixin class _$CheckResultCopyWith<$Res> implements $CheckResultCopyWith<$Res> {
  factory _$CheckResultCopyWith(_CheckResult value, $Res Function(_CheckResult) _then) = __$CheckResultCopyWithImpl;
@override @useResult
$Res call({
 DateTime timestamp, List<ChecklistItem> items, List<String> missingIds
});




}
/// @nodoc
class __$CheckResultCopyWithImpl<$Res>
    implements _$CheckResultCopyWith<$Res> {
  __$CheckResultCopyWithImpl(this._self, this._then);

  final _CheckResult _self;
  final $Res Function(_CheckResult) _then;

/// Create a copy of CheckResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timestamp = null,Object? items = null,Object? missingIds = null,}) {
  return _then(_CheckResult(
timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ChecklistItem>,missingIds: null == missingIds ? _self._missingIds : missingIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
