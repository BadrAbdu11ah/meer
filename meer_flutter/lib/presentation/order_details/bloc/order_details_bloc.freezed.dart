// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_details_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderDetailsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderDetailsEvent()';
}


}

/// @nodoc
class $OrderDetailsEventCopyWith<$Res>  {
$OrderDetailsEventCopyWith(OrderDetailsEvent _, $Res Function(OrderDetailsEvent) __);
}


/// Adds pattern-matching-related methods to [OrderDetailsEvent].
extension OrderDetailsEventPatterns on OrderDetailsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OrderDetailsLoadRequested value)?  loadRequested,TResult Function( OrderDetailsRefreshRequested value)?  refreshRequested,TResult Function( OrderDetailsCancelRequested value)?  cancelRequested,TResult Function( OrderDetailsAcceptRequested value)?  acceptRequested,TResult Function( OrderDetailsRejectRequested value)?  rejectRequested,TResult Function( OrderDetailsMarkReadyRequested value)?  markReadyRequested,TResult Function( OrderDetailsMarkCompletedRequested value)?  markCompletedRequested,TResult Function( OrderDetailsMessageCleared value)?  messageCleared,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OrderDetailsLoadRequested() when loadRequested != null:
return loadRequested(_that);case OrderDetailsRefreshRequested() when refreshRequested != null:
return refreshRequested(_that);case OrderDetailsCancelRequested() when cancelRequested != null:
return cancelRequested(_that);case OrderDetailsAcceptRequested() when acceptRequested != null:
return acceptRequested(_that);case OrderDetailsRejectRequested() when rejectRequested != null:
return rejectRequested(_that);case OrderDetailsMarkReadyRequested() when markReadyRequested != null:
return markReadyRequested(_that);case OrderDetailsMarkCompletedRequested() when markCompletedRequested != null:
return markCompletedRequested(_that);case OrderDetailsMessageCleared() when messageCleared != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OrderDetailsLoadRequested value)  loadRequested,required TResult Function( OrderDetailsRefreshRequested value)  refreshRequested,required TResult Function( OrderDetailsCancelRequested value)  cancelRequested,required TResult Function( OrderDetailsAcceptRequested value)  acceptRequested,required TResult Function( OrderDetailsRejectRequested value)  rejectRequested,required TResult Function( OrderDetailsMarkReadyRequested value)  markReadyRequested,required TResult Function( OrderDetailsMarkCompletedRequested value)  markCompletedRequested,required TResult Function( OrderDetailsMessageCleared value)  messageCleared,}){
final _that = this;
switch (_that) {
case OrderDetailsLoadRequested():
return loadRequested(_that);case OrderDetailsRefreshRequested():
return refreshRequested(_that);case OrderDetailsCancelRequested():
return cancelRequested(_that);case OrderDetailsAcceptRequested():
return acceptRequested(_that);case OrderDetailsRejectRequested():
return rejectRequested(_that);case OrderDetailsMarkReadyRequested():
return markReadyRequested(_that);case OrderDetailsMarkCompletedRequested():
return markCompletedRequested(_that);case OrderDetailsMessageCleared():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OrderDetailsLoadRequested value)?  loadRequested,TResult? Function( OrderDetailsRefreshRequested value)?  refreshRequested,TResult? Function( OrderDetailsCancelRequested value)?  cancelRequested,TResult? Function( OrderDetailsAcceptRequested value)?  acceptRequested,TResult? Function( OrderDetailsRejectRequested value)?  rejectRequested,TResult? Function( OrderDetailsMarkReadyRequested value)?  markReadyRequested,TResult? Function( OrderDetailsMarkCompletedRequested value)?  markCompletedRequested,TResult? Function( OrderDetailsMessageCleared value)?  messageCleared,}){
final _that = this;
switch (_that) {
case OrderDetailsLoadRequested() when loadRequested != null:
return loadRequested(_that);case OrderDetailsRefreshRequested() when refreshRequested != null:
return refreshRequested(_that);case OrderDetailsCancelRequested() when cancelRequested != null:
return cancelRequested(_that);case OrderDetailsAcceptRequested() when acceptRequested != null:
return acceptRequested(_that);case OrderDetailsRejectRequested() when rejectRequested != null:
return rejectRequested(_that);case OrderDetailsMarkReadyRequested() when markReadyRequested != null:
return markReadyRequested(_that);case OrderDetailsMarkCompletedRequested() when markCompletedRequested != null:
return markCompletedRequested(_that);case OrderDetailsMessageCleared() when messageCleared != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int orderId,  bool isSellerView)?  loadRequested,TResult Function()?  refreshRequested,TResult Function()?  cancelRequested,TResult Function()?  acceptRequested,TResult Function()?  rejectRequested,TResult Function()?  markReadyRequested,TResult Function()?  markCompletedRequested,TResult Function()?  messageCleared,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OrderDetailsLoadRequested() when loadRequested != null:
return loadRequested(_that.orderId,_that.isSellerView);case OrderDetailsRefreshRequested() when refreshRequested != null:
return refreshRequested();case OrderDetailsCancelRequested() when cancelRequested != null:
return cancelRequested();case OrderDetailsAcceptRequested() when acceptRequested != null:
return acceptRequested();case OrderDetailsRejectRequested() when rejectRequested != null:
return rejectRequested();case OrderDetailsMarkReadyRequested() when markReadyRequested != null:
return markReadyRequested();case OrderDetailsMarkCompletedRequested() when markCompletedRequested != null:
return markCompletedRequested();case OrderDetailsMessageCleared() when messageCleared != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int orderId,  bool isSellerView)  loadRequested,required TResult Function()  refreshRequested,required TResult Function()  cancelRequested,required TResult Function()  acceptRequested,required TResult Function()  rejectRequested,required TResult Function()  markReadyRequested,required TResult Function()  markCompletedRequested,required TResult Function()  messageCleared,}) {final _that = this;
switch (_that) {
case OrderDetailsLoadRequested():
return loadRequested(_that.orderId,_that.isSellerView);case OrderDetailsRefreshRequested():
return refreshRequested();case OrderDetailsCancelRequested():
return cancelRequested();case OrderDetailsAcceptRequested():
return acceptRequested();case OrderDetailsRejectRequested():
return rejectRequested();case OrderDetailsMarkReadyRequested():
return markReadyRequested();case OrderDetailsMarkCompletedRequested():
return markCompletedRequested();case OrderDetailsMessageCleared():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int orderId,  bool isSellerView)?  loadRequested,TResult? Function()?  refreshRequested,TResult? Function()?  cancelRequested,TResult? Function()?  acceptRequested,TResult? Function()?  rejectRequested,TResult? Function()?  markReadyRequested,TResult? Function()?  markCompletedRequested,TResult? Function()?  messageCleared,}) {final _that = this;
switch (_that) {
case OrderDetailsLoadRequested() when loadRequested != null:
return loadRequested(_that.orderId,_that.isSellerView);case OrderDetailsRefreshRequested() when refreshRequested != null:
return refreshRequested();case OrderDetailsCancelRequested() when cancelRequested != null:
return cancelRequested();case OrderDetailsAcceptRequested() when acceptRequested != null:
return acceptRequested();case OrderDetailsRejectRequested() when rejectRequested != null:
return rejectRequested();case OrderDetailsMarkReadyRequested() when markReadyRequested != null:
return markReadyRequested();case OrderDetailsMarkCompletedRequested() when markCompletedRequested != null:
return markCompletedRequested();case OrderDetailsMessageCleared() when messageCleared != null:
return messageCleared();case _:
  return null;

}
}

}

