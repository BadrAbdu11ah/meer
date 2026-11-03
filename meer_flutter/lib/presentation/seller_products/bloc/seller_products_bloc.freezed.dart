// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seller_products_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SellerProductsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerProductsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellerProductsEvent()';
}


}

/// @nodoc
class $SellerProductsEventCopyWith<$Res>  {
$SellerProductsEventCopyWith(SellerProductsEvent _, $Res Function(SellerProductsEvent) __);
}


/// Adds pattern-matching-related methods to [SellerProductsEvent].
extension SellerProductsEventPatterns on SellerProductsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SellerProductsStarted value)?  started,TResult Function( SellerProductsRefreshRequested value)?  refreshRequested,TResult Function( SellerProductAvailabilityChanged value)?  availabilityChanged,TResult Function( SellerProductDeleteRequested value)?  deleteRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SellerProductsStarted() when started != null:
return started(_that);case SellerProductsRefreshRequested() when refreshRequested != null:
return refreshRequested(_that);case SellerProductAvailabilityChanged() when availabilityChanged != null:
return availabilityChanged(_that);case SellerProductDeleteRequested() when deleteRequested != null:
return deleteRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SellerProductsStarted value)  started,required TResult Function( SellerProductsRefreshRequested value)  refreshRequested,required TResult Function( SellerProductAvailabilityChanged value)  availabilityChanged,required TResult Function( SellerProductDeleteRequested value)  deleteRequested,}){
final _that = this;
switch (_that) {
case SellerProductsStarted():
return started(_that);case SellerProductsRefreshRequested():
return refreshRequested(_that);case SellerProductAvailabilityChanged():
return availabilityChanged(_that);case SellerProductDeleteRequested():
return deleteRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SellerProductsStarted value)?  started,TResult? Function( SellerProductsRefreshRequested value)?  refreshRequested,TResult? Function( SellerProductAvailabilityChanged value)?  availabilityChanged,TResult? Function( SellerProductDeleteRequested value)?  deleteRequested,}){
final _that = this;
switch (_that) {
case SellerProductsStarted() when started != null:
return started(_that);case SellerProductsRefreshRequested() when refreshRequested != null:
return refreshRequested(_that);case SellerProductAvailabilityChanged() when availabilityChanged != null:
return availabilityChanged(_that);case SellerProductDeleteRequested() when deleteRequested != null:
return deleteRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  refreshRequested,TResult Function( int productId,  bool isAvailable)?  availabilityChanged,TResult Function( int productId)?  deleteRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SellerProductsStarted() when started != null:
return started();case SellerProductsRefreshRequested() when refreshRequested != null:
return refreshRequested();case SellerProductAvailabilityChanged() when availabilityChanged != null:
return availabilityChanged(_that.productId,_that.isAvailable);case SellerProductDeleteRequested() when deleteRequested != null:
return deleteRequested(_that.productId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  refreshRequested,required TResult Function( int productId,  bool isAvailable)  availabilityChanged,required TResult Function( int productId)  deleteRequested,}) {final _that = this;
switch (_that) {
case SellerProductsStarted():
return started();case SellerProductsRefreshRequested():
return refreshRequested();case SellerProductAvailabilityChanged():
return availabilityChanged(_that.productId,_that.isAvailable);case SellerProductDeleteRequested():
return deleteRequested(_that.productId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  refreshRequested,TResult? Function( int productId,  bool isAvailable)?  availabilityChanged,TResult? Function( int productId)?  deleteRequested,}) {final _that = this;
switch (_that) {
case SellerProductsStarted() when started != null:
return started();case SellerProductsRefreshRequested() when refreshRequested != null:
return refreshRequested();case SellerProductAvailabilityChanged() when availabilityChanged != null:
return availabilityChanged(_that.productId,_that.isAvailable);case SellerProductDeleteRequested() when deleteRequested != null:
return deleteRequested(_that.productId);case _:
  return null;

}
}

}

/// @nodoc


class SellerProductsStarted implements SellerProductsEvent {
  const SellerProductsStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerProductsStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellerProductsEvent.started()';
}


}




/// @nodoc


class SellerProductsRefreshRequested implements SellerProductsEvent {
  const SellerProductsRefreshRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerProductsRefreshRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellerProductsEvent.refreshRequested()';
}


}




/// @nodoc


class SellerProductAvailabilityChanged implements SellerProductsEvent {
  const SellerProductAvailabilityChanged({required this.productId, required this.isAvailable});
  

