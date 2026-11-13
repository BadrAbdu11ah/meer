// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckoutEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutEvent()';
}


}

/// @nodoc
class $CheckoutEventCopyWith<$Res>  {
$CheckoutEventCopyWith(CheckoutEvent _, $Res Function(CheckoutEvent) __);
}


/// Adds pattern-matching-related methods to [CheckoutEvent].
extension CheckoutEventPatterns on CheckoutEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CheckoutStarted value)?  started,TResult Function( CheckoutLocationRequested value)?  locationRequested,TResult Function( CheckoutFulfillmentMethodChanged value)?  fulfillmentMethodChanged,TResult Function( CheckoutSubmitted value)?  submitted,TResult Function( CheckoutPhoneCodeRequested value)?  phoneCodeRequested,TResult Function( CheckoutPhoneVerificationSubmitted value)?  phoneVerificationSubmitted,TResult Function( CheckoutAddressChanged value)?  addressChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CheckoutStarted() when started != null:
return started(_that);case CheckoutLocationRequested() when locationRequested != null:
return locationRequested(_that);case CheckoutFulfillmentMethodChanged() when fulfillmentMethodChanged != null:
return fulfillmentMethodChanged(_that);case CheckoutSubmitted() when submitted != null:
return submitted(_that);case CheckoutPhoneCodeRequested() when phoneCodeRequested != null:
return phoneCodeRequested(_that);case CheckoutPhoneVerificationSubmitted() when phoneVerificationSubmitted != null:
return phoneVerificationSubmitted(_that);case CheckoutAddressChanged() when addressChanged != null:
return addressChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CheckoutStarted value)  started,required TResult Function( CheckoutLocationRequested value)  locationRequested,required TResult Function( CheckoutFulfillmentMethodChanged value)  fulfillmentMethodChanged,required TResult Function( CheckoutSubmitted value)  submitted,required TResult Function( CheckoutPhoneCodeRequested value)  phoneCodeRequested,required TResult Function( CheckoutPhoneVerificationSubmitted value)  phoneVerificationSubmitted,required TResult Function( CheckoutAddressChanged value)  addressChanged,}){
final _that = this;
switch (_that) {
case CheckoutStarted():
return started(_that);case CheckoutLocationRequested():
return locationRequested(_that);case CheckoutFulfillmentMethodChanged():
return fulfillmentMethodChanged(_that);case CheckoutSubmitted():
return submitted(_that);case CheckoutPhoneCodeRequested():
return phoneCodeRequested(_that);case CheckoutPhoneVerificationSubmitted():
return phoneVerificationSubmitted(_that);case CheckoutAddressChanged():
return addressChanged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CheckoutStarted value)?  started,TResult? Function( CheckoutLocationRequested value)?  locationRequested,TResult? Function( CheckoutFulfillmentMethodChanged value)?  fulfillmentMethodChanged,TResult? Function( CheckoutSubmitted value)?  submitted,TResult? Function( CheckoutPhoneCodeRequested value)?  phoneCodeRequested,TResult? Function( CheckoutPhoneVerificationSubmitted value)?  phoneVerificationSubmitted,TResult? Function( CheckoutAddressChanged value)?  addressChanged,}){
final _that = this;
switch (_that) {
case CheckoutStarted() when started != null:
return started(_that);case CheckoutLocationRequested() when locationRequested != null:
return locationRequested(_that);case CheckoutFulfillmentMethodChanged() when fulfillmentMethodChanged != null:
return fulfillmentMethodChanged(_that);case CheckoutSubmitted() when submitted != null:
return submitted(_that);case CheckoutPhoneCodeRequested() when phoneCodeRequested != null:
return phoneCodeRequested(_that);case CheckoutPhoneVerificationSubmitted() when phoneVerificationSubmitted != null:
return phoneVerificationSubmitted(_that);case CheckoutAddressChanged() when addressChanged != null:
return addressChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int sellerId)?  started,TResult Function()?  locationRequested,TResult Function( String method)?  fulfillmentMethodChanged,TResult Function( List<CartItem> items,  String? deliveryAddress,  double? latitude,  double? longitude)?  submitted,TResult Function( String phone)?  phoneCodeRequested,TResult Function( String phone,  String code)?  phoneVerificationSubmitted,TResult Function( String address)?  addressChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CheckoutStarted() when started != null:
return started(_that.sellerId);case CheckoutLocationRequested() when locationRequested != null:
return locationRequested();case CheckoutFulfillmentMethodChanged() when fulfillmentMethodChanged != null:
return fulfillmentMethodChanged(_that.method);case CheckoutSubmitted() when submitted != null:
return submitted(_that.items,_that.deliveryAddress,_that.latitude,_that.longitude);case CheckoutPhoneCodeRequested() when phoneCodeRequested != null:
return phoneCodeRequested(_that.phone);case CheckoutPhoneVerificationSubmitted() when phoneVerificationSubmitted != null:
return phoneVerificationSubmitted(_that.phone,_that.code);case CheckoutAddressChanged() when addressChanged != null:
return addressChanged(_that.address);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int sellerId)  started,required TResult Function()  locationRequested,required TResult Function( String method)  fulfillmentMethodChanged,required TResult Function( List<CartItem> items,  String? deliveryAddress,  double? latitude,  double? longitude)  submitted,required TResult Function( String phone)  phoneCodeRequested,required TResult Function( String phone,  String code)  phoneVerificationSubmitted,required TResult Function( String address)  addressChanged,}) {final _that = this;
switch (_that) {
case CheckoutStarted():
return started(_that.sellerId);case CheckoutLocationRequested():
return locationRequested();case CheckoutFulfillmentMethodChanged():
return fulfillmentMethodChanged(_that.method);case CheckoutSubmitted():
return submitted(_that.items,_that.deliveryAddress,_that.latitude,_that.longitude);case CheckoutPhoneCodeRequested():
return phoneCodeRequested(_that.phone);case CheckoutPhoneVerificationSubmitted():
return phoneVerificationSubmitted(_that.phone,_that.code);case CheckoutAddressChanged():
return addressChanged(_that.address);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int sellerId)?  started,TResult? Function()?  locationRequested,TResult? Function( String method)?  fulfillmentMethodChanged,TResult? Function( List<CartItem> items,  String? deliveryAddress,  double? latitude,  double? longitude)?  submitted,TResult? Function( String phone)?  phoneCodeRequested,TResult? Function( String phone,  String code)?  phoneVerificationSubmitted,TResult? Function( String address)?  addressChanged,}) {final _that = this;
switch (_that) {
case CheckoutStarted() when started != null:
return started(_that.sellerId);case CheckoutLocationRequested() when locationRequested != null:
return locationRequested();case CheckoutFulfillmentMethodChanged() when fulfillmentMethodChanged != null:
return fulfillmentMethodChanged(_that.method);case CheckoutSubmitted() when submitted != null:
return submitted(_that.items,_that.deliveryAddress,_that.latitude,_that.longitude);case CheckoutPhoneCodeRequested() when phoneCodeRequested != null:
return phoneCodeRequested(_that.phone);case CheckoutPhoneVerificationSubmitted() when phoneVerificationSubmitted != null:
return phoneVerificationSubmitted(_that.phone,_that.code);case CheckoutAddressChanged() when addressChanged != null:
return addressChanged(_that.address);case _:
  return null;

}
}

}

