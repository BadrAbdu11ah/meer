// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CartEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CartEvent()';
}


}

/// @nodoc
class $CartEventCopyWith<$Res>  {
$CartEventCopyWith(CartEvent _, $Res Function(CartEvent) __);
}


/// Adds pattern-matching-related methods to [CartEvent].
extension CartEventPatterns on CartEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CartLoadRequested value)?  loadRequested,TResult Function( CartProductAdded value)?  productAdded,TResult Function( CartQuantityIncreased value)?  quantityIncreased,TResult Function( CartQuantityDecreased value)?  quantityDecreased,TResult Function( CartProductRemoved value)?  productRemoved,TResult Function( CartCleared value)?  cleared,TResult Function( CartMessageCleared value)?  messageCleared,TResult Function( CartResetRequested value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CartLoadRequested() when loadRequested != null:
return loadRequested(_that);case CartProductAdded() when productAdded != null:
return productAdded(_that);case CartQuantityIncreased() when quantityIncreased != null:
return quantityIncreased(_that);case CartQuantityDecreased() when quantityDecreased != null:
return quantityDecreased(_that);case CartProductRemoved() when productRemoved != null:
return productRemoved(_that);case CartCleared() when cleared != null:
return cleared(_that);case CartMessageCleared() when messageCleared != null:
return messageCleared(_that);case CartResetRequested() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CartLoadRequested value)  loadRequested,required TResult Function( CartProductAdded value)  productAdded,required TResult Function( CartQuantityIncreased value)  quantityIncreased,required TResult Function( CartQuantityDecreased value)  quantityDecreased,required TResult Function( CartProductRemoved value)  productRemoved,required TResult Function( CartCleared value)  cleared,required TResult Function( CartMessageCleared value)  messageCleared,required TResult Function( CartResetRequested value)  reset,}){
final _that = this;
switch (_that) {
case CartLoadRequested():
return loadRequested(_that);case CartProductAdded():
return productAdded(_that);case CartQuantityIncreased():
return quantityIncreased(_that);case CartQuantityDecreased():
return quantityDecreased(_that);case CartProductRemoved():
return productRemoved(_that);case CartCleared():
return cleared(_that);case CartMessageCleared():
return messageCleared(_that);case CartResetRequested():
return reset(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CartLoadRequested value)?  loadRequested,TResult? Function( CartProductAdded value)?  productAdded,TResult? Function( CartQuantityIncreased value)?  quantityIncreased,TResult? Function( CartQuantityDecreased value)?  quantityDecreased,TResult? Function( CartProductRemoved value)?  productRemoved,TResult? Function( CartCleared value)?  cleared,TResult? Function( CartMessageCleared value)?  messageCleared,TResult? Function( CartResetRequested value)?  reset,}){
final _that = this;
switch (_that) {
case CartLoadRequested() when loadRequested != null:
return loadRequested(_that);case CartProductAdded() when productAdded != null:
return productAdded(_that);case CartQuantityIncreased() when quantityIncreased != null:
return quantityIncreased(_that);case CartQuantityDecreased() when quantityDecreased != null:
return quantityDecreased(_that);case CartProductRemoved() when productRemoved != null:
return productRemoved(_that);case CartCleared() when cleared != null:
return cleared(_that);case CartMessageCleared() when messageCleared != null:
return messageCleared(_that);case CartResetRequested() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadRequested,TResult Function( Product product)?  productAdded,TResult Function( int productId)?  quantityIncreased,TResult Function( int productId)?  quantityDecreased,TResult Function( int productId)?  productRemoved,TResult Function()?  cleared,TResult Function()?  messageCleared,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CartLoadRequested() when loadRequested != null:
return loadRequested();case CartProductAdded() when productAdded != null:
return productAdded(_that.product);case CartQuantityIncreased() when quantityIncreased != null:
return quantityIncreased(_that.productId);case CartQuantityDecreased() when quantityDecreased != null:
return quantityDecreased(_that.productId);case CartProductRemoved() when productRemoved != null:
return productRemoved(_that.productId);case CartCleared() when cleared != null:
return cleared();case CartMessageCleared() when messageCleared != null:
return messageCleared();case CartResetRequested() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadRequested,required TResult Function( Product product)  productAdded,required TResult Function( int productId)  quantityIncreased,required TResult Function( int productId)  quantityDecreased,required TResult Function( int productId)  productRemoved,required TResult Function()  cleared,required TResult Function()  messageCleared,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case CartLoadRequested():
return loadRequested();case CartProductAdded():
return productAdded(_that.product);case CartQuantityIncreased():
return quantityIncreased(_that.productId);case CartQuantityDecreased():
return quantityDecreased(_that.productId);case CartProductRemoved():
return productRemoved(_that.productId);case CartCleared():
return cleared();case CartMessageCleared():
return messageCleared();case CartResetRequested():
return reset();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadRequested,TResult? Function( Product product)?  productAdded,TResult? Function( int productId)?  quantityIncreased,TResult? Function( int productId)?  quantityDecreased,TResult? Function( int productId)?  productRemoved,TResult? Function()?  cleared,TResult? Function()?  messageCleared,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case CartLoadRequested() when loadRequested != null:
return loadRequested();case CartProductAdded() when productAdded != null:
return productAdded(_that.product);case CartQuantityIncreased() when quantityIncreased != null:
return quantityIncreased(_that.productId);case CartQuantityDecreased() when quantityDecreased != null:
return quantityDecreased(_that.productId);case CartProductRemoved() when productRemoved != null:
return productRemoved(_that.productId);case CartCleared() when cleared != null:
return cleared();case CartMessageCleared() when messageCleared != null:
return messageCleared();case CartResetRequested() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class CartLoadRequested implements CartEvent {
  const CartLoadRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartLoadRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CartEvent.loadRequested()';
}


}




/// @nodoc


class CartProductAdded implements CartEvent {
  const CartProductAdded({required this.product});
  

 final  Product product;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartProductAddedCopyWith<CartProductAdded> get copyWith => _$CartProductAddedCopyWithImpl<CartProductAdded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartProductAdded&&(identical(other.product, product) || other.product == product));
}


