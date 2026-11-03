// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState()';
}


}

/// @nodoc
class $HomeStateCopyWith<$Res>  {
$HomeStateCopyWith(HomeState _, $Res Function(HomeState) __);
}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _HomeInitial value)?  initial,TResult Function( _HomeLoading value)?  loading,TResult Function( _HomeProductsLoaded value)?  productsLoaded,TResult Function( _HomeError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeInitial() when initial != null:
return initial(_that);case _HomeLoading() when loading != null:
return loading(_that);case _HomeProductsLoaded() when productsLoaded != null:
return productsLoaded(_that);case _HomeError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _HomeInitial value)  initial,required TResult Function( _HomeLoading value)  loading,required TResult Function( _HomeProductsLoaded value)  productsLoaded,required TResult Function( _HomeError value)  error,}){
final _that = this;
switch (_that) {
case _HomeInitial():
return initial(_that);case _HomeLoading():
return loading(_that);case _HomeProductsLoaded():
return productsLoaded(_that);case _HomeError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _HomeInitial value)?  initial,TResult? Function( _HomeLoading value)?  loading,TResult? Function( _HomeProductsLoaded value)?  productsLoaded,TResult? Function( _HomeError value)?  error,}){
final _that = this;
switch (_that) {
case _HomeInitial() when initial != null:
return initial(_that);case _HomeLoading() when loading != null:
return loading(_that);case _HomeProductsLoaded() when productsLoaded != null:
return productsLoaded(_that);case _HomeError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Product> products)?  productsLoaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeInitial() when initial != null:
return initial();case _HomeLoading() when loading != null:
return loading();case _HomeProductsLoaded() when productsLoaded != null:
return productsLoaded(_that.products);case _HomeError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Product> products)  productsLoaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _HomeInitial():
return initial();case _HomeLoading():
return loading();case _HomeProductsLoaded():
return productsLoaded(_that.products);case _HomeError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Product> products)?  productsLoaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _HomeInitial() when initial != null:
return initial();case _HomeLoading() when loading != null:
return loading();case _HomeProductsLoaded() when productsLoaded != null:
return productsLoaded(_that.products);case _HomeError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _HomeInitial implements HomeState {
  const _HomeInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.initial()';
}


}




/// @nodoc


class _HomeLoading implements HomeState {
  const _HomeLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.loading()';
}


}




/// @nodoc


class _HomeProductsLoaded implements HomeState {
  const _HomeProductsLoaded({required final  List<Product> products}): _products = products;
  

 final  List<Product> _products;
 List<Product> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}


/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeProductsLoadedCopyWith<_HomeProductsLoaded> get copyWith => __$HomeProductsLoadedCopyWithImpl<_HomeProductsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeProductsLoaded&&const DeepCollectionEquality().equals(other._products, _products));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products));

@override
String toString() {
  return 'HomeState.productsLoaded(products: $products)';
}


}

/// @nodoc
abstract mixin class _$HomeProductsLoadedCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeProductsLoadedCopyWith(_HomeProductsLoaded value, $Res Function(_HomeProductsLoaded) _then) = __$HomeProductsLoadedCopyWithImpl;
@useResult
$Res call({
 List<Product> products
});




}
/// @nodoc
class __$HomeProductsLoadedCopyWithImpl<$Res>
    implements _$HomeProductsLoadedCopyWith<$Res> {
  __$HomeProductsLoadedCopyWithImpl(this._self, this._then);

  final _HomeProductsLoaded _self;
  final $Res Function(_HomeProductsLoaded) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? products = null,}) {
  return _then(_HomeProductsLoaded(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<Product>,
  ));
}


}

/// @nodoc


class _HomeError implements HomeState {
  const _HomeError(this.message);
  

 final  String message;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeErrorCopyWith<_HomeError> get copyWith => __$HomeErrorCopyWithImpl<_HomeError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'HomeState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$HomeErrorCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeErrorCopyWith(_HomeError value, $Res Function(_HomeError) _then) = __$HomeErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$HomeErrorCopyWithImpl<$Res>
    implements _$HomeErrorCopyWith<$Res> {
  __$HomeErrorCopyWithImpl(this._self, this._then);

  final _HomeError _self;
  final $Res Function(_HomeError) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_HomeError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$HomeEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent()';
}


}

/// @nodoc
class $HomeEventCopyWith<$Res>  {
$HomeEventCopyWith(HomeEvent _, $Res Function(HomeEvent) __);
}


/// Adds pattern-matching-related methods to [HomeEvent].
extension HomeEventPatterns on HomeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeProductsRequested value)?  productsRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeProductsRequested() when productsRequested != null:
return productsRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeProductsRequested value)  productsRequested,}){
final _that = this;
switch (_that) {
case HomeProductsRequested():
return productsRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeProductsRequested value)?  productsRequested,}){
final _that = this;
switch (_that) {
case HomeProductsRequested() when productsRequested != null:
return productsRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  productsRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeProductsRequested() when productsRequested != null:
return productsRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  productsRequested,}) {final _that = this;
switch (_that) {
case HomeProductsRequested():
return productsRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  productsRequested,}) {final _that = this;
switch (_that) {
case HomeProductsRequested() when productsRequested != null:
return productsRequested();case _:
  return null;

}
}

}

/// @nodoc


class HomeProductsRequested implements HomeEvent {
  const HomeProductsRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeProductsRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.productsRequested()';
}


}




// dart format on