/// @nodoc


class CheckoutStarted implements CheckoutEvent {
  const CheckoutStarted({required this.sellerId});
  

 final  int sellerId;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutStartedCopyWith<CheckoutStarted> get copyWith => _$CheckoutStartedCopyWithImpl<CheckoutStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutStarted&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId));
}


@override
int get hashCode => Object.hash(runtimeType,sellerId);

@override
String toString() {
  return 'CheckoutEvent.started(sellerId: $sellerId)';
}


}

/// @nodoc
abstract mixin class $CheckoutStartedCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory $CheckoutStartedCopyWith(CheckoutStarted value, $Res Function(CheckoutStarted) _then) = _$CheckoutStartedCopyWithImpl;
@useResult
$Res call({
 int sellerId
});




}
/// @nodoc
class _$CheckoutStartedCopyWithImpl<$Res>
    implements $CheckoutStartedCopyWith<$Res> {
  _$CheckoutStartedCopyWithImpl(this._self, this._then);

  final CheckoutStarted _self;
  final $Res Function(CheckoutStarted) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sellerId = null,}) {
  return _then(CheckoutStarted(
sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class CheckoutLocationRequested implements CheckoutEvent {
  const CheckoutLocationRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutLocationRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutEvent.locationRequested()';
}


}




/// @nodoc


class CheckoutFulfillmentMethodChanged implements CheckoutEvent {
  const CheckoutFulfillmentMethodChanged({required this.method});
  

 final  String method;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutFulfillmentMethodChangedCopyWith<CheckoutFulfillmentMethodChanged> get copyWith => _$CheckoutFulfillmentMethodChangedCopyWithImpl<CheckoutFulfillmentMethodChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutFulfillmentMethodChanged&&(identical(other.method, method) || other.method == method));
}


@override
int get hashCode => Object.hash(runtimeType,method);

@override
String toString() {
  return 'CheckoutEvent.fulfillmentMethodChanged(method: $method)';
}


}

