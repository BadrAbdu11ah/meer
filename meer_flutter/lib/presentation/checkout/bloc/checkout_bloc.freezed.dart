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

 List<CartItem> get items; String get deliveryAddress;
/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutEventCopyWith<CheckoutEvent> get copyWith => _$CheckoutEventCopyWithImpl<CheckoutEvent>(this as CheckoutEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutEvent&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),deliveryAddress);

@override
String toString() {
  return 'CheckoutEvent(items: $items, deliveryAddress: $deliveryAddress)';
}


}

/// @nodoc
abstract mixin class $CheckoutEventCopyWith<$Res>  {
  factory $CheckoutEventCopyWith(CheckoutEvent value, $Res Function(CheckoutEvent) _then) = _$CheckoutEventCopyWithImpl;
@useResult
$Res call({
 List<CartItem> items, String deliveryAddress
});




}
/// @nodoc
class _$CheckoutEventCopyWithImpl<$Res>
    implements $CheckoutEventCopyWith<$Res> {
  _$CheckoutEventCopyWithImpl(this._self, this._then);

  final CheckoutEvent _self;
  final $Res Function(CheckoutEvent) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? deliveryAddress = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,deliveryAddress: null == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CheckoutSubmitted value)?  submitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CheckoutSubmitted() when submitted != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CheckoutSubmitted value)  submitted,}){
final _that = this;
switch (_that) {
case CheckoutSubmitted():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CheckoutSubmitted value)?  submitted,}){
final _that = this;
switch (_that) {
case CheckoutSubmitted() when submitted != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<CartItem> items,  String deliveryAddress)?  submitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CheckoutSubmitted() when submitted != null:
return submitted(_that.items,_that.deliveryAddress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<CartItem> items,  String deliveryAddress)  submitted,}) {final _that = this;
switch (_that) {
case CheckoutSubmitted():
return submitted(_that.items,_that.deliveryAddress);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<CartItem> items,  String deliveryAddress)?  submitted,}) {final _that = this;
switch (_that) {
case CheckoutSubmitted() when submitted != null:
return submitted(_that.items,_that.deliveryAddress);case _:
  return null;

}
}

}

/// @nodoc


class CheckoutSubmitted implements CheckoutEvent {
  const CheckoutSubmitted({required final  List<CartItem> items, required this.deliveryAddress}): _items = items;
  

 final  List<CartItem> _items;
@override List<CartItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String deliveryAddress;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutSubmittedCopyWith<CheckoutSubmitted> get copyWith => _$CheckoutSubmittedCopyWithImpl<CheckoutSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutSubmitted&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),deliveryAddress);

@override
String toString() {
  return 'CheckoutEvent.submitted(items: $items, deliveryAddress: $deliveryAddress)';
}


}

/// @nodoc
abstract mixin class $CheckoutSubmittedCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory $CheckoutSubmittedCopyWith(CheckoutSubmitted value, $Res Function(CheckoutSubmitted) _then) = _$CheckoutSubmittedCopyWithImpl;
@override @useResult
$Res call({
 List<CartItem> items, String deliveryAddress
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
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? deliveryAddress = null,}) {
  return _then(CheckoutSubmitted(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,deliveryAddress: null == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CheckoutInitial value)?  initial,TResult Function( CheckoutSubmitting value)?  submitting,TResult Function( CheckoutSuccess value)?  success,TResult Function( CheckoutFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CheckoutInitial() when initial != null:
return initial(_that);case CheckoutSubmitting() when submitting != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CheckoutInitial value)  initial,required TResult Function( CheckoutSubmitting value)  submitting,required TResult Function( CheckoutSuccess value)  success,required TResult Function( CheckoutFailure value)  failure,}){
final _that = this;
switch (_that) {
case CheckoutInitial():
return initial(_that);case CheckoutSubmitting():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CheckoutInitial value)?  initial,TResult? Function( CheckoutSubmitting value)?  submitting,TResult? Function( CheckoutSuccess value)?  success,TResult? Function( CheckoutFailure value)?  failure,}){
final _that = this;
switch (_that) {
case CheckoutInitial() when initial != null:
return initial(_that);case CheckoutSubmitting() when submitting != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  submitting,TResult Function( OrderInfo order)?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CheckoutInitial() when initial != null:
return initial();case CheckoutSubmitting() when submitting != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  submitting,required TResult Function( OrderInfo order)  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case CheckoutInitial():
return initial();case CheckoutSubmitting():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  submitting,TResult? Function( OrderInfo order)?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case CheckoutInitial() when initial != null:
return initial();case CheckoutSubmitting() when submitting != null:
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
