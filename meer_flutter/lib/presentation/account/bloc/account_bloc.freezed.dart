// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AccountEvent()';
}


}

/// @nodoc
class $AccountEventCopyWith<$Res>  {
$AccountEventCopyWith(AccountEvent _, $Res Function(AccountEvent) __);
}


/// Adds pattern-matching-related methods to [AccountEvent].
extension AccountEventPatterns on AccountEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AccountLoadRequested value)?  loadRequested,TResult Function( AccountRefreshRequested value)?  refreshRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AccountLoadRequested() when loadRequested != null:
return loadRequested(_that);case AccountRefreshRequested() when refreshRequested != null:
return refreshRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AccountLoadRequested value)  loadRequested,required TResult Function( AccountRefreshRequested value)  refreshRequested,}){
final _that = this;
switch (_that) {
case AccountLoadRequested():
return loadRequested(_that);case AccountRefreshRequested():
return refreshRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AccountLoadRequested value)?  loadRequested,TResult? Function( AccountRefreshRequested value)?  refreshRequested,}){
final _that = this;
switch (_that) {
case AccountLoadRequested() when loadRequested != null:
return loadRequested(_that);case AccountRefreshRequested() when refreshRequested != null:
return refreshRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadRequested,TResult Function()?  refreshRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AccountLoadRequested() when loadRequested != null:
return loadRequested();case AccountRefreshRequested() when refreshRequested != null:
return refreshRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadRequested,required TResult Function()  refreshRequested,}) {final _that = this;
switch (_that) {
case AccountLoadRequested():
return loadRequested();case AccountRefreshRequested():
return refreshRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadRequested,TResult? Function()?  refreshRequested,}) {final _that = this;
switch (_that) {
case AccountLoadRequested() when loadRequested != null:
return loadRequested();case AccountRefreshRequested() when refreshRequested != null:
return refreshRequested();case _:
  return null;

}
}

}

/// @nodoc


class AccountLoadRequested implements AccountEvent {
  const AccountLoadRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountLoadRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AccountEvent.loadRequested()';
}


}




/// @nodoc


class AccountRefreshRequested implements AccountEvent {
  const AccountRefreshRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountRefreshRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AccountEvent.refreshRequested()';
}


}




/// @nodoc
mixin _$AccountState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AccountState()';
}


}

/// @nodoc
class $AccountStateCopyWith<$Res>  {
$AccountStateCopyWith(AccountState _, $Res Function(AccountState) __);
}


/// Adds pattern-matching-related methods to [AccountState].
extension AccountStatePatterns on AccountState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AccountInitial value)?  initial,TResult Function( AccountLoading value)?  loading,TResult Function( AccountLoaded value)?  loaded,TResult Function( AccountError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AccountInitial() when initial != null:
return initial(_that);case AccountLoading() when loading != null:
return loading(_that);case AccountLoaded() when loaded != null:
return loaded(_that);case AccountError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AccountInitial value)  initial,required TResult Function( AccountLoading value)  loading,required TResult Function( AccountLoaded value)  loaded,required TResult Function( AccountError value)  error,}){
final _that = this;
switch (_that) {
case AccountInitial():
return initial(_that);case AccountLoading():
return loading(_that);case AccountLoaded():
return loaded(_that);case AccountError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AccountInitial value)?  initial,TResult? Function( AccountLoading value)?  loading,TResult? Function( AccountLoaded value)?  loaded,TResult? Function( AccountError value)?  error,}){
final _that = this;
switch (_that) {
case AccountInitial() when initial != null:
return initial(_that);case AccountLoading() when loading != null:
return loading(_that);case AccountLoaded() when loaded != null:
return loaded(_that);case AccountError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( MeerUserProfile profile)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AccountInitial() when initial != null:
return initial();case AccountLoading() when loading != null:
return loading();case AccountLoaded() when loaded != null:
return loaded(_that.profile);case AccountError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( MeerUserProfile profile)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case AccountInitial():
return initial();case AccountLoading():
return loading();case AccountLoaded():
return loaded(_that.profile);case AccountError():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( MeerUserProfile profile)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case AccountInitial() when initial != null:
return initial();case AccountLoading() when loading != null:
return loading();case AccountLoaded() when loaded != null:
return loaded(_that.profile);case AccountError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class AccountInitial implements AccountState {
  const AccountInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AccountState.initial()';
}


}




/// @nodoc


class AccountLoading implements AccountState {
  const AccountLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AccountState.loading()';
}


}




/// @nodoc


class AccountLoaded implements AccountState {
  const AccountLoaded({required this.profile});
  

 final  MeerUserProfile profile;

/// Create a copy of AccountState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountLoadedCopyWith<AccountLoaded> get copyWith => _$AccountLoadedCopyWithImpl<AccountLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountLoaded&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,profile);

@override
String toString() {
  return 'AccountState.loaded(profile: $profile)';
}


}

/// @nodoc
abstract mixin class $AccountLoadedCopyWith<$Res> implements $AccountStateCopyWith<$Res> {
  factory $AccountLoadedCopyWith(AccountLoaded value, $Res Function(AccountLoaded) _then) = _$AccountLoadedCopyWithImpl;
@useResult
$Res call({
 MeerUserProfile profile
});




}
/// @nodoc
class _$AccountLoadedCopyWithImpl<$Res>
    implements $AccountLoadedCopyWith<$Res> {
  _$AccountLoadedCopyWithImpl(this._self, this._then);

  final AccountLoaded _self;
  final $Res Function(AccountLoaded) _then;

/// Create a copy of AccountState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profile = null,}) {
  return _then(AccountLoaded(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as MeerUserProfile,
  ));
}


}

/// @nodoc


class AccountError implements AccountState {
  const AccountError(this.message);
  

 final  String message;

/// Create a copy of AccountState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountErrorCopyWith<AccountError> get copyWith => _$AccountErrorCopyWithImpl<AccountError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AccountState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $AccountErrorCopyWith<$Res> implements $AccountStateCopyWith<$Res> {
  factory $AccountErrorCopyWith(AccountError value, $Res Function(AccountError) _then) = _$AccountErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AccountErrorCopyWithImpl<$Res>
    implements $AccountErrorCopyWith<$Res> {
  _$AccountErrorCopyWithImpl(this._self, this._then);

  final AccountError _self;
  final $Res Function(AccountError) _then;

/// Create a copy of AccountState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(AccountError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