/// @nodoc
abstract mixin class $CheckoutFulfillmentMethodChangedCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory $CheckoutFulfillmentMethodChangedCopyWith(CheckoutFulfillmentMethodChanged value, $Res Function(CheckoutFulfillmentMethodChanged) _then) = _$CheckoutFulfillmentMethodChangedCopyWithImpl;
@useResult
$Res call({
 String method
});




}
/// @nodoc
class _$CheckoutFulfillmentMethodChangedCopyWithImpl<$Res>
    implements $CheckoutFulfillmentMethodChangedCopyWith<$Res> {
  _$CheckoutFulfillmentMethodChangedCopyWithImpl(this._self, this._then);

  final CheckoutFulfillmentMethodChanged _self;
  final $Res Function(CheckoutFulfillmentMethodChanged) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? method = null,}) {
  return _then(CheckoutFulfillmentMethodChanged(
method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CheckoutSubmitted implements CheckoutEvent {
  const CheckoutSubmitted({required final  List<CartItem> items, this.deliveryAddress, this.latitude, this.longitude}): _items = items;
  

 final  List<CartItem> _items;
 List<CartItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  String? deliveryAddress;
 final  double? latitude;
 final  double? longitude;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutSubmittedCopyWith<CheckoutSubmitted> get copyWith => _$CheckoutSubmittedCopyWithImpl<CheckoutSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutSubmitted&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),deliveryAddress,latitude,longitude);

@override
String toString() {
  return 'CheckoutEvent.submitted(items: $items, deliveryAddress: $deliveryAddress, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $CheckoutSubmittedCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory $CheckoutSubmittedCopyWith(CheckoutSubmitted value, $Res Function(CheckoutSubmitted) _then) = _$CheckoutSubmittedCopyWithImpl;
@useResult
$Res call({
 List<CartItem> items, String? deliveryAddress, double? latitude, double? longitude
});




}
/// @nodoc
class _$CheckoutSubmittedCopyWithImpl<$Res>
    implements $CheckoutSubmittedCopyWith<$Res> {
  _$CheckoutSubmittedCopyWithImpl(this._self, this._then);

  final CheckoutSubmitted _self;
  final $Res Function(CheckoutSubmitted) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,Object? deliveryAddress = freezed,Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(CheckoutSubmitted(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,deliveryAddress: freezed == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc


class CheckoutPhoneCodeRequested implements CheckoutEvent {
  const CheckoutPhoneCodeRequested({required this.phone});
  

 final  String phone;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutPhoneCodeRequestedCopyWith<CheckoutPhoneCodeRequested> get copyWith => _$CheckoutPhoneCodeRequestedCopyWithImpl<CheckoutPhoneCodeRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutPhoneCodeRequested&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode => Object.hash(runtimeType,phone);

@override
String toString() {
  return 'CheckoutEvent.phoneCodeRequested(phone: $phone)';
}


}

/// @nodoc
abstract mixin class $CheckoutPhoneCodeRequestedCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory $CheckoutPhoneCodeRequestedCopyWith(CheckoutPhoneCodeRequested value, $Res Function(CheckoutPhoneCodeRequested) _then) = _$CheckoutPhoneCodeRequestedCopyWithImpl;
@useResult
$Res call({
 String phone
});




}
/// @nodoc
class _$CheckoutPhoneCodeRequestedCopyWithImpl<$Res>
    implements $CheckoutPhoneCodeRequestedCopyWith<$Res> {
  _$CheckoutPhoneCodeRequestedCopyWithImpl(this._self, this._then);

  final CheckoutPhoneCodeRequested _self;
  final $Res Function(CheckoutPhoneCodeRequested) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phone = null,}) {
  return _then(CheckoutPhoneCodeRequested(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CheckoutPhoneVerificationSubmitted implements CheckoutEvent {
  const CheckoutPhoneVerificationSubmitted({required this.phone, required this.code});
  

 final  String phone;
 final  String code;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutPhoneVerificationSubmittedCopyWith<CheckoutPhoneVerificationSubmitted> get copyWith => _$CheckoutPhoneVerificationSubmittedCopyWithImpl<CheckoutPhoneVerificationSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutPhoneVerificationSubmitted&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode => Object.hash(runtimeType,phone,code);

@override
String toString() {
  return 'CheckoutEvent.phoneVerificationSubmitted(phone: $phone, code: $code)';
}


}

/// @nodoc
abstract mixin class $CheckoutPhoneVerificationSubmittedCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory $CheckoutPhoneVerificationSubmittedCopyWith(CheckoutPhoneVerificationSubmitted value, $Res Function(CheckoutPhoneVerificationSubmitted) _then) = _$CheckoutPhoneVerificationSubmittedCopyWithImpl;
@useResult
$Res call({
 String phone, String code
});




}
/// @nodoc
class _$CheckoutPhoneVerificationSubmittedCopyWithImpl<$Res>
    implements $CheckoutPhoneVerificationSubmittedCopyWith<$Res> {
  _$CheckoutPhoneVerificationSubmittedCopyWithImpl(this._self, this._then);

  final CheckoutPhoneVerificationSubmitted _self;
  final $Res Function(CheckoutPhoneVerificationSubmitted) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phone = null,Object? code = null,}) {
  return _then(CheckoutPhoneVerificationSubmitted(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CheckoutAddressChanged implements CheckoutEvent {
  const CheckoutAddressChanged({required this.address});
  

 final  String address;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutAddressChangedCopyWith<CheckoutAddressChanged> get copyWith => _$CheckoutAddressChangedCopyWithImpl<CheckoutAddressChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutAddressChanged&&(identical(other.address, address) || other.address == address));
}


@override
int get hashCode => Object.hash(runtimeType,address);

@override
String toString() {
  return 'CheckoutEvent.addressChanged(address: $address)';
}


}

/// @nodoc
abstract mixin class $CheckoutAddressChangedCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory $CheckoutAddressChangedCopyWith(CheckoutAddressChanged value, $Res Function(CheckoutAddressChanged) _then) = _$CheckoutAddressChangedCopyWithImpl;
@useResult
$Res call({
 String address
});




}
/// @nodoc
class _$CheckoutAddressChangedCopyWithImpl<$Res>
    implements $CheckoutAddressChangedCopyWith<$Res> {
  _$CheckoutAddressChangedCopyWithImpl(this._self, this._then);

  final CheckoutAddressChanged _self;
  final $Res Function(CheckoutAddressChanged) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? address = null,}) {
  return _then(CheckoutAddressChanged(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$CheckoutState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState()';
}


}

/// @nodoc
class $CheckoutStateCopyWith<$Res>  {
$CheckoutStateCopyWith(CheckoutState _, $Res Function(CheckoutState) __);
}


/// Adds pattern-matching-related methods to [CheckoutState].
extension CheckoutStatePatterns on CheckoutState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CheckoutInitial value)?  initial,TResult Function( CheckoutLocating value)?  locating,TResult Function( CheckoutReady value)?  ready,TResult Function( CheckoutSubmitting value)?  submitting,TResult Function( CheckoutSuccess value)?  success,TResult Function( CheckoutFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CheckoutInitial() when initial != null:
return initial(_that);case CheckoutLocating() when locating != null:
return locating(_that);case CheckoutReady() when ready != null:
return ready(_that);case CheckoutSubmitting() when submitting != null:
return submitting(_that);case CheckoutSuccess() when success != null:
return success(_that);case CheckoutFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CheckoutInitial value)  initial,required TResult Function( CheckoutLocating value)  locating,required TResult Function( CheckoutReady value)  ready,required TResult Function( CheckoutSubmitting value)  submitting,required TResult Function( CheckoutSuccess value)  success,required TResult Function( CheckoutFailure value)  failure,}){
final _that = this;
switch (_that) {
case CheckoutInitial():
return initial(_that);case CheckoutLocating():
return locating(_that);case CheckoutReady():
return ready(_that);case CheckoutSubmitting():
return submitting(_that);case CheckoutSuccess():
return success(_that);case CheckoutFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CheckoutInitial value)?  initial,TResult? Function( CheckoutLocating value)?  locating,TResult? Function( CheckoutReady value)?  ready,TResult? Function( CheckoutSubmitting value)?  submitting,TResult? Function( CheckoutSuccess value)?  success,TResult? Function( CheckoutFailure value)?  failure,}){
final _that = this;
switch (_that) {
case CheckoutInitial() when initial != null:
return initial(_that);case CheckoutLocating() when locating != null:
return locating(_that);case CheckoutReady() when ready != null:
return ready(_that);case CheckoutSubmitting() when submitting != null:
return submitting(_that);case CheckoutSuccess() when success != null:
return success(_that);case CheckoutFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  locating,TResult Function( String? address,  double? latitude,  double? longitude,  bool sellerOffersDelivery,  double sellerDeliveryFee,  String fulfillmentMethod,  String phone,  bool isPhoneVerified,  bool isSendingPhoneCode,  bool isPhoneCodeSent,  bool isVerifyingPhone,  String? errorMessage)?  ready,TResult Function()?  submitting,TResult Function( OrderInfo order)?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CheckoutInitial() when initial != null:
return initial();case CheckoutLocating() when locating != null:
return locating();case CheckoutReady() when ready != null:
return ready(_that.address,_that.latitude,_that.longitude,_that.sellerOffersDelivery,_that.sellerDeliveryFee,_that.fulfillmentMethod,_that.phone,_that.isPhoneVerified,_that.isSendingPhoneCode,_that.isPhoneCodeSent,_that.isVerifyingPhone,_that.errorMessage);case CheckoutSubmitting() when submitting != null:
return submitting();case CheckoutSuccess() when success != null:
return success(_that.order);case CheckoutFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  locating,required TResult Function( String? address,  double? latitude,  double? longitude,  bool sellerOffersDelivery,  double sellerDeliveryFee,  String fulfillmentMethod,  String phone,  bool isPhoneVerified,  bool isSendingPhoneCode,  bool isPhoneCodeSent,  bool isVerifyingPhone,  String? errorMessage)  ready,required TResult Function()  submitting,required TResult Function( OrderInfo order)  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case CheckoutInitial():
return initial();case CheckoutLocating():
return locating();case CheckoutReady():
return ready(_that.address,_that.latitude,_that.longitude,_that.sellerOffersDelivery,_that.sellerDeliveryFee,_that.fulfillmentMethod,_that.phone,_that.isPhoneVerified,_that.isSendingPhoneCode,_that.isPhoneCodeSent,_that.isVerifyingPhone,_that.errorMessage);case CheckoutSubmitting():
return submitting();case CheckoutSuccess():
return success(_that.order);case CheckoutFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  locating,TResult? Function( String? address,  double? latitude,  double? longitude,  bool sellerOffersDelivery,  double sellerDeliveryFee,  String fulfillmentMethod,  String phone,  bool isPhoneVerified,  bool isSendingPhoneCode,  bool isPhoneCodeSent,  bool isVerifyingPhone,  String? errorMessage)?  ready,TResult? Function()?  submitting,TResult? Function( OrderInfo order)?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case CheckoutInitial() when initial != null:
return initial();case CheckoutLocating() when locating != null:
return locating();case CheckoutReady() when ready != null:
return ready(_that.address,_that.latitude,_that.longitude,_that.sellerOffersDelivery,_that.sellerDeliveryFee,_that.fulfillmentMethod,_that.phone,_that.isPhoneVerified,_that.isSendingPhoneCode,_that.isPhoneCodeSent,_that.isVerifyingPhone,_that.errorMessage);case CheckoutSubmitting() when submitting != null:
return submitting();case CheckoutSuccess() when success != null:
return success(_that.order);case CheckoutFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class CheckoutInitial implements CheckoutState {
  const CheckoutInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.initial()';
}


}




/// @nodoc


class CheckoutLocating implements CheckoutState {
  const CheckoutLocating();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutLocating);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.locating()';
}


}