 final  int productId;
 final  bool isAvailable;

/// Create a copy of SellerProductsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SellerProductAvailabilityChangedCopyWith<SellerProductAvailabilityChanged> get copyWith => _$SellerProductAvailabilityChangedCopyWithImpl<SellerProductAvailabilityChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerProductAvailabilityChanged&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}


@override
int get hashCode => Object.hash(runtimeType,productId,isAvailable);

@override
String toString() {
  return 'SellerProductsEvent.availabilityChanged(productId: $productId, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class $SellerProductAvailabilityChangedCopyWith<$Res> implements $SellerProductsEventCopyWith<$Res> {
  factory $SellerProductAvailabilityChangedCopyWith(SellerProductAvailabilityChanged value, $Res Function(SellerProductAvailabilityChanged) _then) = _$SellerProductAvailabilityChangedCopyWithImpl;
@useResult
$Res call({
 int productId, bool isAvailable
});




}
/// @nodoc
class _$SellerProductAvailabilityChangedCopyWithImpl<$Res>
    implements $SellerProductAvailabilityChangedCopyWith<$Res> {
  _$SellerProductAvailabilityChangedCopyWithImpl(this._self, this._then);

  final SellerProductAvailabilityChanged _self;
  final $Res Function(SellerProductAvailabilityChanged) _then;

/// Create a copy of SellerProductsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? isAvailable = null,}) {
  return _then(SellerProductAvailabilityChanged(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SellerProductDeleteRequested implements SellerProductsEvent {
  const SellerProductDeleteRequested({required this.productId});
  

 final  int productId;

/// Create a copy of SellerProductsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SellerProductDeleteRequestedCopyWith<SellerProductDeleteRequested> get copyWith => _$SellerProductDeleteRequestedCopyWithImpl<SellerProductDeleteRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerProductDeleteRequested&&(identical(other.productId, productId) || other.productId == productId));
}


@override
int get hashCode => Object.hash(runtimeType,productId);

@override
String toString() {
  return 'SellerProductsEvent.deleteRequested(productId: $productId)';
}


}

/// @nodoc
abstract mixin class $SellerProductDeleteRequestedCopyWith<$Res> implements $SellerProductsEventCopyWith<$Res> {
  factory $SellerProductDeleteRequestedCopyWith(SellerProductDeleteRequested value, $Res Function(SellerProductDeleteRequested) _then) = _$SellerProductDeleteRequestedCopyWithImpl;
@useResult
$Res call({
 int productId
});




}
/// @nodoc
class _$SellerProductDeleteRequestedCopyWithImpl<$Res>
    implements $SellerProductDeleteRequestedCopyWith<$Res> {
  _$SellerProductDeleteRequestedCopyWithImpl(this._self, this._then);

  final SellerProductDeleteRequested _self;
  final $Res Function(SellerProductDeleteRequested) _then;

/// Create a copy of SellerProductsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? productId = null,}) {
  return _then(SellerProductDeleteRequested(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$SellerProductsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerProductsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellerProductsState()';
}


}

/// @nodoc
class $SellerProductsStateCopyWith<$Res>  {
$SellerProductsStateCopyWith(SellerProductsState _, $Res Function(SellerProductsState) __);
}


/// Adds pattern-matching-related methods to [SellerProductsState].
extension SellerProductsStatePatterns on SellerProductsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SellerProductsInitial value)?  initial,TResult Function( _SellerProductsLoading value)?  loading,TResult Function( _SellerProductsLoaded value)?  loaded,TResult Function( _SellerProductsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SellerProductsInitial() when initial != null:
return initial(_that);case _SellerProductsLoading() when loading != null:
return loading(_that);case _SellerProductsLoaded() when loaded != null:
return loaded(_that);case _SellerProductsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SellerProductsInitial value)  initial,required TResult Function( _SellerProductsLoading value)  loading,required TResult Function( _SellerProductsLoaded value)  loaded,required TResult Function( _SellerProductsError value)  error,}){
final _that = this;
switch (_that) {
case _SellerProductsInitial():
return initial(_that);case _SellerProductsLoading():
return loading(_that);case _SellerProductsLoaded():
return loaded(_that);case _SellerProductsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SellerProductsInitial value)?  initial,TResult? Function( _SellerProductsLoading value)?  loading,TResult? Function( _SellerProductsLoaded value)?  loaded,TResult? Function( _SellerProductsError value)?  error,}){
final _that = this;
switch (_that) {
case _SellerProductsInitial() when initial != null:
return initial(_that);case _SellerProductsLoading() when loading != null:
return loading(_that);case _SellerProductsLoaded() when loaded != null:
return loaded(_that);case _SellerProductsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Product> products,  Set<int> updatingProductIds,  String? message)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SellerProductsInitial() when initial != null:
return initial();case _SellerProductsLoading() when loading != null:
return loading();case _SellerProductsLoaded() when loaded != null:
return loaded(_that.products,_that.updatingProductIds,_that.message);case _SellerProductsError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Product> products,  Set<int> updatingProductIds,  String? message)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _SellerProductsInitial():
return initial();case _SellerProductsLoading():
return loading();case _SellerProductsLoaded():
return loaded(_that.products,_that.updatingProductIds,_that.message);case _SellerProductsError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Product> products,  Set<int> updatingProductIds,  String? message)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _SellerProductsInitial() when initial != null:
return initial();case _SellerProductsLoading() when loading != null:
return loading();case _SellerProductsLoaded() when loaded != null:
return loaded(_that.products,_that.updatingProductIds,_that.message);case _SellerProductsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _SellerProductsInitial implements SellerProductsState {
  const _SellerProductsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SellerProductsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellerProductsState.initial()';
}


}




