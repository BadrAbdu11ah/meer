// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_otp_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VerifyOtpState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VerifyOtpState()';
}


}

/// @nodoc
class $VerifyOtpStateCopyWith<$Res>  {
$VerifyOtpStateCopyWith(VerifyOtpState _, $Res Function(VerifyOtpState) __);
}


/// Adds pattern-matching-related methods to [VerifyOtpState].
extension VerifyOtpStatePatterns on VerifyOtpState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loaidng value)?  loading,TResult Function( _Authenticated value)?  authenticated,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loaidng() when loading != null:
return loading(_that);case _Authenticated() when authenticated != null:
return authenticated(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loaidng value)  loading,required TResult Function( _Authenticated value)  authenticated,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loaidng():
return loading(_that);case _Authenticated():
return authenticated(_that);case _Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loaidng value)?  loading,TResult? Function( _Authenticated value)?  authenticated,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loaidng() when loading != null:
return loading(_that);case _Authenticated() when authenticated != null:
return authenticated(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( User userProfile)?  authenticated,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loaidng() when loading != null:
return loading();case _Authenticated() when authenticated != null:
return authenticated(_that.userProfile);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( User userProfile)  authenticated,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loaidng():
return loading();case _Authenticated():
return authenticated(_that.userProfile);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( User userProfile)?  authenticated,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loaidng() when loading != null:
return loading();case _Authenticated() when authenticated != null:
return authenticated(_that.userProfile);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements VerifyOtpState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VerifyOtpState.initial()';
}


}




/// @nodoc


class _Loaidng implements VerifyOtpState {
  const _Loaidng();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaidng);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VerifyOtpState.loading()';
}


}




/// @nodoc


class _Authenticated implements VerifyOtpState {
  const _Authenticated(this.userProfile);
  

 final  User userProfile;

/// Create a copy of VerifyOtpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthenticatedCopyWith<_Authenticated> get copyWith => __$AuthenticatedCopyWithImpl<_Authenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Authenticated&&(identical(other.userProfile, userProfile) || other.userProfile == userProfile));
}


@override
int get hashCode => Object.hash(runtimeType,userProfile);

@override
String toString() {
  return 'VerifyOtpState.authenticated(userProfile: $userProfile)';
}


}

/// @nodoc
abstract mixin class _$AuthenticatedCopyWith<$Res> implements $VerifyOtpStateCopyWith<$Res> {
  factory _$AuthenticatedCopyWith(_Authenticated value, $Res Function(_Authenticated) _then) = __$AuthenticatedCopyWithImpl;
@useResult
$Res call({
 User userProfile
});




}
/// @nodoc
class __$AuthenticatedCopyWithImpl<$Res>
    implements _$AuthenticatedCopyWith<$Res> {
  __$AuthenticatedCopyWithImpl(this._self, this._then);

  final _Authenticated _self;
  final $Res Function(_Authenticated) _then;

/// Create a copy of VerifyOtpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userProfile = null,}) {
  return _then(_Authenticated(
null == userProfile ? _self.userProfile : userProfile // ignore: cast_nullable_to_non_nullable
as User,
  ));
}


}

/// @nodoc


class _Error implements VerifyOtpState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of VerifyOtpState
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
  return 'VerifyOtpState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $VerifyOtpStateCopyWith<$Res> {
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

/// Create a copy of VerifyOtpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$VerifyOtpEvent {

 String get phone; String get code;
/// Create a copy of VerifyOtpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyOtpEventCopyWith<VerifyOtpEvent> get copyWith => _$VerifyOtpEventCopyWithImpl<VerifyOtpEvent>(this as VerifyOtpEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpEvent&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,phone,code);

@override
String toString() {
  return 'VerifyOtpEvent(phone: $phone, code: $code)';
}


}

/// @nodoc
abstract mixin class $VerifyOtpEventCopyWith<$Res>  {
  factory $VerifyOtpEventCopyWith(VerifyOtpEvent value, $Res Function(VerifyOtpEvent) _then) = _$VerifyOtpEventCopyWithImpl;
@useResult
$Res call({
 String phone, String code
});




}
/// @nodoc
class _$VerifyOtpEventCopyWithImpl<$Res>
    implements $VerifyOtpEventCopyWith<$Res> {
  _$VerifyOtpEventCopyWithImpl(this._self, this._then);

  final VerifyOtpEvent _self;
  final $Res Function(VerifyOtpEvent) _then;

/// Create a copy of VerifyOtpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phone = null,Object? code = null,}) {
  return _then(_self.copyWith(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyOtpEvent].
extension VerifyOtpEventPatterns on VerifyOtpEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VerifyOtpRequested value)?  verifyOtpRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VerifyOtpRequested() when verifyOtpRequested != null:
return verifyOtpRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VerifyOtpRequested value)  verifyOtpRequested,}){
final _that = this;
switch (_that) {
case VerifyOtpRequested():
return verifyOtpRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VerifyOtpRequested value)?  verifyOtpRequested,}){
final _that = this;
switch (_that) {
case VerifyOtpRequested() when verifyOtpRequested != null:
return verifyOtpRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String phone,  String code)?  verifyOtpRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VerifyOtpRequested() when verifyOtpRequested != null:
return verifyOtpRequested(_that.phone,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String phone,  String code)  verifyOtpRequested,}) {final _that = this;
switch (_that) {
case VerifyOtpRequested():
return verifyOtpRequested(_that.phone,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String phone,  String code)?  verifyOtpRequested,}) {final _that = this;
switch (_that) {
case VerifyOtpRequested() when verifyOtpRequested != null:
return verifyOtpRequested(_that.phone,_that.code);case _:
  return null;

}
}

}

/// @nodoc


class VerifyOtpRequested implements VerifyOtpEvent {
  const VerifyOtpRequested({required this.phone, required this.code});
  

@override final  String phone;
@override final  String code;

/// Create a copy of VerifyOtpEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyOtpRequestedCopyWith<VerifyOtpRequested> get copyWith => _$VerifyOtpRequestedCopyWithImpl<VerifyOtpRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpRequested&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,phone,code);

@override
String toString() {
  return 'VerifyOtpEvent.verifyOtpRequested(phone: $phone, code: $code)';
}


}

/// @nodoc
abstract mixin class $VerifyOtpRequestedCopyWith<$Res> implements $VerifyOtpEventCopyWith<$Res> {
  factory $VerifyOtpRequestedCopyWith(VerifyOtpRequested value, $Res Function(VerifyOtpRequested) _then) = _$VerifyOtpRequestedCopyWithImpl;
@override @useResult
$Res call({
 String phone, String code
});




}
/// @nodoc
class _$VerifyOtpRequestedCopyWithImpl<$Res>
    implements $VerifyOtpRequestedCopyWith<$Res> {
  _$VerifyOtpRequestedCopyWithImpl(this._self, this._then);

  final VerifyOtpRequested _self;
  final $Res Function(VerifyOtpRequested) _then;

/// Create a copy of VerifyOtpEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phone = null,Object? code = null,}) {
  return _then(VerifyOtpRequested(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
