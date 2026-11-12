// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seller_orders_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SellerOrdersEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerOrdersEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellerOrdersEvent()';
}


}

/// @nodoc
class $SellerOrdersEventCopyWith<$Res>  {
$SellerOrdersEventCopyWith(SellerOrdersEvent _, $Res Function(SellerOrdersEvent) __);
}


/// Adds pattern-matching-related methods to [SellerOrdersEvent].
extension SellerOrdersEventPatterns on SellerOrdersEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SellerOrdersLoadRequested value)?  loadRequested,TResult Function( SellerOrdersRefreshRequested value)?  refreshRequested,TResult Function( SellerOrderAcceptRequested value)?  acceptRequested,TResult Function( SellerOrderRejectRequested value)?  rejectRequested,TResult Function( SellerOrderMarkReadyRequested value)?  markReadyRequested,TResult Function( SellerOrderMarkCompletedRequested value)?  markCompletedRequested,TResult Function( SellerOrdersMessageCleared value)?  messageCleared,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SellerOrdersLoadRequested() when loadRequested != null:
return loadRequested(_that);case SellerOrdersRefreshRequested() when refreshRequested != null:
return refreshRequested(_that);case SellerOrderAcceptRequested() when acceptRequested != null:
return acceptRequested(_that);case SellerOrderRejectRequested() when rejectRequested != null:
return rejectRequested(_that);case SellerOrderMarkReadyRequested() when markReadyRequested != null:
return markReadyRequested(_that);case SellerOrderMarkCompletedRequested() when markCompletedRequested != null:
return markCompletedRequested(_that);case SellerOrdersMessageCleared() when messageCleared != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SellerOrdersLoadRequested value)  loadRequested,required TResult Function( SellerOrdersRefreshRequested value)  refreshRequested,required TResult Function( SellerOrderAcceptRequested value)  acceptRequested,required TResult Function( SellerOrderRejectRequested value)  rejectRequested,required TResult Function( SellerOrderMarkReadyRequested value)  markReadyRequested,required TResult Function( SellerOrderMarkCompletedRequested value)  markCompletedRequested,required TResult Function( SellerOrdersMessageCleared value)  messageCleared,}){
final _that = this;
switch (_that) {
case SellerOrdersLoadRequested():
return loadRequested(_that);case SellerOrdersRefreshRequested():
return refreshRequested(_that);case SellerOrderAcceptRequested():
return acceptRequested(_that);case SellerOrderRejectRequested():
return rejectRequested(_that);case SellerOrderMarkReadyRequested():
return markReadyRequested(_that);case SellerOrderMarkCompletedRequested():
return markCompletedRequested(_that);case SellerOrdersMessageCleared():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SellerOrdersLoadRequested value)?  loadRequested,TResult? Function( SellerOrdersRefreshRequested value)?  refreshRequested,TResult? Function( SellerOrderAcceptRequested value)?  acceptRequested,TResult? Function( SellerOrderRejectRequested value)?  rejectRequested,TResult? Function( SellerOrderMarkReadyRequested value)?  markReadyRequested,TResult? Function( SellerOrderMarkCompletedRequested value)?  markCompletedRequested,TResult? Function( SellerOrdersMessageCleared value)?  messageCleared,}){
final _that = this;
switch (_that) {
case SellerOrdersLoadRequested() when loadRequested != null:
return loadRequested(_that);case SellerOrdersRefreshRequested() when refreshRequested != null:
return refreshRequested(_that);case SellerOrderAcceptRequested() when acceptRequested != null:
return acceptRequested(_that);case SellerOrderRejectRequested() when rejectRequested != null:
return rejectRequested(_that);case SellerOrderMarkReadyRequested() when markReadyRequested != null:
return markReadyRequested(_that);case SellerOrderMarkCompletedRequested() when markCompletedRequested != null:
return markCompletedRequested(_that);case SellerOrdersMessageCleared() when messageCleared != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadRequested,TResult Function()?  refreshRequested,TResult Function( int orderId)?  acceptRequested,TResult Function( int orderId)?  rejectRequested,TResult Function( int orderId)?  markReadyRequested,TResult Function( int orderId)?  markCompletedRequested,TResult Function()?  messageCleared,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SellerOrdersLoadRequested() when loadRequested != null:
return loadRequested();case SellerOrdersRefreshRequested() when refreshRequested != null:
return refreshRequested();case SellerOrderAcceptRequested() when acceptRequested != null:
return acceptRequested(_that.orderId);case SellerOrderRejectRequested() when rejectRequested != null:
return rejectRequested(_that.orderId);case SellerOrderMarkReadyRequested() when markReadyRequested != null:
return markReadyRequested(_that.orderId);case SellerOrderMarkCompletedRequested() when markCompletedRequested != null:
return markCompletedRequested(_that.orderId);case SellerOrdersMessageCleared() when messageCleared != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadRequested,required TResult Function()  refreshRequested,required TResult Function( int orderId)  acceptRequested,required TResult Function( int orderId)  rejectRequested,required TResult Function( int orderId)  markReadyRequested,required TResult Function( int orderId)  markCompletedRequested,required TResult Function()  messageCleared,}) {final _that = this;
switch (_that) {
case SellerOrdersLoadRequested():
return loadRequested();case SellerOrdersRefreshRequested():
return refreshRequested();case SellerOrderAcceptRequested():
return acceptRequested(_that.orderId);case SellerOrderRejectRequested():
return rejectRequested(_that.orderId);case SellerOrderMarkReadyRequested():
return markReadyRequested(_that.orderId);case SellerOrderMarkCompletedRequested():
return markCompletedRequested(_that.orderId);case SellerOrdersMessageCleared():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadRequested,TResult? Function()?  refreshRequested,TResult? Function( int orderId)?  acceptRequested,TResult? Function( int orderId)?  rejectRequested,TResult? Function( int orderId)?  markReadyRequested,TResult? Function( int orderId)?  markCompletedRequested,TResult? Function()?  messageCleared,}) {final _that = this;
switch (_that) {
case SellerOrdersLoadRequested() when loadRequested != null:
return loadRequested();case SellerOrdersRefreshRequested() when refreshRequested != null:
return refreshRequested();case SellerOrderAcceptRequested() when acceptRequested != null:
return acceptRequested(_that.orderId);case SellerOrderRejectRequested() when rejectRequested != null:
return rejectRequested(_that.orderId);case SellerOrderMarkReadyRequested() when markReadyRequested != null:
return markReadyRequested(_that.orderId);case SellerOrderMarkCompletedRequested() when markCompletedRequested != null:
return markCompletedRequested(_that.orderId);case SellerOrdersMessageCleared() when messageCleared != null:
return messageCleared();case _:
  return null;

}
}

}