@override
int get hashCode => Object.hash(runtimeType,product);

@override
String toString() {
  return 'CartEvent.productAdded(product: $product)';
}


}

/// @nodoc
abstract mixin class $CartProductAddedCopyWith<$Res> implements $CartEventCopyWith<$Res> {
  factory $CartProductAddedCopyWith(CartProductAdded value, $Res Function(CartProductAdded) _then) = _$CartProductAddedCopyWithImpl;
@useResult
$Res call({
 Product product
});




}
/// @nodoc
class _$CartProductAddedCopyWithImpl<$Res>
    implements $CartProductAddedCopyWith<$Res> {
  _$CartProductAddedCopyWithImpl(this._self, this._then);

  final CartProductAdded _self;
  final $Res Function(CartProductAdded) _then;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,}) {
  return _then(CartProductAdded(
product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product,
  ));
}


}

/// @nodoc


class CartQuantityIncreased implements CartEvent {
  const CartQuantityIncreased({required this.productId});
  

 final  int productId;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartQuantityIncreasedCopyWith<CartQuantityIncreased> get copyWith => _$CartQuantityIncreasedCopyWithImpl<CartQuantityIncreased>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartQuantityIncreased&&(identical(other.productId, productId) || other.productId == productId));
}


@override
int get hashCode => Object.hash(runtimeType,productId);

@override
String toString() {
  return 'CartEvent.quantityIncreased(productId: $productId)';
}


}