/// @nodoc


class _SellerProductsLoading implements SellerProductsState {
  const _SellerProductsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SellerProductsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellerProductsState.loading()';
}


}




/// @nodoc


class _SellerProductsLoaded implements SellerProductsState {
  const _SellerProductsLoaded({required final  List<Product> products, final  Set<int> updatingProductIds = const <int>{}, this.message}): _products = products,_updatingProductIds = updatingProductIds;
  

 final  List<Product> _products;
 List<Product> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  Set<int> _updatingProductIds;
@JsonKey() Set<int> get updatingProductIds {
  if (_updatingProductIds is EqualUnmodifiableSetView) return _updatingProductIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_updatingProductIds);
}

 final  String? message;

/// Create a copy of SellerProductsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SellerProductsLoadedCopyWith<_SellerProductsLoaded> get copyWith => __$SellerProductsLoadedCopyWithImpl<_SellerProductsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SellerProductsLoaded&&const DeepCollectionEquality().equals(other._products, _products)&&const DeepCollectionEquality().equals(other._updatingProductIds, _updatingProductIds)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),const DeepCollectionEquality().hash(_updatingProductIds),message);

@override
String toString() {
  return 'SellerProductsState.loaded(products: $products, updatingProductIds: $updatingProductIds, message: $message)';
}


}

/// @nodoc
abstract mixin class _$SellerProductsLoadedCopyWith<$Res> implements $SellerProductsStateCopyWith<$Res> {
  factory _$SellerProductsLoadedCopyWith(_SellerProductsLoaded value, $Res Function(_SellerProductsLoaded) _then) = __$SellerProductsLoadedCopyWithImpl;
@useResult
$Res call({
 List<Product> products, Set<int> updatingProductIds, String? message
});




}
/// @nodoc
class __$SellerProductsLoadedCopyWithImpl<$Res>
    implements _$SellerProductsLoadedCopyWith<$Res> {
  __$SellerProductsLoadedCopyWithImpl(this._self, this._then);

  final _SellerProductsLoaded _self;
  final $Res Function(_SellerProductsLoaded) _then;

/// Create a copy of SellerProductsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? products = null,Object? updatingProductIds = null,Object? message = freezed,}) {
  return _then(_SellerProductsLoaded(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<Product>,updatingProductIds: null == updatingProductIds ? _self._updatingProductIds : updatingProductIds // ignore: cast_nullable_to_non_nullable
as Set<int>,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _SellerProductsError implements SellerProductsState {
  const _SellerProductsError(this.message);
  

 final  String message;

/// Create a copy of SellerProductsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SellerProductsErrorCopyWith<_SellerProductsError> get copyWith => __$SellerProductsErrorCopyWithImpl<_SellerProductsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SellerProductsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SellerProductsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$SellerProductsErrorCopyWith<$Res> implements $SellerProductsStateCopyWith<$Res> {
  factory _$SellerProductsErrorCopyWith(_SellerProductsError value, $Res Function(_SellerProductsError) _then) = __$SellerProductsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$SellerProductsErrorCopyWithImpl<$Res>
    implements _$SellerProductsErrorCopyWith<$Res> {
  __$SellerProductsErrorCopyWithImpl(this._self, this._then);

  final _SellerProductsError _self;
  final $Res Function(_SellerProductsError) _then;

/// Create a copy of SellerProductsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_SellerProductsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
