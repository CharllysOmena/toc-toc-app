// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckEvent()';
}


}

/// @nodoc
class $CheckEventCopyWith<$Res>  {
$CheckEventCopyWith(CheckEvent _, $Res Function(CheckEvent) __);
}


/// Adds pattern-matching-related methods to [CheckEvent].
extension CheckEventPatterns on CheckEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _CaptureRequested value)?  captureRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _CaptureRequested() when captureRequested != null:
return captureRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _CaptureRequested value)  captureRequested,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _CaptureRequested():
return captureRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _CaptureRequested value)?  captureRequested,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _CaptureRequested() when captureRequested != null:
return captureRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String? photoPath)?  captureRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _CaptureRequested() when captureRequested != null:
return captureRequested(_that.photoPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String? photoPath)  captureRequested,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _CaptureRequested():
return captureRequested(_that.photoPath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String? photoPath)?  captureRequested,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _CaptureRequested() when captureRequested != null:
return captureRequested(_that.photoPath);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements CheckEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckEvent.started()';
}


}




/// @nodoc


class _CaptureRequested implements CheckEvent {
  const _CaptureRequested(this.photoPath);
  

 final  String? photoPath;

/// Create a copy of CheckEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CaptureRequestedCopyWith<_CaptureRequested> get copyWith => __$CaptureRequestedCopyWithImpl<_CaptureRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CaptureRequested&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath));
}


@override
int get hashCode => Object.hash(runtimeType,photoPath);

@override
String toString() {
  return 'CheckEvent.captureRequested(photoPath: $photoPath)';
}


}

/// @nodoc
abstract mixin class _$CaptureRequestedCopyWith<$Res> implements $CheckEventCopyWith<$Res> {
  factory _$CaptureRequestedCopyWith(_CaptureRequested value, $Res Function(_CaptureRequested) _then) = __$CaptureRequestedCopyWithImpl;
@useResult
$Res call({
 String? photoPath
});




}
/// @nodoc
class __$CaptureRequestedCopyWithImpl<$Res>
    implements _$CaptureRequestedCopyWith<$Res> {
  __$CaptureRequestedCopyWithImpl(this._self, this._then);

  final _CaptureRequested _self;
  final $Res Function(_CaptureRequested) _then;

/// Create a copy of CheckEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? photoPath = freezed,}) {
  return _then(_CaptureRequested(
freezed == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
