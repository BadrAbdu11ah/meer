// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seller_details_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SellerDetailsEvent {

 int get sellerId;
/// Create a copy of SellerDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SellerDetailsEventCopyWith<SellerDetailsEvent> get copyWith => _$SellerDetailsEventCopyWithImpl<SellerDetailsEvent>(this as SellerDetailsEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerDetailsEvent&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId));
}


@override
int get hashCode => Object.hash(runtimeType,sellerId);

@override
String toString() {
  return 'SellerDetailsEvent(sellerId: $sellerId)';
}


}

/// @nodoc
abstract mixin class $SellerDetailsEventCopyWith<$Res>  {
  factory $SellerDetailsEventCopyWith(SellerDetailsEvent value, $Res Function(SellerDetailsEvent) _then) = _$SellerDetailsEventCopyWithImpl;
@useResult
$Res call({
 int sellerId
});




}
/// @nodoc
class _$SellerDetailsEventCopyWithImpl<$Res>
    implements $SellerDetailsEventCopyWith<$Res> {
  _$SellerDetailsEventCopyWithImpl(this._self, this._then);

  final SellerDetailsEvent _self;
  final $Res Function(SellerDetailsEvent) _then;

/// Create a copy of SellerDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sellerId = null,}) {
  return _then(_self.copyWith(
sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SellerDetailsEvent].
extension SellerDetailsEventPatterns on SellerDetailsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SellerDetailsLoadRequested value)?  loadRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SellerDetailsLoadRequested() when loadRequested != null:
return loadRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SellerDetailsLoadRequested value)  loadRequested,}){
final _that = this;
switch (_that) {
case SellerDetailsLoadRequested():
return loadRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SellerDetailsLoadRequested value)?  loadRequested,}){
final _that = this;
switch (_that) {
case SellerDetailsLoadRequested() when loadRequested != null:
return loadRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int sellerId)?  loadRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SellerDetailsLoadRequested() when loadRequested != null:
return loadRequested(_that.sellerId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int sellerId)  loadRequested,}) {final _that = this;
switch (_that) {
case SellerDetailsLoadRequested():
return loadRequested(_that.sellerId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int sellerId)?  loadRequested,}) {final _that = this;
switch (_that) {
case SellerDetailsLoadRequested() when loadRequested != null:
return loadRequested(_that.sellerId);case _:
  return null;

}
}

}

/// @nodoc


class SellerDetailsLoadRequested implements SellerDetailsEvent {
  const SellerDetailsLoadRequested({required this.sellerId});
  

@override final  int sellerId;

/// Create a copy of SellerDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SellerDetailsLoadRequestedCopyWith<SellerDetailsLoadRequested> get copyWith => _$SellerDetailsLoadRequestedCopyWithImpl<SellerDetailsLoadRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerDetailsLoadRequested&&(identical(other.sellerId, sellerId) || other.sellerId == sellerId));
}


@override
int get hashCode => Object.hash(runtimeType,sellerId);

@override
String toString() {
  return 'SellerDetailsEvent.loadRequested(sellerId: $sellerId)';
}


}

