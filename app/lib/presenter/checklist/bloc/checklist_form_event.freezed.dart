// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checklist_form_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChecklistFormEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChecklistFormEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChecklistFormEvent()';
}


}

/// @nodoc
class $ChecklistFormEventCopyWith<$Res>  {
$ChecklistFormEventCopyWith(ChecklistFormEvent _, $Res Function(ChecklistFormEvent) __);
}


/// Adds pattern-matching-related methods to [ChecklistFormEvent].
extension ChecklistFormEventPatterns on ChecklistFormEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _TitleChanged value)?  titleChanged,TResult Function( _ObjectChanged value)?  objectChanged,TResult Function( _TimeChanged value)?  timeChanged,TResult Function( _WeekDayToggled value)?  weekDayToggled,TResult Function( _Saved value)?  saved,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _TitleChanged() when titleChanged != null:
return titleChanged(_that);case _ObjectChanged() when objectChanged != null:
return objectChanged(_that);case _TimeChanged() when timeChanged != null:
return timeChanged(_that);case _WeekDayToggled() when weekDayToggled != null:
return weekDayToggled(_that);case _Saved() when saved != null:
return saved(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _TitleChanged value)  titleChanged,required TResult Function( _ObjectChanged value)  objectChanged,required TResult Function( _TimeChanged value)  timeChanged,required TResult Function( _WeekDayToggled value)  weekDayToggled,required TResult Function( _Saved value)  saved,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _TitleChanged():
return titleChanged(_that);case _ObjectChanged():
return objectChanged(_that);case _TimeChanged():
return timeChanged(_that);case _WeekDayToggled():
return weekDayToggled(_that);case _Saved():
return saved(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _TitleChanged value)?  titleChanged,TResult? Function( _ObjectChanged value)?  objectChanged,TResult? Function( _TimeChanged value)?  timeChanged,TResult? Function( _WeekDayToggled value)?  weekDayToggled,TResult? Function( _Saved value)?  saved,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _TitleChanged() when titleChanged != null:
return titleChanged(_that);case _ObjectChanged() when objectChanged != null:
return objectChanged(_that);case _TimeChanged() when timeChanged != null:
return timeChanged(_that);case _WeekDayToggled() when weekDayToggled != null:
return weekDayToggled(_that);case _Saved() when saved != null:
return saved(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? id)?  started,TResult Function( String title)?  titleChanged,TResult Function( String objectId)?  objectChanged,TResult Function( DayTime time)?  timeChanged,TResult Function( int day)?  weekDayToggled,TResult Function()?  saved,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.id);case _TitleChanged() when titleChanged != null:
return titleChanged(_that.title);case _ObjectChanged() when objectChanged != null:
return objectChanged(_that.objectId);case _TimeChanged() when timeChanged != null:
return timeChanged(_that.time);case _WeekDayToggled() when weekDayToggled != null:
return weekDayToggled(_that.day);case _Saved() when saved != null:
return saved();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? id)  started,required TResult Function( String title)  titleChanged,required TResult Function( String objectId)  objectChanged,required TResult Function( DayTime time)  timeChanged,required TResult Function( int day)  weekDayToggled,required TResult Function()  saved,}) {final _that = this;
switch (_that) {
case _Started():
return started(_that.id);case _TitleChanged():
return titleChanged(_that.title);case _ObjectChanged():
return objectChanged(_that.objectId);case _TimeChanged():
return timeChanged(_that.time);case _WeekDayToggled():
return weekDayToggled(_that.day);case _Saved():
return saved();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? id)?  started,TResult? Function( String title)?  titleChanged,TResult? Function( String objectId)?  objectChanged,TResult? Function( DayTime time)?  timeChanged,TResult? Function( int day)?  weekDayToggled,TResult? Function()?  saved,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.id);case _TitleChanged() when titleChanged != null:
return titleChanged(_that.title);case _ObjectChanged() when objectChanged != null:
return objectChanged(_that.objectId);case _TimeChanged() when timeChanged != null:
return timeChanged(_that.time);case _WeekDayToggled() when weekDayToggled != null:
return weekDayToggled(_that.day);case _Saved() when saved != null:
return saved();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements ChecklistFormEvent {
  const _Started(this.id);
  

 final  String? id;

/// Create a copy of ChecklistFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartedCopyWith<_Started> get copyWith => __$StartedCopyWithImpl<_Started>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'ChecklistFormEvent.started(id: $id)';
}


}

/// @nodoc
abstract mixin class _$StartedCopyWith<$Res> implements $ChecklistFormEventCopyWith<$Res> {
  factory _$StartedCopyWith(_Started value, $Res Function(_Started) _then) = __$StartedCopyWithImpl;
@useResult
$Res call({
 String? id
});




}
/// @nodoc
class __$StartedCopyWithImpl<$Res>
    implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(this._self, this._then);

  final _Started _self;
  final $Res Function(_Started) _then;