/// @nodoc


class OrderDetailsLoadRequested implements OrderDetailsEvent {
  const OrderDetailsLoadRequested({required this.orderId, required this.isSellerView});


 final  int orderId;
 final  bool isSellerView;

/// Create a copy of OrderDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailsLoadRequestedCopyWith<OrderDetailsLoadRequested> get copyWith => _$OrderDetailsLoadRequestedCopyWithImpl<OrderDetailsLoadRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsLoadRequested&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.isSellerView, isSellerView) || other.isSellerView == isSellerView));
}


@override
int get hashCode => Object.hash(runtimeType,orderId,isSellerView);

@override
String toString() {
  return 'OrderDetailsEvent.loadRequested(orderId: $orderId, isSellerView: $isSellerView)';
}


}

/// @nodoc
abstract mixin class $OrderDetailsLoadRequestedCopyWith<$Res> implements $OrderDetailsEventCopyWith<$Res> {
  factory $OrderDetailsLoadRequestedCopyWith(OrderDetailsLoadRequested value, $Res Function(OrderDetailsLoadRequested) _then) = _$OrderDetailsLoadRequestedCopyWithImpl;
@useResult
$Res call({
 int orderId, bool isSellerView
});




}
/// @nodoc
class _$OrderDetailsLoadRequestedCopyWithImpl<$Res>
    implements $OrderDetailsLoadRequestedCopyWith<$Res> {
  _$OrderDetailsLoadRequestedCopyWithImpl(this._self, this._then);

  final OrderDetailsLoadRequested _self;
  final $Res Function(OrderDetailsLoadRequested) _then;

/// Create a copy of OrderDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? isSellerView = null,}) {
  return _then(OrderDetailsLoadRequested(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,isSellerView: null == isSellerView ? _self.isSellerView : isSellerView // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class OrderDetailsRefreshRequested implements OrderDetailsEvent {
  const OrderDetailsRefreshRequested();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsRefreshRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderDetailsEvent.refreshRequested()';
}


}




/// @nodoc


class OrderDetailsCancelRequested implements OrderDetailsEvent {
  const OrderDetailsCancelRequested();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsCancelRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderDetailsEvent.cancelRequested()';
}


}




