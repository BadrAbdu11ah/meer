// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_orders_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CustomerOrdersEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerOrdersEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CustomerOrdersEvent()';
}


}

/// @nodoc
class $CustomerOrdersEventCopyWith<$Res>  {
$CustomerOrdersEventCopyWith(CustomerOrdersEvent _, $Res Function(CustomerOrdersEvent) __);
}


/// Adds pattern-matching-related methods to [CustomerOrdersEvent].
extension CustomerOrdersEventPatterns on CustomerOrdersEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CustomerOrdersLoadRequested value)?  loadRequested,TResult Function( CustomerOrdersRefreshRequested value)?  refreshRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CustomerOrdersLoadRequested() when loadRequested != null:
return loadRequested(_that);case CustomerOrdersRefreshRequested() when refreshRequested != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CustomerOrdersLoadRequested value)  loadRequested,required TResult Function( CustomerOrdersRefreshRequested value)  refreshRequested,}){
final _that = this;
switch (_that) {
case CustomerOrdersLoadRequested():
return loadRequested(_that);case CustomerOrdersRefreshRequested():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CustomerOrdersLoadRequested value)?  loadRequested,TResult? Function( CustomerOrdersRefreshRequested value)?  refreshRequested,}){
final _that = this;
switch (_that) {
case CustomerOrdersLoadRequested() when loadRequested != null:
return loadRequested(_that);case CustomerOrdersRefreshRequested() when refreshRequested != null:
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
case CustomerOrdersLoadRequested() when loadRequested != null:
return loadRequested();case CustomerOrdersRefreshRequested() when refreshRequested != null:
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
case CustomerOrdersLoadRequested():
return loadRequested();case CustomerOrdersRefreshRequested():
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
case CustomerOrdersLoadRequested() when loadRequested != null:
return loadRequested();case CustomerOrdersRefreshRequested() when refreshRequested != null:
return refreshRequested();case _:
  return null;

}
}

}

/// @nodoc


class CustomerOrdersLoadRequested implements CustomerOrdersEvent {
  const CustomerOrdersLoadRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerOrdersLoadRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CustomerOrdersEvent.loadRequested()';
}


}




/// @nodoc


class CustomerOrdersRefreshRequested implements CustomerOrdersEvent {
  const CustomerOrdersRefreshRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerOrdersRefreshRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CustomerOrdersEvent.refreshRequested()';
}


}




/// @nodoc
mixin _$CustomerOrdersState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerOrdersState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CustomerOrdersState()';
}


}

/// @nodoc
class $CustomerOrdersStateCopyWith<$Res>  {
$CustomerOrdersStateCopyWith(CustomerOrdersState _, $Res Function(CustomerOrdersState) __);
}


/// Adds pattern-matching-related methods to [CustomerOrdersState].
extension CustomerOrdersStatePatterns on CustomerOrdersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CustomerOrdersInitial value)?  initial,TResult Function( CustomerOrdersLoading value)?  loading,TResult Function( CustomerOrdersLoaded value)?  loaded,TResult Function( CustomerOrdersError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CustomerOrdersInitial() when initial != null:
return initial(_that);case CustomerOrdersLoading() when loading != null:
return loading(_that);case CustomerOrdersLoaded() when loaded != null:
return loaded(_that);case CustomerOrdersError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CustomerOrdersInitial value)  initial,required TResult Function( CustomerOrdersLoading value)  loading,required TResult Function( CustomerOrdersLoaded value)  loaded,required TResult Function( CustomerOrdersError value)  error,}){
final _that = this;
switch (_that) {
case CustomerOrdersInitial():
return initial(_that);case CustomerOrdersLoading():
return loading(_that);case CustomerOrdersLoaded():
return loaded(_that);case CustomerOrdersError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CustomerOrdersInitial value)?  initial,TResult? Function( CustomerOrdersLoading value)?  loading,TResult? Function( CustomerOrdersLoaded value)?  loaded,TResult? Function( CustomerOrdersError value)?  error,}){
final _that = this;
switch (_that) {
case CustomerOrdersInitial() when initial != null:
return initial(_that);case CustomerOrdersLoading() when loading != null:
return loading(_that);case CustomerOrdersLoaded() when loaded != null:
return loaded(_that);case CustomerOrdersError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<OrderInfo> orders)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CustomerOrdersInitial() when initial != null:
return initial();case CustomerOrdersLoading() when loading != null:
return loading();case CustomerOrdersLoaded() when loaded != null:
return loaded(_that.orders);case CustomerOrdersError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<OrderInfo> orders)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case CustomerOrdersInitial():
return initial();case CustomerOrdersLoading():
return loading();case CustomerOrdersLoaded():
return loaded(_that.orders);case CustomerOrdersError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<OrderInfo> orders)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case CustomerOrdersInitial() when initial != null:
return initial();case CustomerOrdersLoading() when loading != null:
return loading();case CustomerOrdersLoaded() when loaded != null:
return loaded(_that.orders);case CustomerOrdersError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class CustomerOrdersInitial implements CustomerOrdersState {
  const CustomerOrdersInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerOrdersInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CustomerOrdersState.initial()';
}


}