/// @nodoc


class CheckoutReady implements CheckoutState {
  const CheckoutReady({this.address, this.latitude, this.longitude, this.sellerOffersDelivery = false, this.sellerDeliveryFee = 0, this.fulfillmentMethod = 'pickup', this.phone = '', this.isPhoneVerified = false, this.isSendingPhoneCode = false, this.isPhoneCodeSent = false, this.isVerifyingPhone = false, this.errorMessage});
  

 final  String? address;
 final  double? latitude;
 final  double? longitude;
// إعدادات الأسرة.
@JsonKey() final  bool sellerOffersDelivery;
@JsonKey() final  double sellerDeliveryFee;
// طريقة التنفيذ المختارة.
@JsonKey() final  String fulfillmentMethod;
// بيانات الهاتف.
@JsonKey() final  String phone;
@JsonKey() final  bool isPhoneVerified;
@JsonKey() final  bool isSendingPhoneCode;
@JsonKey() final  bool isPhoneCodeSent;
@JsonKey() final  bool isVerifyingPhone;
 final  String? errorMessage;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutReadyCopyWith<CheckoutReady> get copyWith => _$CheckoutReadyCopyWithImpl<CheckoutReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutReady&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.sellerOffersDelivery, sellerOffersDelivery) || other.sellerOffersDelivery == sellerOffersDelivery)&&(identical(other.sellerDeliveryFee, sellerDeliveryFee) || other.sellerDeliveryFee == sellerDeliveryFee)&&(identical(other.fulfillmentMethod, fulfillmentMethod) || other.fulfillmentMethod == fulfillmentMethod)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.isPhoneVerified, isPhoneVerified) || other.isPhoneVerified == isPhoneVerified)&&(identical(other.isSendingPhoneCode, isSendingPhoneCode) || other.isSendingPhoneCode == isSendingPhoneCode)&&(identical(other.isPhoneCodeSent, isPhoneCodeSent) || other.isPhoneCodeSent == isPhoneCodeSent)&&(identical(other.isVerifyingPhone, isVerifyingPhone) || other.isVerifyingPhone == isVerifyingPhone)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,address,latitude,longitude,sellerOffersDelivery,sellerDeliveryFee,fulfillmentMethod,phone,isPhoneVerified,isSendingPhoneCode,isPhoneCodeSent,isVerifyingPhone,errorMessage);

