// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_form_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductFormEvent {

 String get name; String get price; String? get description; String? get imageUrl;// صورة جديدة اختارها البائع وتحتاج رفعًا قبل الحفظ.
 Uint8List? get newImageBytes; String? get newImageExtension;
/// Create a copy of ProductFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductFormEventCopyWith<ProductFormEvent> get copyWith => _$ProductFormEventCopyWithImpl<ProductFormEvent>(this as ProductFormEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductFormEvent&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.newImageBytes, newImageBytes)&&(identical(other.newImageExtension, newImageExtension) || other.newImageExtension == newImageExtension));
}


@override
int get hashCode => Object.hash(runtimeType,name,price,description,imageUrl,const DeepCollectionEquality().hash(newImageBytes),newImageExtension);

@override
String toString() {
  return 'ProductFormEvent(name: $name, price: $price, description: $description, imageUrl: $imageUrl, newImageBytes: $newImageBytes, newImageExtension: $newImageExtension)';
}


}

/// @nodoc
abstract mixin class $ProductFormEventCopyWith<$Res>  {
  factory $ProductFormEventCopyWith(ProductFormEvent value, $Res Function(ProductFormEvent) _then) = _$ProductFormEventCopyWithImpl;
@useResult
$Res call({
 String name, String price, String? description, String? imageUrl, Uint8List? newImageBytes, String? newImageExtension
});




}
/// @nodoc
class _$ProductFormEventCopyWithImpl<$Res>
    implements $ProductFormEventCopyWith<$Res> {
  _$ProductFormEventCopyWithImpl(this._self, this._then);

  final ProductFormEvent _self;
  final $Res Function(ProductFormEvent) _then;

/// Create a copy of ProductFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? price = null,Object? description = freezed,Object? imageUrl = freezed,Object? newImageBytes = freezed,Object? newImageExtension = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,newImageBytes: freezed == newImageBytes ? _self.newImageBytes : newImageBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,newImageExtension: freezed == newImageExtension ? _self.newImageExtension : newImageExtension // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductFormEvent].
extension ProductFormEventPatterns on ProductFormEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProductFormSubmitted value)?  submitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProductFormSubmitted() when submitted != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProductFormSubmitted value)  submitted,}){
final _that = this;
switch (_that) {
case ProductFormSubmitted():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProductFormSubmitted value)?  submitted,}){
final _that = this;
switch (_that) {
case ProductFormSubmitted() when submitted != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String name,  String price,  String? description,  String? imageUrl,  Uint8List? newImageBytes,  String? newImageExtension)?  submitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProductFormSubmitted() when submitted != null:
return submitted(_that.name,_that.price,_that.description,_that.imageUrl,_that.newImageBytes,_that.newImageExtension);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String name,  String price,  String? description,  String? imageUrl,  Uint8List? newImageBytes,  String? newImageExtension)  submitted,}) {final _that = this;
switch (_that) {
case ProductFormSubmitted():
return submitted(_that.name,_that.price,_that.description,_that.imageUrl,_that.newImageBytes,_that.newImageExtension);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String name,  String price,  String? description,  String? imageUrl,  Uint8List? newImageBytes,  String? newImageExtension)?  submitted,}) {final _that = this;
switch (_that) {
case ProductFormSubmitted() when submitted != null:
return submitted(_that.name,_that.price,_that.description,_that.imageUrl,_that.newImageBytes,_that.newImageExtension);case _:
  return null;

}
}

}

/// @nodoc


class ProductFormSubmitted implements ProductFormEvent {
  const ProductFormSubmitted({required this.name, required this.price, this.description, this.imageUrl, this.newImageBytes, this.newImageExtension});
  

@override final  String name;
@override final  String price;
@override final  String? description;
@override final  String? imageUrl;
// صورة جديدة اختارها البائع وتحتاج رفعًا قبل الحفظ.
@override final  Uint8List? newImageBytes;
@override final  String? newImageExtension;

/// Create a copy of ProductFormEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductFormSubmittedCopyWith<ProductFormSubmitted> get copyWith => _$ProductFormSubmittedCopyWithImpl<ProductFormSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductFormSubmitted&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.newImageBytes, newImageBytes)&&(identical(other.newImageExtension, newImageExtension) || other.newImageExtension == newImageExtension));
}


@override
int get hashCode => Object.hash(runtimeType,name,price,description,imageUrl,const DeepCollectionEquality().hash(newImageBytes),newImageExtension);

@override
String toString() {
  return 'ProductFormEvent.submitted(name: $name, price: $price, description: $description, imageUrl: $imageUrl, newImageBytes: $newImageBytes, newImageExtension: $newImageExtension)';
}


}