/// @nodoc
abstract mixin class $SellerDetailsLoadRequestedCopyWith<$Res> implements $SellerDetailsEventCopyWith<$Res> {
  factory $SellerDetailsLoadRequestedCopyWith(SellerDetailsLoadRequested value, $Res Function(SellerDetailsLoadRequested) _then) = _$SellerDetailsLoadRequestedCopyWithImpl;
@override @useResult
$Res call({
 int sellerId
});




}
/// @nodoc
class _$SellerDetailsLoadRequestedCopyWithImpl<$Res>
    implements $SellerDetailsLoadRequestedCopyWith<$Res> {
  _$SellerDetailsLoadRequestedCopyWithImpl(this._self, this._then);

  final SellerDetailsLoadRequested _self;
  final $Res Function(SellerDetailsLoadRequested) _then;

/// Create a copy of SellerDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sellerId = null,}) {
  return _then(SellerDetailsLoadRequested(
sellerId: null == sellerId ? _self.sellerId : sellerId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$SellerDetailsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerDetailsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellerDetailsState()';
}


}

/// @nodoc
class $SellerDetailsStateCopyWith<$Res>  {
$SellerDetailsStateCopyWith(SellerDetailsState _, $Res Function(SellerDetailsState) __);
}


/// Adds pattern-matching-related methods to [SellerDetailsState].
extension SellerDetailsStatePatterns on SellerDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SellerDetailsInitial value)?  initial,TResult Function( SellerDetailsLoading value)?  loading,TResult Function( SellerDetailsLoaded value)?  loaded,TResult Function( SellerDetailsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SellerDetailsInitial() when initial != null:
return initial(_that);case SellerDetailsLoading() when loading != null:
return loading(_that);case SellerDetailsLoaded() when loaded != null:
return loaded(_that);case SellerDetailsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SellerDetailsInitial value)  initial,required TResult Function( SellerDetailsLoading value)  loading,required TResult Function( SellerDetailsLoaded value)  loaded,required TResult Function( SellerDetailsError value)  error,}){
final _that = this;
switch (_that) {
case SellerDetailsInitial():
return initial(_that);case SellerDetailsLoading():
return loading(_that);case SellerDetailsLoaded():
return loaded(_that);case SellerDetailsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SellerDetailsInitial value)?  initial,TResult? Function( SellerDetailsLoading value)?  loading,TResult? Function( SellerDetailsLoaded value)?  loaded,TResult? Function( SellerDetailsError value)?  error,}){
final _that = this;
switch (_that) {
case SellerDetailsInitial() when initial != null:
return initial(_that);case SellerDetailsLoading() when loading != null:
return loading(_that);case SellerDetailsLoaded() when loaded != null:
return loaded(_that);case SellerDetailsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( SellerPublicInfo seller,  List<Product> products)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SellerDetailsInitial() when initial != null:
return initial();case SellerDetailsLoading() when loading != null:
return loading();case SellerDetailsLoaded() when loaded != null:
return loaded(_that.seller,_that.products);case SellerDetailsError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( SellerPublicInfo seller,  List<Product> products)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case SellerDetailsInitial():
return initial();case SellerDetailsLoading():
return loading();case SellerDetailsLoaded():
return loaded(_that.seller,_that.products);case SellerDetailsError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( SellerPublicInfo seller,  List<Product> products)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case SellerDetailsInitial() when initial != null:
return initial();case SellerDetailsLoading() when loading != null:
return loading();case SellerDetailsLoaded() when loaded != null:
return loaded(_that.seller,_that.products);case SellerDetailsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class SellerDetailsInitial implements SellerDetailsState {
  const SellerDetailsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerDetailsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellerDetailsState.initial()';
}


}




/// @nodoc


class SellerDetailsLoading implements SellerDetailsState {
  const SellerDetailsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerDetailsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellerDetailsState.loading()';
}


}




/// @nodoc


class SellerDetailsLoaded implements SellerDetailsState {
  const SellerDetailsLoaded({required this.seller, required final  List<Product> products}): _products = products;
  

 final  SellerPublicInfo seller;
 final  List<Product> _products;
 List<Product> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}


/// Create a copy of SellerDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SellerDetailsLoadedCopyWith<SellerDetailsLoaded> get copyWith => _$SellerDetailsLoadedCopyWithImpl<SellerDetailsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerDetailsLoaded&&(identical(other.seller, seller) || other.seller == seller)&&const DeepCollectionEquality().equals(other._products, _products));
}


@override
int get hashCode => Object.hash(runtimeType,seller,const DeepCollectionEquality().hash(_products));

@override
String toString() {
  return 'SellerDetailsState.loaded(seller: $seller, products: $products)';
}


}

/// @nodoc
abstract mixin class $SellerDetailsLoadedCopyWith<$Res> implements $SellerDetailsStateCopyWith<$Res> {
  factory $SellerDetailsLoadedCopyWith(SellerDetailsLoaded value, $Res Function(SellerDetailsLoaded) _then) = _$SellerDetailsLoadedCopyWithImpl;
@useResult
$Res call({
 SellerPublicInfo seller, List<Product> products
});




}
/// @nodoc
class _$SellerDetailsLoadedCopyWithImpl<$Res>
    implements $SellerDetailsLoadedCopyWith<$Res> {
  _$SellerDetailsLoadedCopyWithImpl(this._self, this._then);

  final SellerDetailsLoaded _self;
  final $Res Function(SellerDetailsLoaded) _then;

/// Create a copy of SellerDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? seller = null,Object? products = null,}) {
  return _then(SellerDetailsLoaded(
seller: null == seller ? _self.seller : seller // ignore: cast_nullable_to_non_nullable
as SellerPublicInfo,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<Product>,
  ));
}


}

/// @nodoc


class SellerDetailsError implements SellerDetailsState {
  const SellerDetailsError(this.message);
  

 final  String message;

/// Create a copy of SellerDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SellerDetailsErrorCopyWith<SellerDetailsError> get copyWith => _$SellerDetailsErrorCopyWithImpl<SellerDetailsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerDetailsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SellerDetailsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $SellerDetailsErrorCopyWith<$Res> implements $SellerDetailsStateCopyWith<$Res> {
  factory $SellerDetailsErrorCopyWith(SellerDetailsError value, $Res Function(SellerDetailsError) _then) = _$SellerDetailsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SellerDetailsErrorCopyWithImpl<$Res>
    implements $SellerDetailsErrorCopyWith<$Res> {
  _$SellerDetailsErrorCopyWithImpl(this._self, this._then);

  final SellerDetailsError _self;
  final $Res Function(SellerDetailsError) _then;

/// Create a copy of SellerDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SellerDetailsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
