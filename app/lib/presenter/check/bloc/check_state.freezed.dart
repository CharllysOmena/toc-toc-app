// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckState()';
}


}

/// @nodoc
class $CheckStateCopyWith<$Res>  {
$CheckStateCopyWith(CheckState _, $Res Function(CheckState) __);
}


/// Adds pattern-matching-related methods to [CheckState].
extension CheckStatePatterns on CheckState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Loading value)?  loading,TResult Function( _Confirmed value)?  confirmed,TResult Function( _Missing value)?  missing,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading(_that);case _Confirmed() when confirmed != null:
return confirmed(_that);case _Missing() when missing != null:
return missing(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Loading value)  loading,required TResult Function( _Confirmed value)  confirmed,required TResult Function( _Missing value)  missing,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Loading():
return loading(_that);case _Confirmed():
return confirmed(_that);case _Missing():
return missing(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Loading value)?  loading,TResult? Function( _Confirmed value)?  confirmed,TResult? Function( _Missing value)?  missing,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading(_that);case _Confirmed() when confirmed != null:
return confirmed(_that);case _Missing() when missing != null:
return missing(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( CheckResult result)?  confirmed,TResult Function( CheckResult result)?  missing,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Confirmed() when confirmed != null:
return confirmed(_that.result);case _Missing() when missing != null:
return missing(_that.result);case _Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( CheckResult result)  confirmed,required TResult Function( CheckResult result)  missing,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Loading():
return loading();case _Confirmed():
return confirmed(_that.result);case _Missing():
return missing(_that.result);case _Error():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( CheckResult result)?  confirmed,TResult? Function( CheckResult result)?  missing,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Confirmed() when confirmed != null:
return confirmed(_that.result);case _Missing() when missing != null:
return missing(_that.result);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Loading implements CheckState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckState.loading()';
}


}




/// @nodoc


class _Confirmed implements CheckState {
  const _Confirmed({required this.result});
  

 final  CheckResult result;

/// Create a copy of CheckState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfirmedCopyWith<_Confirmed> get copyWith => __$ConfirmedCopyWithImpl<_Confirmed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Confirmed&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,result);

@override
String toString() {
  return 'CheckState.confirmed(result: $result)';
}


}

/// @nodoc
abstract mixin class _$ConfirmedCopyWith<$Res> implements $CheckStateCopyWith<$Res> {
  factory _$ConfirmedCopyWith(_Confirmed value, $Res Function(_Confirmed) _then) = __$ConfirmedCopyWithImpl;
@useResult
$Res call({
 CheckResult result
});


$CheckResultCopyWith<$Res> get result;

}
/// @nodoc
class __$ConfirmedCopyWithImpl<$Res>
    implements _$ConfirmedCopyWith<$Res> {
  __$ConfirmedCopyWithImpl(this._self, this._then);

  final _Confirmed _self;
  final $Res Function(_Confirmed) _then;

/// Create a copy of CheckState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(_Confirmed(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as CheckResult,
  ));
}

/// Create a copy of CheckState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CheckResultCopyWith<$Res> get result {
  
  return $CheckResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

/// @nodoc


class _Missing implements CheckState {
  const _Missing({required this.result});
  

 final  CheckResult result;

/// Create a copy of CheckState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MissingCopyWith<_Missing> get copyWith => __$MissingCopyWithImpl<_Missing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Missing&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,result);

@override
String toString() {
  return 'CheckState.missing(result: $result)';
}


}

/// @nodoc
abstract mixin class _$MissingCopyWith<$Res> implements $CheckStateCopyWith<$Res> {
  factory _$MissingCopyWith(_Missing value, $Res Function(_Missing) _then) = __$MissingCopyWithImpl;
@useResult
$Res call({
 CheckResult result
});


$CheckResultCopyWith<$Res> get result;

}
/// @nodoc
class __$MissingCopyWithImpl<$Res>
    implements _$MissingCopyWith<$Res> {
  __$MissingCopyWithImpl(this._self, this._then);

  final _Missing _self;
  final $Res Function(_Missing) _then;

/// Create a copy of CheckState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(_Missing(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as CheckResult,
  ));
}

/// Create a copy of CheckState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CheckResultCopyWith<$Res> get result {
  
  return $CheckResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

/// @nodoc


class _Error implements CheckState {
  const _Error({required this.message});
  

 final  String message;

/// Create a copy of CheckState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CheckState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $CheckStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of CheckState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