/// @nodoc
abstract mixin class $ProductFormSubmittedCopyWith<$Res> implements $ProductFormEventCopyWith<$Res> {
  factory $ProductFormSubmittedCopyWith(ProductFormSubmitted value, $Res Function(ProductFormSubmitted) _then) = _$ProductFormSubmittedCopyWithImpl;
@override @useResult
$Res call({
 String name, String price, String? description, String? imageUrl, Uint8List? newImageBytes, String? newImageExtension
});




}
/// @nodoc
class _$ProductFormSubmittedCopyWithImpl<$Res>
    implements $ProductFormSubmittedCopyWith<$Res> {
  _$ProductFormSubmittedCopyWithImpl(this._self, this._then);

  final ProductFormSubmitted _self;
  final $Res Function(ProductFormSubmitted) _then;

/// Create a copy of ProductFormEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? price = null,Object? description = freezed,Object? imageUrl = freezed,Object? newImageBytes = freezed,Object? newImageExtension = freezed,}) {
  return _then(ProductFormSubmitted(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,newImageBytes: freezed == newImageBytes ? _self.newImageBytes : newImageBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,newImageExtension: freezed == newImageExtension ? _self.newImageExtension : newImageExtension // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$ProductFormState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductFormState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductFormState()';
}


}

/// @nodoc
class $ProductFormStateCopyWith<$Res>  {
$ProductFormStateCopyWith(ProductFormState _, $Res Function(ProductFormState) __);
}


/// Adds pattern-matching-related methods to [ProductFormState].
extension ProductFormStatePatterns on ProductFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProductFormInitial value)?  initial,TResult Function( ProductFormSubmitting value)?  submitting,TResult Function( ProductFormSuccess value)?  success,TResult Function( ProductFormFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProductFormInitial() when initial != null:
return initial(_that);case ProductFormSubmitting() when submitting != null:
return submitting(_that);case ProductFormSuccess() when success != null:
return success(_that);case ProductFormFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProductFormInitial value)  initial,required TResult Function( ProductFormSubmitting value)  submitting,required TResult Function( ProductFormSuccess value)  success,required TResult Function( ProductFormFailure value)  failure,}){
final _that = this;
switch (_that) {
case ProductFormInitial():
return initial(_that);case ProductFormSubmitting():
return submitting(_that);case ProductFormSuccess():
return success(_that);case ProductFormFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProductFormInitial value)?  initial,TResult? Function( ProductFormSubmitting value)?  submitting,TResult? Function( ProductFormSuccess value)?  success,TResult? Function( ProductFormFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ProductFormInitial() when initial != null:
return initial(_that);case ProductFormSubmitting() when submitting != null:
return submitting(_that);case ProductFormSuccess() when success != null:
return success(_that);case ProductFormFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  submitting,TResult Function( Product product)?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProductFormInitial() when initial != null:
return initial();case ProductFormSubmitting() when submitting != null:
return submitting();case ProductFormSuccess() when success != null:
return success(_that.product);case ProductFormFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  submitting,required TResult Function( Product product)  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case ProductFormInitial():
return initial();case ProductFormSubmitting():
return submitting();case ProductFormSuccess():
return success(_that.product);case ProductFormFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  submitting,TResult? Function( Product product)?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case ProductFormInitial() when initial != null:
return initial();case ProductFormSubmitting() when submitting != null:
return submitting();case ProductFormSuccess() when success != null:
return success(_that.product);case ProductFormFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ProductFormInitial implements ProductFormState {
  const ProductFormInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductFormInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductFormState.initial()';
}


}




/// @nodoc


class ProductFormSubmitting implements ProductFormState {
  const ProductFormSubmitting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductFormSubmitting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductFormState.submitting()';
}


}




/// @nodoc


class ProductFormSuccess implements ProductFormState {
  const ProductFormSuccess(this.product);
  

 final  Product product;

/// Create a copy of ProductFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductFormSuccessCopyWith<ProductFormSuccess> get copyWith => _$ProductFormSuccessCopyWithImpl<ProductFormSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductFormSuccess&&(identical(other.product, product) || other.product == product));
}


@override
int get hashCode => Object.hash(runtimeType,product);

@override
String toString() {
  return 'ProductFormState.success(product: $product)';
}


}

/// @nodoc
abstract mixin class $ProductFormSuccessCopyWith<$Res> implements $ProductFormStateCopyWith<$Res> {
  factory $ProductFormSuccessCopyWith(ProductFormSuccess value, $Res Function(ProductFormSuccess) _then) = _$ProductFormSuccessCopyWithImpl;
@useResult
$Res call({
 Product product
});




}
/// @nodoc
class _$ProductFormSuccessCopyWithImpl<$Res>
    implements $ProductFormSuccessCopyWith<$Res> {
  _$ProductFormSuccessCopyWithImpl(this._self, this._then);

  final ProductFormSuccess _self;
  final $Res Function(ProductFormSuccess) _then;

/// Create a copy of ProductFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,}) {
  return _then(ProductFormSuccess(
null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product,
  ));
}


}

/// @nodoc


class ProductFormFailure implements ProductFormState {
  const ProductFormFailure(this.message);
  

 final  String message;

/// Create a copy of ProductFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductFormFailureCopyWith<ProductFormFailure> get copyWith => _$ProductFormFailureCopyWithImpl<ProductFormFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductFormFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ProductFormState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $ProductFormFailureCopyWith<$Res> implements $ProductFormStateCopyWith<$Res> {
  factory $ProductFormFailureCopyWith(ProductFormFailure value, $Res Function(ProductFormFailure) _then) = _$ProductFormFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ProductFormFailureCopyWithImpl<$Res>
    implements $ProductFormFailureCopyWith<$Res> {
  _$ProductFormFailureCopyWithImpl(this._self, this._then);

  final ProductFormFailure _self;
  final $Res Function(ProductFormFailure) _then;

/// Create a copy of ProductFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ProductFormFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