/// @nodoc


class CustomerOrdersLoading implements CustomerOrdersState {
  const CustomerOrdersLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerOrdersLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CustomerOrdersState.loading()';
}


}




/// @nodoc


class CustomerOrdersLoaded implements CustomerOrdersState {
  const CustomerOrdersLoaded({required final  List<OrderInfo> orders}): _orders = orders;
  

 final  List<OrderInfo> _orders;
 List<OrderInfo> get orders {
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orders);
}


/// Create a copy of CustomerOrdersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerOrdersLoadedCopyWith<CustomerOrdersLoaded> get copyWith => _$CustomerOrdersLoadedCopyWithImpl<CustomerOrdersLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerOrdersLoaded&&const DeepCollectionEquality().equals(other._orders, _orders));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_orders));

@override
String toString() {
  return 'CustomerOrdersState.loaded(orders: $orders)';
}


}

/// @nodoc
abstract mixin class $CustomerOrdersLoadedCopyWith<$Res> implements $CustomerOrdersStateCopyWith<$Res> {
  factory $CustomerOrdersLoadedCopyWith(CustomerOrdersLoaded value, $Res Function(CustomerOrdersLoaded) _then) = _$CustomerOrdersLoadedCopyWithImpl;
@useResult
$Res call({
 List<OrderInfo> orders
});




}
/// @nodoc
class _$CustomerOrdersLoadedCopyWithImpl<$Res>
    implements $CustomerOrdersLoadedCopyWith<$Res> {
  _$CustomerOrdersLoadedCopyWithImpl(this._self, this._then);

  final CustomerOrdersLoaded _self;
  final $Res Function(CustomerOrdersLoaded) _then;

/// Create a copy of CustomerOrdersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orders = null,}) {
  return _then(CustomerOrdersLoaded(
orders: null == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderInfo>,
  ));
}


}

/// @nodoc


class CustomerOrdersError implements CustomerOrdersState {
  const CustomerOrdersError(this.message);
  

 final  String message;

/// Create a copy of CustomerOrdersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerOrdersErrorCopyWith<CustomerOrdersError> get copyWith => _$CustomerOrdersErrorCopyWithImpl<CustomerOrdersError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerOrdersError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CustomerOrdersState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $CustomerOrdersErrorCopyWith<$Res> implements $CustomerOrdersStateCopyWith<$Res> {
  factory $CustomerOrdersErrorCopyWith(CustomerOrdersError value, $Res Function(CustomerOrdersError) _then) = _$CustomerOrdersErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CustomerOrdersErrorCopyWithImpl<$Res>
    implements $CustomerOrdersErrorCopyWith<$Res> {
  _$CustomerOrdersErrorCopyWithImpl(this._self, this._then);

  final CustomerOrdersError _self;
  final $Res Function(CustomerOrdersError) _then;

/// Create a copy of CustomerOrdersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CustomerOrdersError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