/// @nodoc


class OrderDetailsAcceptRequested implements OrderDetailsEvent {
  const OrderDetailsAcceptRequested();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsAcceptRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderDetailsEvent.acceptRequested()';
}


}




/// @nodoc


class OrderDetailsRejectRequested implements OrderDetailsEvent {
  const OrderDetailsRejectRequested();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsRejectRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderDetailsEvent.rejectRequested()';
}


}




/// @nodoc


class OrderDetailsMarkReadyRequested implements OrderDetailsEvent {
  const OrderDetailsMarkReadyRequested();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsMarkReadyRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderDetailsEvent.markReadyRequested()';
}


}




/// @nodoc


class OrderDetailsMarkCompletedRequested implements OrderDetailsEvent {
  const OrderDetailsMarkCompletedRequested();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsMarkCompletedRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderDetailsEvent.markCompletedRequested()';
}


}




/// @nodoc


class OrderDetailsMessageCleared implements OrderDetailsEvent {
  const OrderDetailsMessageCleared();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsMessageCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderDetailsEvent.messageCleared()';
}


}




/// @nodoc
mixin _$OrderDetailsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderDetailsState()';
}


}

/// @nodoc
class $OrderDetailsStateCopyWith<$Res>  {
$OrderDetailsStateCopyWith(OrderDetailsState _, $Res Function(OrderDetailsState) __);
}


