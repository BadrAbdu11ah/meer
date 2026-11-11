// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seller_setup_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SellerSetupEvent {

 String get storeName; String? get storeDescription; String get storeAddress; MeerCity get city; String? get district; double get latitude; double get longitude;
/// Create a copy of SellerSetupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SellerSetupEventCopyWith<SellerSetupEvent> get copyWith => _$SellerSetupEventCopyWithImpl<SellerSetupEvent>(this as SellerSetupEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerSetupEvent&&(identical(other.storeName, storeName) || other.storeName == storeName)&&(identical(other.storeDescription, storeDescription) || other.storeDescription == storeDescription)&&(identical(other.storeAddress, storeAddress) || other.storeAddress == storeAddress)&&(identical(other.city, city) || other.city == city)&&(identical(other.district, district) || other.district == district)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode => Object.hash(runtimeType,storeName,storeDescription,storeAddress,city,district,latitude,longitude);

@override
String toString() {
  return 'SellerSetupEvent(storeName: $storeName, storeDescription: $storeDescription, storeAddress: $storeAddress, city: $city, district: $district, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $SellerSetupEventCopyWith<$Res>  {
  factory $SellerSetupEventCopyWith(SellerSetupEvent value, $Res Function(SellerSetupEvent) _then) = _$SellerSetupEventCopyWithImpl;
@useResult
$Res call({
 String storeName, String? storeDescription, String storeAddress, MeerCity city, String? district, double latitude, double longitude
});




}
/// @nodoc
class _$SellerSetupEventCopyWithImpl<$Res>
    implements $SellerSetupEventCopyWith<$Res> {
  _$SellerSetupEventCopyWithImpl(this._self, this._then);

  final SellerSetupEvent _self;
  final $Res Function(SellerSetupEvent) _then;

/// Create a copy of SellerSetupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? storeName = null,Object? storeDescription = freezed,Object? storeAddress = null,Object? city = null,Object? district = freezed,Object? latitude = null,Object? longitude = null,}) {
  return _then(_self.copyWith(
storeName: null == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String,storeDescription: freezed == storeDescription ? _self.storeDescription : storeDescription // ignore: cast_nullable_to_non_nullable
as String?,storeAddress: null == storeAddress ? _self.storeAddress : storeAddress // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as MeerCity,district: freezed == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SellerSetupEvent].
extension SellerSetupEventPatterns on SellerSetupEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SellerSetupSubmitted value)?  submitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SellerSetupSubmitted() when submitted != null:
return submitted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SellerSetupSubmitted value)  submitted,}){
final _that = this;
switch (_that) {
case _SellerSetupSubmitted():
return submitted(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SellerSetupSubmitted value)?  submitted,}){
final _that = this;
switch (_that) {
case _SellerSetupSubmitted() when submitted != null:
return submitted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String storeName,  String? storeDescription,  String storeAddress,  MeerCity city,  String? district,  double latitude,  double longitude)?  submitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SellerSetupSubmitted() when submitted != null:
return submitted(_that.storeName,_that.storeDescription,_that.storeAddress,_that.city,_that.district,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String storeName,  String? storeDescription,  String storeAddress,  MeerCity city,  String? district,  double latitude,  double longitude)  submitted,}) {final _that = this;
switch (_that) {
case _SellerSetupSubmitted():
return submitted(_that.storeName,_that.storeDescription,_that.storeAddress,_that.city,_that.district,_that.latitude,_that.longitude);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String storeName,  String? storeDescription,  String storeAddress,  MeerCity city,  String? district,  double latitude,  double longitude)?  submitted,}) {final _that = this;
switch (_that) {
case _SellerSetupSubmitted() when submitted != null:
return submitted(_that.storeName,_that.storeDescription,_that.storeAddress,_that.city,_that.district,_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc


class _SellerSetupSubmitted implements SellerSetupEvent {
  const _SellerSetupSubmitted({required this.storeName, required this.storeDescription, required this.storeAddress, required this.city, required this.district, required this.latitude, required this.longitude});
  

@override final  String storeName;
@override final  String? storeDescription;
@override final  String storeAddress;
@override final  MeerCity city;
@override final  String? district;
@override final  double latitude;
@override final  double longitude;

/// Create a copy of SellerSetupEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SellerSetupSubmittedCopyWith<_SellerSetupSubmitted> get copyWith => __$SellerSetupSubmittedCopyWithImpl<_SellerSetupSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SellerSetupSubmitted&&(identical(other.storeName, storeName) || other.storeName == storeName)&&(identical(other.storeDescription, storeDescription) || other.storeDescription == storeDescription)&&(identical(other.storeAddress, storeAddress) || other.storeAddress == storeAddress)&&(identical(other.city, city) || other.city == city)&&(identical(other.district, district) || other.district == district)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode => Object.hash(runtimeType,storeName,storeDescription,storeAddress,city,district,latitude,longitude);

@override
String toString() {
  return 'SellerSetupEvent.submitted(storeName: $storeName, storeDescription: $storeDescription, storeAddress: $storeAddress, city: $city, district: $district, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$SellerSetupSubmittedCopyWith<$Res> implements $SellerSetupEventCopyWith<$Res> {
  factory _$SellerSetupSubmittedCopyWith(_SellerSetupSubmitted value, $Res Function(_SellerSetupSubmitted) _then) = __$SellerSetupSubmittedCopyWithImpl;
@override @useResult
$Res call({
 String storeName, String? storeDescription, String storeAddress, MeerCity city, String? district, double latitude, double longitude
});




}
/// @nodoc
class __$SellerSetupSubmittedCopyWithImpl<$Res>
    implements _$SellerSetupSubmittedCopyWith<$Res> {
  __$SellerSetupSubmittedCopyWithImpl(this._self, this._then);

  final _SellerSetupSubmitted _self;
  final $Res Function(_SellerSetupSubmitted) _then;

/// Create a copy of SellerSetupEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? storeName = null,Object? storeDescription = freezed,Object? storeAddress = null,Object? city = null,Object? district = freezed,Object? latitude = null,Object? longitude = null,}) {
  return _then(_SellerSetupSubmitted(
storeName: null == storeName ? _self.storeName : storeName // ignore: cast_nullable_to_non_nullable
as String,storeDescription: freezed == storeDescription ? _self.storeDescription : storeDescription // ignore: cast_nullable_to_non_nullable
as String?,storeAddress: null == storeAddress ? _self.storeAddress : storeAddress // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as MeerCity,district: freezed == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String?,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$SellerSetupState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerSetupState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellerSetupState()';
}


}

/// @nodoc
class $SellerSetupStateCopyWith<$Res>  {
$SellerSetupStateCopyWith(SellerSetupState _, $Res Function(SellerSetupState) __);
}


/// Adds pattern-matching-related methods to [SellerSetupState].
extension SellerSetupStatePatterns on SellerSetupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SellerSetupInitial value)?  initial,TResult Function( _SellerSetupSubmitting value)?  submitting,TResult Function( _SellerSetupSuccess value)?  success,TResult Function( _SellerSetupFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SellerSetupInitial() when initial != null:
return initial(_that);case _SellerSetupSubmitting() when submitting != null:
return submitting(_that);case _SellerSetupSuccess() when success != null:
return success(_that);case _SellerSetupFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SellerSetupInitial value)  initial,required TResult Function( _SellerSetupSubmitting value)  submitting,required TResult Function( _SellerSetupSuccess value)  success,required TResult Function( _SellerSetupFailure value)  failure,}){
final _that = this;
switch (_that) {
case _SellerSetupInitial():
return initial(_that);case _SellerSetupSubmitting():
return submitting(_that);case _SellerSetupSuccess():
return success(_that);case _SellerSetupFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SellerSetupInitial value)?  initial,TResult? Function( _SellerSetupSubmitting value)?  submitting,TResult? Function( _SellerSetupSuccess value)?  success,TResult? Function( _SellerSetupFailure value)?  failure,}){
final _that = this;
switch (_that) {
case _SellerSetupInitial() when initial != null:
return initial(_that);case _SellerSetupSubmitting() when submitting != null:
return submitting(_that);case _SellerSetupSuccess() when success != null:
return success(_that);case _SellerSetupFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  submitting,TResult Function( MeerUserProfile profile)?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SellerSetupInitial() when initial != null:
return initial();case _SellerSetupSubmitting() when submitting != null:
return submitting();case _SellerSetupSuccess() when success != null:
return success(_that.profile);case _SellerSetupFailure() when failure != null:
return failure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  submitting,required TResult Function( MeerUserProfile profile)  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case _SellerSetupInitial():
return initial();case _SellerSetupSubmitting():
return submitting();case _SellerSetupSuccess():
return success(_that.profile);case _SellerSetupFailure():
return failure(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  submitting,TResult? Function( MeerUserProfile profile)?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case _SellerSetupInitial() when initial != null:
return initial();case _SellerSetupSubmitting() when submitting != null:
return submitting();case _SellerSetupSuccess() when success != null:
return success(_that.profile);case _SellerSetupFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _SellerSetupInitial implements SellerSetupState {
  const _SellerSetupInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SellerSetupInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellerSetupState.initial()';
}


}




/// @nodoc


class _SellerSetupSubmitting implements SellerSetupState {
  const _SellerSetupSubmitting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SellerSetupSubmitting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellerSetupState.submitting()';
}


}




/// @nodoc


class _SellerSetupSuccess implements SellerSetupState {
  const _SellerSetupSuccess({required this.profile});
  

 final  MeerUserProfile profile;

/// Create a copy of SellerSetupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SellerSetupSuccessCopyWith<_SellerSetupSuccess> get copyWith => __$SellerSetupSuccessCopyWithImpl<_SellerSetupSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SellerSetupSuccess&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,profile);

@override
String toString() {
  return 'SellerSetupState.success(profile: $profile)';
}


}

/// @nodoc
abstract mixin class _$SellerSetupSuccessCopyWith<$Res> implements $SellerSetupStateCopyWith<$Res> {
  factory _$SellerSetupSuccessCopyWith(_SellerSetupSuccess value, $Res Function(_SellerSetupSuccess) _then) = __$SellerSetupSuccessCopyWithImpl;
@useResult
$Res call({
 MeerUserProfile profile
});




}
/// @nodoc
class __$SellerSetupSuccessCopyWithImpl<$Res>
    implements _$SellerSetupSuccessCopyWith<$Res> {
  __$SellerSetupSuccessCopyWithImpl(this._self, this._then);

  final _SellerSetupSuccess _self;
  final $Res Function(_SellerSetupSuccess) _then;

/// Create a copy of SellerSetupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profile = null,}) {
  return _then(_SellerSetupSuccess(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as MeerUserProfile,
  ));
}


}

/// @nodoc


class _SellerSetupFailure implements SellerSetupState {
  const _SellerSetupFailure(this.message);
  

 final  String message;

/// Create a copy of SellerSetupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SellerSetupFailureCopyWith<_SellerSetupFailure> get copyWith => __$SellerSetupFailureCopyWithImpl<_SellerSetupFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SellerSetupFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SellerSetupState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SellerSetupFailureCopyWith<$Res> implements $SellerSetupStateCopyWith<$Res> {
  factory _$SellerSetupFailureCopyWith(_SellerSetupFailure value, $Res Function(_SellerSetupFailure) _then) = __$SellerSetupFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$SellerSetupFailureCopyWithImpl<$Res>
    implements _$SellerSetupFailureCopyWith<$Res> {
  __$SellerSetupFailureCopyWithImpl(this._self, this._then);

  final _SellerSetupFailure _self;
  final $Res Function(_SellerSetupFailure) _then;

/// Create a copy of SellerSetupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_SellerSetupFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