/// @nodoc


class SellerOrdersLoadRequested implements SellerOrdersEvent {
  const SellerOrdersLoadRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerOrdersLoadRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellerOrdersEvent.loadRequested()';
}


}




/// @nodoc


class SellerOrdersRefreshRequested implements SellerOrdersEvent {
  const SellerOrdersRefreshRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerOrdersRefreshRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellerOrdersEvent.refreshRequested()';
}


}




/// @nodoc


class SellerOrderAcceptRequested implements SellerOrdersEvent {
  const SellerOrderAcceptRequested({required this.orderId});
  

 final  int orderId;

/// Create a copy of SellerOrdersEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SellerOrderAcceptRequestedCopyWith<SellerOrderAcceptRequested> get copyWith => _$SellerOrderAcceptRequestedCopyWithImpl<SellerOrderAcceptRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerOrderAcceptRequested&&(identical(other.orderId, orderId) || other.orderId == orderId));
}


@override
int get hashCode => Object.hash(runtimeType,orderId);

@override
String toString() {
  return 'SellerOrdersEvent.acceptRequested(orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class $SellerOrderAcceptRequestedCopyWith<$Res> implements $SellerOrdersEventCopyWith<$Res> {
  factory $SellerOrderAcceptRequestedCopyWith(SellerOrderAcceptRequested value, $Res Function(SellerOrderAcceptRequested) _then) = _$SellerOrderAcceptRequestedCopyWithImpl;
@useResult
$Res call({
 int orderId
});




}
/// @nodoc
class _$SellerOrderAcceptRequestedCopyWithImpl<$Res>
    implements $SellerOrderAcceptRequestedCopyWith<$Res> {
  _$SellerOrderAcceptRequestedCopyWithImpl(this._self, this._then);

  final SellerOrderAcceptRequested _self;
  final $Res Function(SellerOrderAcceptRequested) _then;

/// Create a copy of SellerOrdersEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,}) {
  return _then(SellerOrderAcceptRequested(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class SellerOrderRejectRequested implements SellerOrdersEvent {
  const SellerOrderRejectRequested({required this.orderId});
  

 final  int orderId;

/// Create a copy of SellerOrdersEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SellerOrderRejectRequestedCopyWith<SellerOrderRejectRequested> get copyWith => _$SellerOrderRejectRequestedCopyWithImpl<SellerOrderRejectRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerOrderRejectRequested&&(identical(other.orderId, orderId) || other.orderId == orderId));
}


@override
int get hashCode => Object.hash(runtimeType,orderId);

@override
String toString() {
  return 'SellerOrdersEvent.rejectRequested(orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class $SellerOrderRejectRequestedCopyWith<$Res> implements $SellerOrdersEventCopyWith<$Res> {
  factory $SellerOrderRejectRequestedCopyWith(SellerOrderRejectRequested value, $Res Function(SellerOrderRejectRequested) _then) = _$SellerOrderRejectRequestedCopyWithImpl;
@useResult
$Res call({
 int orderId
});




}
/// @nodoc
class _$SellerOrderRejectRequestedCopyWithImpl<$Res>
    implements $SellerOrderRejectRequestedCopyWith<$Res> {
  _$SellerOrderRejectRequestedCopyWithImpl(this._self, this._then);

  final SellerOrderRejectRequested _self;
  final $Res Function(SellerOrderRejectRequested) _then;

/// Create a copy of SellerOrdersEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,}) {
  return _then(SellerOrderRejectRequested(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class SellerOrderMarkReadyRequested implements SellerOrdersEvent {
  const SellerOrderMarkReadyRequested({required this.orderId});
  

 final  int orderId;

/// Create a copy of SellerOrdersEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SellerOrderMarkReadyRequestedCopyWith<SellerOrderMarkReadyRequested> get copyWith => _$SellerOrderMarkReadyRequestedCopyWithImpl<SellerOrderMarkReadyRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerOrderMarkReadyRequested&&(identical(other.orderId, orderId) || other.orderId == orderId));
}


@override
int get hashCode => Object.hash(runtimeType,orderId);

@override
String toString() {
  return 'SellerOrdersEvent.markReadyRequested(orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class $SellerOrderMarkReadyRequestedCopyWith<$Res> implements $SellerOrdersEventCopyWith<$Res> {
  factory $SellerOrderMarkReadyRequestedCopyWith(SellerOrderMarkReadyRequested value, $Res Function(SellerOrderMarkReadyRequested) _then) = _$SellerOrderMarkReadyRequestedCopyWithImpl;
@useResult
$Res call({
 int orderId
});




}
/// @nodoc
class _$SellerOrderMarkReadyRequestedCopyWithImpl<$Res>
    implements $SellerOrderMarkReadyRequestedCopyWith<$Res> {
  _$SellerOrderMarkReadyRequestedCopyWithImpl(this._self, this._then);

  final SellerOrderMarkReadyRequested _self;
  final $Res Function(SellerOrderMarkReadyRequested) _then;

/// Create a copy of SellerOrdersEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,}) {
  return _then(SellerOrderMarkReadyRequested(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class SellerOrderMarkCompletedRequested implements SellerOrdersEvent {
  const SellerOrderMarkCompletedRequested({required this.orderId});
  

 final  int orderId;

/// Create a copy of SellerOrdersEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SellerOrderMarkCompletedRequestedCopyWith<SellerOrderMarkCompletedRequested> get copyWith => _$SellerOrderMarkCompletedRequestedCopyWithImpl<SellerOrderMarkCompletedRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerOrderMarkCompletedRequested&&(identical(other.orderId, orderId) || other.orderId == orderId));
}


@override
int get hashCode => Object.hash(runtimeType,orderId);

@override
String toString() {
  return 'SellerOrdersEvent.markCompletedRequested(orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class $SellerOrderMarkCompletedRequestedCopyWith<$Res> implements $SellerOrdersEventCopyWith<$Res> {
  factory $SellerOrderMarkCompletedRequestedCopyWith(SellerOrderMarkCompletedRequested value, $Res Function(SellerOrderMarkCompletedRequested) _then) = _$SellerOrderMarkCompletedRequestedCopyWithImpl;
@useResult
$Res call({
 int orderId
});




}
/// @nodoc
class _$SellerOrderMarkCompletedRequestedCopyWithImpl<$Res>
    implements $SellerOrderMarkCompletedRequestedCopyWith<$Res> {
  _$SellerOrderMarkCompletedRequestedCopyWithImpl(this._self, this._then);

  final SellerOrderMarkCompletedRequested _self;
  final $Res Function(SellerOrderMarkCompletedRequested) _then;

/// Create a copy of SellerOrdersEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,}) {
  return _then(SellerOrderMarkCompletedRequested(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class SellerOrdersMessageCleared implements SellerOrdersEvent {
  const SellerOrdersMessageCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerOrdersMessageCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellerOrdersEvent.messageCleared()';
}


}




/// @nodoc
mixin _$SellerOrdersState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerOrdersState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellerOrdersState()';
}


}

/// @nodoc
class $SellerOrdersStateCopyWith<$Res>  {
$SellerOrdersStateCopyWith(SellerOrdersState _, $Res Function(SellerOrdersState) __);
}


/// Adds pattern-matching-related methods to [SellerOrdersState].
extension SellerOrdersStatePatterns on SellerOrdersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SellerOrdersInitial value)?  initial,TResult Function( SellerOrdersLoading value)?  loading,TResult Function( SellerOrdersLoaded value)?  loaded,TResult Function( SellerOrdersError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SellerOrdersInitial() when initial != null:
return initial(_that);case SellerOrdersLoading() when loading != null:
return loading(_that);case SellerOrdersLoaded() when loaded != null:
return loaded(_that);case SellerOrdersError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SellerOrdersInitial value)  initial,required TResult Function( SellerOrdersLoading value)  loading,required TResult Function( SellerOrdersLoaded value)  loaded,required TResult Function( SellerOrdersError value)  error,}){
final _that = this;
switch (_that) {
case SellerOrdersInitial():
return initial(_that);case SellerOrdersLoading():
return loading(_that);case SellerOrdersLoaded():
return loaded(_that);case SellerOrdersError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SellerOrdersInitial value)?  initial,TResult? Function( SellerOrdersLoading value)?  loading,TResult? Function( SellerOrdersLoaded value)?  loaded,TResult? Function( SellerOrdersError value)?  error,}){
final _that = this;
switch (_that) {
case SellerOrdersInitial() when initial != null:
return initial(_that);case SellerOrdersLoading() when loading != null:
return loading(_that);case SellerOrdersLoaded() when loaded != null:
return loaded(_that);case SellerOrdersError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<OrderInfo> orders,  Set<int> updatingOrderIds,  String? message)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SellerOrdersInitial() when initial != null:
return initial();case SellerOrdersLoading() when loading != null:
return loading();case SellerOrdersLoaded() when loaded != null:
return loaded(_that.orders,_that.updatingOrderIds,_that.message);case SellerOrdersError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<OrderInfo> orders,  Set<int> updatingOrderIds,  String? message)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case SellerOrdersInitial():
return initial();case SellerOrdersLoading():
return loading();case SellerOrdersLoaded():
return loaded(_that.orders,_that.updatingOrderIds,_that.message);case SellerOrdersError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<OrderInfo> orders,  Set<int> updatingOrderIds,  String? message)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case SellerOrdersInitial() when initial != null:
return initial();case SellerOrdersLoading() when loading != null:
return loading();case SellerOrdersLoaded() when loaded != null:
return loaded(_that.orders,_that.updatingOrderIds,_that.message);case SellerOrdersError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class SellerOrdersInitial implements SellerOrdersState {
  const SellerOrdersInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerOrdersInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellerOrdersState.initial()';
}


}




/// @nodoc


class SellerOrdersLoading implements SellerOrdersState {
  const SellerOrdersLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerOrdersLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SellerOrdersState.loading()';
}


}




/// @nodoc


class SellerOrdersLoaded implements SellerOrdersState {
  const SellerOrdersLoaded({required final  List<OrderInfo> orders, final  Set<int> updatingOrderIds = const <int>{}, this.message}): _orders = orders,_updatingOrderIds = updatingOrderIds;
  

 final  List<OrderInfo> _orders;
 List<OrderInfo> get orders {
  if (_orders is EqualUnmodifiableListView) return _orders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orders);
}

 final  Set<int> _updatingOrderIds;
@JsonKey() Set<int> get updatingOrderIds {
  if (_updatingOrderIds is EqualUnmodifiableSetView) return _updatingOrderIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_updatingOrderIds);
}

 final  String? message;

/// Create a copy of SellerOrdersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SellerOrdersLoadedCopyWith<SellerOrdersLoaded> get copyWith => _$SellerOrdersLoadedCopyWithImpl<SellerOrdersLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerOrdersLoaded&&const DeepCollectionEquality().equals(other._orders, _orders)&&const DeepCollectionEquality().equals(other._updatingOrderIds, _updatingOrderIds)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_orders),const DeepCollectionEquality().hash(_updatingOrderIds),message);

@override
String toString() {
  return 'SellerOrdersState.loaded(orders: $orders, updatingOrderIds: $updatingOrderIds, message: $message)';
}


}

