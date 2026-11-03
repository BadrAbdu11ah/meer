// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorites_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FavoritesEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FavoritesEvent()';
}


}

/// @nodoc
class $FavoritesEventCopyWith<$Res>  {
$FavoritesEventCopyWith(FavoritesEvent _, $Res Function(FavoritesEvent) __);
}


/// Adds pattern-matching-related methods to [FavoritesEvent].
extension FavoritesEventPatterns on FavoritesEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FavoriteProductToggled value)?  productToggled,TResult Function( FavoritesCleared value)?  cleared,TResult Function( FavoritesMessageCleared value)?  messageCleared,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FavoriteProductToggled() when productToggled != null:
return productToggled(_that);case FavoritesCleared() when cleared != null:
return cleared(_that);case FavoritesMessageCleared() when messageCleared != null:
return messageCleared(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FavoriteProductToggled value)  productToggled,required TResult Function( FavoritesCleared value)  cleared,required TResult Function( FavoritesMessageCleared value)  messageCleared,}){
final _that = this;
switch (_that) {
case FavoriteProductToggled():
return productToggled(_that);case FavoritesCleared():
return cleared(_that);case FavoritesMessageCleared():
return messageCleared(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FavoriteProductToggled value)?  productToggled,TResult? Function( FavoritesCleared value)?  cleared,TResult? Function( FavoritesMessageCleared value)?  messageCleared,}){
final _that = this;
switch (_that) {
case FavoriteProductToggled() when productToggled != null:
return productToggled(_that);case FavoritesCleared() when cleared != null:
return cleared(_that);case FavoritesMessageCleared() when messageCleared != null:
return messageCleared(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Product product)?  productToggled,TResult Function()?  cleared,TResult Function()?  messageCleared,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FavoriteProductToggled() when productToggled != null:
return productToggled(_that.product);case FavoritesCleared() when cleared != null:
return cleared();case FavoritesMessageCleared() when messageCleared != null:
return messageCleared();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Product product)  productToggled,required TResult Function()  cleared,required TResult Function()  messageCleared,}) {final _that = this;
switch (_that) {
case FavoriteProductToggled():
return productToggled(_that.product);case FavoritesCleared():
return cleared();case FavoritesMessageCleared():
return messageCleared();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Product product)?  productToggled,TResult? Function()?  cleared,TResult? Function()?  messageCleared,}) {final _that = this;
switch (_that) {
case FavoriteProductToggled() when productToggled != null:
return productToggled(_that.product);case FavoritesCleared() when cleared != null:
return cleared();case FavoritesMessageCleared() when messageCleared != null:
return messageCleared();case _:
  return null;

}
}

}

/// @nodoc


class FavoriteProductToggled implements FavoritesEvent {
  const FavoriteProductToggled({required this.product});
  

 final  Product product;

/// Create a copy of FavoritesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteProductToggledCopyWith<FavoriteProductToggled> get copyWith => _$FavoriteProductToggledCopyWithImpl<FavoriteProductToggled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteProductToggled&&(identical(other.product, product) || other.product == product));
}


@override
int get hashCode => Object.hash(runtimeType,product);

@override
String toString() {
  return 'FavoritesEvent.productToggled(product: $product)';
}


}

/// @nodoc
abstract mixin class $FavoriteProductToggledCopyWith<$Res> implements $FavoritesEventCopyWith<$Res> {
  factory $FavoriteProductToggledCopyWith(FavoriteProductToggled value, $Res Function(FavoriteProductToggled) _then) = _$FavoriteProductToggledCopyWithImpl;
@useResult
$Res call({
 Product product
});




}
/// @nodoc
class _$FavoriteProductToggledCopyWithImpl<$Res>
    implements $FavoriteProductToggledCopyWith<$Res> {
  _$FavoriteProductToggledCopyWithImpl(this._self, this._then);

  final FavoriteProductToggled _self;
  final $Res Function(FavoriteProductToggled) _then;

/// Create a copy of FavoritesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,}) {
  return _then(FavoriteProductToggled(
product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product,
  ));
}


}

/// @nodoc


class FavoritesCleared implements FavoritesEvent {
  const FavoritesCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FavoritesEvent.cleared()';
}


}




/// @nodoc


class FavoritesMessageCleared implements FavoritesEvent {
  const FavoritesMessageCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesMessageCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FavoritesEvent.messageCleared()';
}


}




/// @nodoc
mixin _$FavoritesState {

 List<Product> get products; String? get message;
/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoritesStateCopyWith<FavoritesState> get copyWith => _$FavoritesStateCopyWithImpl<FavoritesState>(this as FavoritesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesState&&const DeepCollectionEquality().equals(other.products, products)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(products),message);

@override
String toString() {
  return 'FavoritesState(products: $products, message: $message)';
}


}

/// @nodoc
abstract mixin class $FavoritesStateCopyWith<$Res>  {
  factory $FavoritesStateCopyWith(FavoritesState value, $Res Function(FavoritesState) _then) = _$FavoritesStateCopyWithImpl;
@useResult
$Res call({
 List<Product> products, String? message
});




}
/// @nodoc
class _$FavoritesStateCopyWithImpl<$Res>
    implements $FavoritesStateCopyWith<$Res> {
  _$FavoritesStateCopyWithImpl(this._self, this._then);

  final FavoritesState _self;
  final $Res Function(FavoritesState) _then;

/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? products = null,Object? message = freezed,}) {
  return _then(_self.copyWith(
products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<Product>,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoritesState].
extension FavoritesStatePatterns on FavoritesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoritesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoritesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoritesState value)  $default,){
final _that = this;
switch (_that) {
case _FavoritesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoritesState value)?  $default,){
final _that = this;
switch (_that) {
case _FavoritesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Product> products,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoritesState() when $default != null:
return $default(_that.products,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Product> products,  String? message)  $default,) {final _that = this;
switch (_that) {
case _FavoritesState():
return $default(_that.products,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Product> products,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _FavoritesState() when $default != null:
return $default(_that.products,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _FavoritesState implements FavoritesState {
  const _FavoritesState({final  List<Product> products = const <Product>[], this.message}): _products = products;
  

 final  List<Product> _products;
@override@JsonKey() List<Product> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

@override final  String? message;

/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoritesStateCopyWith<_FavoritesState> get copyWith => __$FavoritesStateCopyWithImpl<_FavoritesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoritesState&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),message);

@override
String toString() {
  return 'FavoritesState(products: $products, message: $message)';
}


}

/// @nodoc
abstract mixin class _$FavoritesStateCopyWith<$Res> implements $FavoritesStateCopyWith<$Res> {
  factory _$FavoritesStateCopyWith(_FavoritesState value, $Res Function(_FavoritesState) _then) = __$FavoritesStateCopyWithImpl;
@override @useResult
$Res call({
 List<Product> products, String? message
});




}
/// @nodoc
class __$FavoritesStateCopyWithImpl<$Res>
    implements _$FavoritesStateCopyWith<$Res> {
  __$FavoritesStateCopyWithImpl(this._self, this._then);

  final _FavoritesState _self;
  final $Res Function(_FavoritesState) _then;

/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? products = null,Object? message = freezed,}) {
  return _then(_FavoritesState(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<Product>,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
