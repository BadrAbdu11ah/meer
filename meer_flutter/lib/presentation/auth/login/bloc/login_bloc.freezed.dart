// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LoginState()';
}


}

/// @nodoc
class $LoginStateCopyWith<$Res>  {
$LoginStateCopyWith(LoginState _, $Res Function(LoginState) __);
}


/// Adds pattern-matching-related methods to [LoginState].
extension LoginStatePatterns on LoginState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _LoginLoading value)?  loading,TResult Function( _OtpSent value)?  otpSent,TResult Function( _Authenticated value)?  authenticated,TResult Function( _LoginError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _LoginLoading() when loading != null:
return loading(_that);case _OtpSent() when otpSent != null:
return otpSent(_that);case _Authenticated() when authenticated != null:
return authenticated(_that);case _LoginError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _LoginLoading value)  loading,required TResult Function( _OtpSent value)  otpSent,required TResult Function( _Authenticated value)  authenticated,required TResult Function( _LoginError value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _LoginLoading():
return loading(_that);case _OtpSent():
return otpSent(_that);case _Authenticated():
return authenticated(_that);case _LoginError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _LoginLoading value)?  loading,TResult? Function( _OtpSent value)?  otpSent,TResult? Function( _Authenticated value)?  authenticated,TResult? Function( _LoginError value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _LoginLoading() when loading != null:
return loading(_that);case _OtpSent() when otpSent != null:
return otpSent(_that);case _Authenticated() when authenticated != null:
return authenticated(_that);case _LoginError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  otpSent,TResult Function( User userProfile)?  authenticated,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _LoginLoading() when loading != null:
return loading();case _OtpSent() when otpSent != null:
return otpSent();case _Authenticated() when authenticated != null:
return authenticated(_that.userProfile);case _LoginError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  otpSent,required TResult Function( User userProfile)  authenticated,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _LoginLoading():
return loading();case _OtpSent():
return otpSent();case _Authenticated():
return authenticated(_that.userProfile);case _LoginError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  otpSent,TResult? Function( User userProfile)?  authenticated,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _LoginLoading() when loading != null:
return loading();case _OtpSent() when otpSent != null:
return otpSent();case _Authenticated() when authenticated != null:
return authenticated(_that.userProfile);case _LoginError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements LoginState {
  const _Initial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LoginState.initial()';
}


}




/// @nodoc


class _LoginLoading implements LoginState {
  const _LoginLoading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LoginState.loading()';
}


}




/// @nodoc


class _OtpSent implements LoginState {
  const _OtpSent();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpSent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LoginState.otpSent()';
}


}




/// @nodoc


class _Authenticated implements LoginState {
  const _Authenticated(this.userProfile);
  

 final  User userProfile;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthenticatedCopyWith<_Authenticated> get copyWith => __$AuthenticatedCopyWithImpl<_Authenticated>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Authenticated&&(identical(other.userProfile, userProfile) || other.userProfile == userProfile));
}


@override
int get hashCode {
    return Object.hash(runtimeType,userProfile);
}

@override
String toString() {
    return 'LoginState.authenticated(userProfile: $userProfile)';
}


}

/// @nodoc
abstract mixin class _$AuthenticatedCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
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

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userProfile = null,}) {
  return _then(_Authenticated(
null == userProfile ? _self.userProfile : userProfile // ignore: cast_nullable_to_non_nullable
as User,
  ));
}


}

/// @nodoc


class _LoginError implements LoginState {
  const _LoginError(this.message);
  

 final  String message;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginErrorCopyWith<_LoginError> get copyWith => __$LoginErrorCopyWithImpl<_LoginError>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'LoginState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$LoginErrorCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$LoginErrorCopyWith(_LoginError value, $Res Function(_LoginError) _then) = __$LoginErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$LoginErrorCopyWithImpl<$Res>
    implements _$LoginErrorCopyWith<$Res> {
  __$LoginErrorCopyWithImpl(this._self, this._then);

  final _LoginError _self;
  final $Res Function(_LoginError) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_LoginError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$LoginEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LoginEvent()';
}


}

/// @nodoc
class $LoginEventCopyWith<$Res>  {
$LoginEventCopyWith(LoginEvent _, $Res Function(LoginEvent) __);
}


/// Adds pattern-matching-related methods to [LoginEvent].
extension LoginEventPatterns on LoginEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GoogleSignInRequested value)?  googleSignInRequested,TResult Function( SendOtpRequested value)?  sendOtpRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GoogleSignInRequested() when googleSignInRequested != null:
return googleSignInRequested(_that);case SendOtpRequested() when sendOtpRequested != null:
return sendOtpRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GoogleSignInRequested value)  googleSignInRequested,required TResult Function( SendOtpRequested value)  sendOtpRequested,}){
final _that = this;
switch (_that) {
case GoogleSignInRequested():
return googleSignInRequested(_that);case SendOtpRequested():
return sendOtpRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GoogleSignInRequested value)?  googleSignInRequested,TResult? Function( SendOtpRequested value)?  sendOtpRequested,}){
final _that = this;
switch (_that) {
case GoogleSignInRequested() when googleSignInRequested != null:
return googleSignInRequested(_that);case SendOtpRequested() when sendOtpRequested != null:
return sendOtpRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  googleSignInRequested,TResult Function( String phone)?  sendOtpRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GoogleSignInRequested() when googleSignInRequested != null:
return googleSignInRequested();case SendOtpRequested() when sendOtpRequested != null:
return sendOtpRequested(_that.phone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  googleSignInRequested,required TResult Function( String phone)  sendOtpRequested,}) {final _that = this;
switch (_that) {
case GoogleSignInRequested():
return googleSignInRequested();case SendOtpRequested():
return sendOtpRequested(_that.phone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  googleSignInRequested,TResult? Function( String phone)?  sendOtpRequested,}) {final _that = this;
switch (_that) {
case GoogleSignInRequested() when googleSignInRequested != null:
return googleSignInRequested();case SendOtpRequested() when sendOtpRequested != null:
return sendOtpRequested(_that.phone);case _:
  return null;

}
}

}

/// @nodoc


class GoogleSignInRequested implements LoginEvent {
  const GoogleSignInRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is GoogleSignInRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LoginEvent.googleSignInRequested()';
}


}




/// @nodoc


class SendOtpRequested implements LoginEvent {
  const SendOtpRequested({required this.phone});
  

 final  String phone;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendOtpRequestedCopyWith<SendOtpRequested> get copyWith => _$SendOtpRequestedCopyWithImpl<SendOtpRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SendOtpRequested&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode {
    return Object.hash(runtimeType,phone);
}

@override
String toString() {
    return 'LoginEvent.sendOtpRequested(phone: $phone)';
}


}

/// @nodoc
abstract mixin class $SendOtpRequestedCopyWith<$Res> implements $LoginEventCopyWith<$Res> {
  factory $SendOtpRequestedCopyWith(SendOtpRequested value, $Res Function(SendOtpRequested) _then) = _$SendOtpRequestedCopyWithImpl;
@useResult
$Res call({
 String phone
});




}
/// @nodoc
class _$SendOtpRequestedCopyWithImpl<$Res>
    implements $SendOtpRequestedCopyWith<$Res> {
  _$SendOtpRequestedCopyWithImpl(this._self, this._then);

  final SendOtpRequested _self;
  final $Res Function(SendOtpRequested) _then;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phone = null,}) {
  return _then(SendOtpRequested(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