/// @nodoc
abstract mixin class $SellerOrdersLoadedCopyWith<$Res> implements $SellerOrdersStateCopyWith<$Res> {
  factory $SellerOrdersLoadedCopyWith(SellerOrdersLoaded value, $Res Function(SellerOrdersLoaded) _then) = _$SellerOrdersLoadedCopyWithImpl;
@useResult
$Res call({
 List<OrderInfo> orders, Set<int> updatingOrderIds, String? message
});




}
/// @nodoc
class _$SellerOrdersLoadedCopyWithImpl<$Res>
    implements $SellerOrdersLoadedCopyWith<$Res> {
  _$SellerOrdersLoadedCopyWithImpl(this._self, this._then);

  final SellerOrdersLoaded _self;
  final $Res Function(SellerOrdersLoaded) _then;

/// Create a copy of SellerOrdersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orders = null,Object? updatingOrderIds = null,Object? message = freezed,}) {
  return _then(SellerOrdersLoaded(
orders: null == orders ? _self._orders : orders // ignore: cast_nullable_to_non_nullable
as List<OrderInfo>,updatingOrderIds: null == updatingOrderIds ? _self._updatingOrderIds : updatingOrderIds // ignore: cast_nullable_to_non_nullable
as Set<int>,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class SellerOrdersError implements SellerOrdersState {
  const SellerOrdersError(this.message);
  

 final  String message;

/// Create a copy of SellerOrdersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SellerOrdersErrorCopyWith<SellerOrdersError> get copyWith => _$SellerOrdersErrorCopyWithImpl<SellerOrdersError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SellerOrdersError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SellerOrdersState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $SellerOrdersErrorCopyWith<$Res> implements $SellerOrdersStateCopyWith<$Res> {
  factory $SellerOrdersErrorCopyWith(SellerOrdersError value, $Res Function(SellerOrdersError) _then) = _$SellerOrdersErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SellerOrdersErrorCopyWithImpl<$Res>
    implements $SellerOrdersErrorCopyWith<$Res> {
  _$SellerOrdersErrorCopyWithImpl(this._self, this._then);

  final SellerOrdersError _self;
  final $Res Function(SellerOrdersError) _then;

/// Create a copy of SellerOrdersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SellerOrdersError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