/// Create a copy of ChecklistFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = freezed,}) {
  return _then(_Started(
freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _TitleChanged implements ChecklistFormEvent {
  const _TitleChanged(this.title);
  

 final  String title;

/// Create a copy of ChecklistFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TitleChangedCopyWith<_TitleChanged> get copyWith => __$TitleChangedCopyWithImpl<_TitleChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TitleChanged&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode => Object.hash(runtimeType,title);

@override
String toString() {
  return 'ChecklistFormEvent.titleChanged(title: $title)';
}


}

/// @nodoc
abstract mixin class _$TitleChangedCopyWith<$Res> implements $ChecklistFormEventCopyWith<$Res> {
  factory _$TitleChangedCopyWith(_TitleChanged value, $Res Function(_TitleChanged) _then) = __$TitleChangedCopyWithImpl;
@useResult
$Res call({
 String title
});




}
/// @nodoc
class __$TitleChangedCopyWithImpl<$Res>
    implements _$TitleChangedCopyWith<$Res> {
  __$TitleChangedCopyWithImpl(this._self, this._then);

  final _TitleChanged _self;
  final $Res Function(_TitleChanged) _then;

/// Create a copy of ChecklistFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? title = null,}) {
  return _then(_TitleChanged(
null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ObjectChanged implements ChecklistFormEvent {
  const _ObjectChanged(this.objectId);
  

 final  String objectId;

/// Create a copy of ChecklistFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ObjectChangedCopyWith<_ObjectChanged> get copyWith => __$ObjectChangedCopyWithImpl<_ObjectChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ObjectChanged&&(identical(other.objectId, objectId) || other.objectId == objectId));
}


@override
int get hashCode => Object.hash(runtimeType,objectId);

@override
String toString() {
  return 'ChecklistFormEvent.objectChanged(objectId: $objectId)';
}


}

/// @nodoc
abstract mixin class _$ObjectChangedCopyWith<$Res> implements $ChecklistFormEventCopyWith<$Res> {
  factory _$ObjectChangedCopyWith(_ObjectChanged value, $Res Function(_ObjectChanged) _then) = __$ObjectChangedCopyWithImpl;
@useResult
$Res call({
 String objectId
});




}
/// @nodoc
class __$ObjectChangedCopyWithImpl<$Res>
    implements _$ObjectChangedCopyWith<$Res> {
  __$ObjectChangedCopyWithImpl(this._self, this._then);

  final _ObjectChanged _self;
  final $Res Function(_ObjectChanged) _then;

/// Create a copy of ChecklistFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? objectId = null,}) {
  return _then(_ObjectChanged(
null == objectId ? _self.objectId : objectId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _TimeChanged implements ChecklistFormEvent {
  const _TimeChanged(this.time);
  

 final  DayTime time;

/// Create a copy of ChecklistFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimeChangedCopyWith<_TimeChanged> get copyWith => __$TimeChangedCopyWithImpl<_TimeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimeChanged&&(identical(other.time, time) || other.time == time));
}


@override
int get hashCode => Object.hash(runtimeType,time);

@override
String toString() {
  return 'ChecklistFormEvent.timeChanged(time: $time)';
}


}

/// @nodoc
abstract mixin class _$TimeChangedCopyWith<$Res> implements $ChecklistFormEventCopyWith<$Res> {
  factory _$TimeChangedCopyWith(_TimeChanged value, $Res Function(_TimeChanged) _then) = __$TimeChangedCopyWithImpl;
@useResult
$Res call({
 DayTime time
});


$DayTimeCopyWith<$Res> get time;

}
/// @nodoc
class __$TimeChangedCopyWithImpl<$Res>
    implements _$TimeChangedCopyWith<$Res> {
  __$TimeChangedCopyWithImpl(this._self, this._then);

  final _TimeChanged _self;
  final $Res Function(_TimeChanged) _then;

/// Create a copy of ChecklistFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? time = null,}) {
  return _then(_TimeChanged(
null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DayTime,
  ));
}

/// Create a copy of ChecklistFormEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DayTimeCopyWith<$Res> get time {
  
  return $DayTimeCopyWith<$Res>(_self.time, (value) {
    return _then(_self.copyWith(time: value));
  });
}
}

/// @nodoc


class _WeekDayToggled implements ChecklistFormEvent {
  const _WeekDayToggled(this.day);
  

 final  int day;

/// Create a copy of ChecklistFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeekDayToggledCopyWith<_WeekDayToggled> get copyWith => __$WeekDayToggledCopyWithImpl<_WeekDayToggled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeekDayToggled&&(identical(other.day, day) || other.day == day));
}


@override
int get hashCode => Object.hash(runtimeType,day);

@override
String toString() {
  return 'ChecklistFormEvent.weekDayToggled(day: $day)';
}


}

/// @nodoc
abstract mixin class _$WeekDayToggledCopyWith<$Res> implements $ChecklistFormEventCopyWith<$Res> {
  factory _$WeekDayToggledCopyWith(_WeekDayToggled value, $Res Function(_WeekDayToggled) _then) = __$WeekDayToggledCopyWithImpl;
@useResult
$Res call({
 int day
});




}
/// @nodoc
class __$WeekDayToggledCopyWithImpl<$Res>
    implements _$WeekDayToggledCopyWith<$Res> {
  __$WeekDayToggledCopyWithImpl(this._self, this._then);

  final _WeekDayToggled _self;
  final $Res Function(_WeekDayToggled) _then;

/// Create a copy of ChecklistFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? day = null,}) {
  return _then(_WeekDayToggled(
null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _Saved implements ChecklistFormEvent {
  const _Saved();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Saved);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChecklistFormEvent.saved()';
}


}




// dart format on