/// @nodoc
abstract mixin class $CartQuantityIncreasedCopyWith<$Res> implements $CartEventCopyWith<$Res> {
  factory $CartQuantityIncreasedCopyWith(CartQuantityIncreased value, $Res Function(CartQuantityIncreased) _then) = _$CartQuantityIncreasedCopyWithImpl;
@useResult
$Res call({
 int productId
});




}
/// @nodoc
class _$CartQuantityIncreasedCopyWithImpl<$Res>
    implements $CartQuantityIncreasedCopyWith<$Res> {
  _$CartQuantityIncreasedCopyWithImpl(this._self, this._then);

  final CartQuantityIncreased _self;
  final $Res Function(CartQuantityIncreased) _then;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? productId = null,}) {
  return _then(CartQuantityIncreased(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class CartQuantityDecreased implements CartEvent {
  const CartQuantityDecreased({required this.productId});
  

 final  int productId;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartQuantityDecreasedCopyWith<CartQuantityDecreased> get copyWith => _$CartQuantityDecreasedCopyWithImpl<CartQuantityDecreased>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartQuantityDecreased&&(identical(other.productId, productId) || other.productId == productId));
}


@override
int get hashCode => Object.hash(runtimeType,productId);

@override
String toString() {
  return 'CartEvent.quantityDecreased(productId: $productId)';
}


}

/// @nodoc
abstract mixin class $CartQuantityDecreasedCopyWith<$Res> implements $CartEventCopyWith<$Res> {
  factory $CartQuantityDecreasedCopyWith(CartQuantityDecreased value, $Res Function(CartQuantityDecreased) _then) = _$CartQuantityDecreasedCopyWithImpl;
@useResult
$Res call({
 int productId
});




}
/// @nodoc
class _$CartQuantityDecreasedCopyWithImpl<$Res>
    implements $CartQuantityDecreasedCopyWith<$Res> {
  _$CartQuantityDecreasedCopyWithImpl(this._self, this._then);

  final CartQuantityDecreased _self;
  final $Res Function(CartQuantityDecreased) _then;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? productId = null,}) {
  return _then(CartQuantityDecreased(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class CartProductRemoved implements CartEvent {
  const CartProductRemoved({required this.productId});
  

 final  int productId;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartProductRemovedCopyWith<CartProductRemoved> get copyWith => _$CartProductRemovedCopyWithImpl<CartProductRemoved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartProductRemoved&&(identical(other.productId, productId) || other.productId == productId));
}


@override
int get hashCode => Object.hash(runtimeType,productId);

@override
String toString() {
  return 'CartEvent.productRemoved(productId: $productId)';
}


}

/// @nodoc
abstract mixin class $CartProductRemovedCopyWith<$Res> implements $CartEventCopyWith<$Res> {
  factory $CartProductRemovedCopyWith(CartProductRemoved value, $Res Function(CartProductRemoved) _then) = _$CartProductRemovedCopyWithImpl;
@useResult
$Res call({
 int productId
});




}
/// @nodoc
class _$CartProductRemovedCopyWithImpl<$Res>
    implements $CartProductRemovedCopyWith<$Res> {
  _$CartProductRemovedCopyWithImpl(this._self, this._then);

  final CartProductRemoved _self;
  final $Res Function(CartProductRemoved) _then;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? productId = null,}) {
  return _then(CartProductRemoved(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class CartCleared implements CartEvent {
  const CartCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CartEvent.cleared()';
}


}




/// @nodoc


class CartMessageCleared implements CartEvent {
  const CartMessageCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartMessageCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CartEvent.messageCleared()';
}


}




/// @nodoc


class CartResetRequested implements CartEvent {
  const CartResetRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartResetRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CartEvent.reset()';
}


}




/// @nodoc
mixin _$CartState {

 List<CartItem> get items; bool get isLoading; String? get message;
/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartStateCopyWith<CartState> get copyWith => _$CartStateCopyWithImpl<CartState>(this as CartState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartState&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),isLoading,message);

@override
String toString() {
  return 'CartState(items: $items, isLoading: $isLoading, message: $message)';
}


}

/// @nodoc
abstract mixin class $CartStateCopyWith<$Res>  {
  factory $CartStateCopyWith(CartState value, $Res Function(CartState) _then) = _$CartStateCopyWithImpl;
@useResult
$Res call({
 List<CartItem> items, bool isLoading, String? message
});




}
/// @nodoc
class _$CartStateCopyWithImpl<$Res>
    implements $CartStateCopyWith<$Res> {
  _$CartStateCopyWithImpl(this._self, this._then);

  final CartState _self;
  final $Res Function(CartState) _then;

/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? isLoading = null,Object? message = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CartState].
extension CartStatePatterns on CartState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartState value)  $default,){
final _that = this;
switch (_that) {
case _CartState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartState value)?  $default,){
final _that = this;
switch (_that) {
case _CartState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CartItem> items,  bool isLoading,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartState() when $default != null:
return $default(_that.items,_that.isLoading,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CartItem> items,  bool isLoading,  String? message)  $default,) {final _that = this;
switch (_that) {
case _CartState():
return $default(_that.items,_that.isLoading,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CartItem> items,  bool isLoading,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _CartState() when $default != null:
return $default(_that.items,_that.isLoading,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _CartState implements CartState {
  const _CartState({final  List<CartItem> items = const <CartItem>[], this.isLoading = false, this.message}): _items = items;
  

 final  List<CartItem> _items;
@override@JsonKey() List<CartItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  bool isLoading;
@override final  String? message;

/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartStateCopyWith<_CartState> get copyWith => __$CartStateCopyWithImpl<_CartState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartState&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),isLoading,message);

@override
String toString() {
  return 'CartState(items: $items, isLoading: $isLoading, message: $message)';
}


}

/// @nodoc
abstract mixin class _$CartStateCopyWith<$Res> implements $CartStateCopyWith<$Res> {
  factory _$CartStateCopyWith(_CartState value, $Res Function(_CartState) _then) = __$CartStateCopyWithImpl;
@override @useResult
$Res call({
 List<CartItem> items, bool isLoading, String? message
});




}
/// @nodoc
class __$CartStateCopyWithImpl<$Res>
    implements _$CartStateCopyWith<$Res> {
  __$CartStateCopyWithImpl(this._self, this._then);

  final _CartState _self;
  final $Res Function(_CartState) _then;

/// Create a copy of CartState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? isLoading = null,Object? message = freezed,}) {
  return _then(_CartState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