@override
String toString() {
  return 'CheckoutState.ready(address: $address, latitude: $latitude, longitude: $longitude, sellerOffersDelivery: $sellerOffersDelivery, sellerDeliveryFee: $sellerDeliveryFee, fulfillmentMethod: $fulfillmentMethod, phone: $phone, isPhoneVerified: $isPhoneVerified, isSendingPhoneCode: $isSendingPhoneCode, isPhoneCodeSent: $isPhoneCodeSent, isVerifyingPhone: $isVerifyingPhone, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CheckoutReadyCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $CheckoutReadyCopyWith(CheckoutReady value, $Res Function(CheckoutReady) _then) = _$CheckoutReadyCopyWithImpl;
@useResult
$Res call({
 String? address, double? latitude, double? longitude, bool sellerOffersDelivery, double sellerDeliveryFee, String fulfillmentMethod, String phone, bool isPhoneVerified, bool isSendingPhoneCode, bool isPhoneCodeSent, bool isVerifyingPhone, String? errorMessage
});




}
/// @nodoc
class _$CheckoutReadyCopyWithImpl<$Res>
    implements $CheckoutReadyCopyWith<$Res> {
  _$CheckoutReadyCopyWithImpl(this._self, this._then);

  final CheckoutReady _self;
  final $Res Function(CheckoutReady) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? address = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? sellerOffersDelivery = null,Object? sellerDeliveryFee = null,Object? fulfillmentMethod = null,Object? phone = null,Object? isPhoneVerified = null,Object? isSendingPhoneCode = null,Object? isPhoneCodeSent = null,Object? isVerifyingPhone = null,Object? errorMessage = freezed,}) {
  return _then(CheckoutReady(
address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,sellerOffersDelivery: null == sellerOffersDelivery ? _self.sellerOffersDelivery : sellerOffersDelivery // ignore: cast_nullable_to_non_nullable
as bool,sellerDeliveryFee: null == sellerDeliveryFee ? _self.sellerDeliveryFee : sellerDeliveryFee // ignore: cast_nullable_to_non_nullable
as double,fulfillmentMethod: null == fulfillmentMethod ? _self.fulfillmentMethod : fulfillmentMethod // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,isPhoneVerified: null == isPhoneVerified ? _self.isPhoneVerified : isPhoneVerified // ignore: cast_nullable_to_non_nullable
as bool,isSendingPhoneCode: null == isSendingPhoneCode ? _self.isSendingPhoneCode : isSendingPhoneCode // ignore: cast_nullable_to_non_nullable
as bool,isPhoneCodeSent: null == isPhoneCodeSent ? _self.isPhoneCodeSent : isPhoneCodeSent // ignore: cast_nullable_to_non_nullable
as bool,isVerifyingPhone: null == isVerifyingPhone ? _self.isVerifyingPhone : isVerifyingPhone // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class CheckoutSubmitting implements CheckoutState {
  const CheckoutSubmitting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutSubmitting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.submitting()';
}


}




/// @nodoc


class CheckoutSuccess implements CheckoutState {
  const CheckoutSuccess(this.order);
  

 final  OrderInfo order;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutSuccessCopyWith<CheckoutSuccess> get copyWith => _$CheckoutSuccessCopyWithImpl<CheckoutSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutSuccess&&(identical(other.order, order) || other.order == order));
}