/// Adds pattern-matching-related methods to [OrderDetailsState].
extension OrderDetailsStatePatterns on OrderDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OrderDetailsInitial value)?  initial,TResult Function( OrderDetailsLoading value)?  loading,TResult Function( OrderDetailsLoaded value)?  loaded,TResult Function( OrderDetailsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OrderDetailsInitial() when initial != null:
return initial(_that);case OrderDetailsLoading() when loading != null:
return loading(_that);case OrderDetailsLoaded() when loaded != null:
return loaded(_that);case OrderDetailsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OrderDetailsInitial value)  initial,required TResult Function( OrderDetailsLoading value)  loading,required TResult Function( OrderDetailsLoaded value)  loaded,required TResult Function( OrderDetailsError value)  error,}){
final _that = this;
switch (_that) {
case OrderDetailsInitial():
return initial(_that);case OrderDetailsLoading():
return loading(_that);case OrderDetailsLoaded():
return loaded(_that);case OrderDetailsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OrderDetailsInitial value)?  initial,TResult? Function( OrderDetailsLoading value)?  loading,TResult? Function( OrderDetailsLoaded value)?  loaded,TResult? Function( OrderDetailsError value)?  error,}){
final _that = this;
switch (_that) {
case OrderDetailsInitial() when initial != null:
return initial(_that);case OrderDetailsLoading() when loading != null:
return loading(_that);case OrderDetailsLoaded() when loaded != null:
return loaded(_that);case OrderDetailsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( OrderPresentation presentation,  bool isUpdating,  String? message)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OrderDetailsInitial() when initial != null:
return initial();case OrderDetailsLoading() when loading != null:
return loading();case OrderDetailsLoaded() when loaded != null:
return loaded(_that.presentation,_that.isUpdating,_that.message);case OrderDetailsError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( OrderPresentation presentation,  bool isUpdating,  String? message)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case OrderDetailsInitial():
return initial();case OrderDetailsLoading():
return loading();case OrderDetailsLoaded():
return loaded(_that.presentation,_that.isUpdating,_that.message);case OrderDetailsError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( OrderPresentation presentation,  bool isUpdating,  String? message)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case OrderDetailsInitial() when initial != null:
return initial();case OrderDetailsLoading() when loading != null:
return loading();case OrderDetailsLoaded() when loaded != null:
return loaded(_that.presentation,_that.isUpdating,_that.message);case OrderDetailsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class OrderDetailsInitial implements OrderDetailsState {
  const OrderDetailsInitial();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderDetailsState.initial()';
}


}




/// @nodoc


class OrderDetailsLoading implements OrderDetailsState {
  const OrderDetailsLoading();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OrderDetailsState.loading()';
}


}




/// @nodoc


class OrderDetailsLoaded implements OrderDetailsState {
  const OrderDetailsLoaded({required this.presentation, this.isUpdating = false, this.message});


 final  OrderPresentation presentation;
@JsonKey() final  bool isUpdating;
 final  String? message;

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailsLoadedCopyWith<OrderDetailsLoaded> get copyWith => _$OrderDetailsLoadedCopyWithImpl<OrderDetailsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsLoaded&&(identical(other.presentation, presentation) || other.presentation == presentation)&&(identical(other.isUpdating, isUpdating) || other.isUpdating == isUpdating)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,presentation,isUpdating,message);

@override
String toString() {
  return 'OrderDetailsState.loaded(presentation: $presentation, isUpdating: $isUpdating, message: $message)';
}


}

/// @nodoc
abstract mixin class $OrderDetailsLoadedCopyWith<$Res> implements $OrderDetailsStateCopyWith<$Res> {
  factory $OrderDetailsLoadedCopyWith(OrderDetailsLoaded value, $Res Function(OrderDetailsLoaded) _then) = _$OrderDetailsLoadedCopyWithImpl;
@useResult
$Res call({
 OrderPresentation presentation, bool isUpdating, String? message
});




}
/// @nodoc
class _$OrderDetailsLoadedCopyWithImpl<$Res>
    implements $OrderDetailsLoadedCopyWith<$Res> {
  _$OrderDetailsLoadedCopyWithImpl(this._self, this._then);

  final OrderDetailsLoaded _self;
  final $Res Function(OrderDetailsLoaded) _then;

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? presentation = null,Object? isUpdating = null,Object? message = freezed,}) {
  return _then(OrderDetailsLoaded(
presentation: null == presentation ? _self.presentation : presentation // ignore: cast_nullable_to_non_nullable
as OrderPresentation,isUpdating: null == isUpdating ? _self.isUpdating : isUpdating // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class OrderDetailsError implements OrderDetailsState {
  const OrderDetailsError(this.message);


 final  String message;

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailsErrorCopyWith<OrderDetailsError> get copyWith => _$OrderDetailsErrorCopyWithImpl<OrderDetailsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'OrderDetailsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $OrderDetailsErrorCopyWith<$Res> implements $OrderDetailsStateCopyWith<$Res> {
  factory $OrderDetailsErrorCopyWith(OrderDetailsError value, $Res Function(OrderDetailsError) _then) = _$OrderDetailsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$OrderDetailsErrorCopyWithImpl<$Res>
    implements $OrderDetailsErrorCopyWith<$Res> {
  _$OrderDetailsErrorCopyWithImpl(this._self, this._then);

  final OrderDetailsError _self;
  final $Res Function(OrderDetailsError) _then;

/// Create a copy of OrderDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(OrderDetailsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