@override
int get hashCode => Object.hash(runtimeType,order);

@override
String toString() {
  return 'CheckoutState.success(order: $order)';
}


}

/// @nodoc
abstract mixin class $CheckoutSuccessCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $CheckoutSuccessCopyWith(CheckoutSuccess value, $Res Function(CheckoutSuccess) _then) = _$CheckoutSuccessCopyWithImpl;
@useResult
$Res call({
 OrderInfo order
});




}
/// @nodoc
class _$CheckoutSuccessCopyWithImpl<$Res>
    implements $CheckoutSuccessCopyWith<$Res> {
  _$CheckoutSuccessCopyWithImpl(this._self, this._then);

  final CheckoutSuccess _self;
  final $Res Function(CheckoutSuccess) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? order = null,}) {
  return _then(CheckoutSuccess(
null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as OrderInfo,
  ));
}


}

/// @nodoc


class CheckoutFailure implements CheckoutState {
  const CheckoutFailure(this.message);
  

 final  String message;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutFailureCopyWith<CheckoutFailure> get copyWith => _$CheckoutFailureCopyWithImpl<CheckoutFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CheckoutState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $CheckoutFailureCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $CheckoutFailureCopyWith(CheckoutFailure value, $Res Function(CheckoutFailure) _then) = _$CheckoutFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CheckoutFailureCopyWithImpl<$Res>
    implements $CheckoutFailureCopyWith<$Res> {
  _$CheckoutFailureCopyWithImpl(this._self, this._then);

  final CheckoutFailure _self;
  final $Res Function(CheckoutFailure) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CheckoutFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
