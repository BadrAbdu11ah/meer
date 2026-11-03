// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchEvent()';
}


}

/// @nodoc
class $SearchEventCopyWith<$Res>  {
$SearchEventCopyWith(SearchEvent _, $Res Function(SearchEvent) __);
}


/// Adds pattern-matching-related methods to [SearchEvent].
extension SearchEventPatterns on SearchEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( QueryChanged value)?  queryChanged,TResult Function( ClearSearch value)?  clearSearch,required TResult orElse(),}){
final _that = this;
switch (_that) {
case QueryChanged() when queryChanged != null:
return queryChanged(_that);case ClearSearch() when clearSearch != null:
return clearSearch(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( QueryChanged value)  queryChanged,required TResult Function( ClearSearch value)  clearSearch,}){
final _that = this;
switch (_that) {
case QueryChanged():
return queryChanged(_that);case ClearSearch():
return clearSearch(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( QueryChanged value)?  queryChanged,TResult? Function( ClearSearch value)?  clearSearch,}){
final _that = this;
switch (_that) {
case QueryChanged() when queryChanged != null:
return queryChanged(_that);case ClearSearch() when clearSearch != null:
return clearSearch(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String query)?  queryChanged,TResult Function()?  clearSearch,required TResult orElse(),}) {final _that = this;
switch (_that) {
case QueryChanged() when queryChanged != null:
return queryChanged(_that.query);case ClearSearch() when clearSearch != null:
return clearSearch();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String query)  queryChanged,required TResult Function()  clearSearch,}) {final _that = this;
switch (_that) {
case QueryChanged():
return queryChanged(_that.query);case ClearSearch():
return clearSearch();case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String query)?  queryChanged,TResult? Function()?  clearSearch,}) {final _that = this;
switch (_that) {
case QueryChanged() when queryChanged != null:
return queryChanged(_that.query);case ClearSearch() when clearSearch != null:
return clearSearch();case _:
  return null;

}
}

}

/// @nodoc


class QueryChanged implements SearchEvent {
  const QueryChanged(this.query);
  

 final  String query;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueryChangedCopyWith<QueryChanged> get copyWith => _$QueryChangedCopyWithImpl<QueryChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueryChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'SearchEvent.queryChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class $QueryChangedCopyWith<$Res> implements $SearchEventCopyWith<$Res> {
  factory $QueryChangedCopyWith(QueryChanged value, $Res Function(QueryChanged) _then) = _$QueryChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$QueryChangedCopyWithImpl<$Res>
    implements $QueryChangedCopyWith<$Res> {
  _$QueryChangedCopyWithImpl(this._self, this._then);

  final QueryChanged _self;
  final $Res Function(QueryChanged) _then;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(QueryChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ClearSearch implements SearchEvent {
  const ClearSearch();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClearSearch);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchEvent.clearSearch()';
}


}




/// @nodoc
mixin _$SearchStatus {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchStatus()';
}


}

/// @nodoc
class $SearchStatusCopyWith<$Res>  {
$SearchStatusCopyWith(SearchStatus _, $Res Function(SearchStatus) __);
}


/// Adds pattern-matching-related methods to [SearchStatus].
extension SearchStatusPatterns on SearchStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SearchInitial value)?  initial,TResult Function( _SearchLoading value)?  loading,TResult Function( _SearchLoaded value)?  loaded,TResult Function( _SearchNotFound value)?  notFound,TResult Function( _SearchFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchInitial() when initial != null:
return initial(_that);case _SearchLoading() when loading != null:
return loading(_that);case _SearchLoaded() when loaded != null:
return loaded(_that);case _SearchNotFound() when notFound != null:
return notFound(_that);case _SearchFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SearchInitial value)  initial,required TResult Function( _SearchLoading value)  loading,required TResult Function( _SearchLoaded value)  loaded,required TResult Function( _SearchNotFound value)  notFound,required TResult Function( _SearchFailure value)  failure,}){
final _that = this;
switch (_that) {
case _SearchInitial():
return initial(_that);case _SearchLoading():
return loading(_that);case _SearchLoaded():
return loaded(_that);case _SearchNotFound():
return notFound(_that);case _SearchFailure():
return failure(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SearchInitial value)?  initial,TResult? Function( _SearchLoading value)?  loading,TResult? Function( _SearchLoaded value)?  loaded,TResult? Function( _SearchNotFound value)?  notFound,TResult? Function( _SearchFailure value)?  failure,}){
final _that = this;
switch (_that) {
case _SearchInitial() when initial != null:
return initial(_that);case _SearchLoading() when loading != null:
return loading(_that);case _SearchLoaded() when loaded != null:
return loaded(_that);case _SearchNotFound() when notFound != null:
return notFound(_that);case _SearchFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  loaded,TResult Function()?  notFound,TResult Function( String errorMessage)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchInitial() when initial != null:
return initial();case _SearchLoading() when loading != null:
return loading();case _SearchLoaded() when loaded != null:
return loaded();case _SearchNotFound() when notFound != null:
return notFound();case _SearchFailure() when failure != null:
return failure(_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  loaded,required TResult Function()  notFound,required TResult Function( String errorMessage)  failure,}) {final _that = this;
switch (_that) {
case _SearchInitial():
return initial();case _SearchLoading():
return loading();case _SearchLoaded():
return loaded();case _SearchNotFound():
return notFound();case _SearchFailure():
return failure(_that.errorMessage);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  loaded,TResult? Function()?  notFound,TResult? Function( String errorMessage)?  failure,}) {final _that = this;
switch (_that) {
case _SearchInitial() when initial != null:
return initial();case _SearchLoading() when loading != null:
return loading();case _SearchLoaded() when loaded != null:
return loaded();case _SearchNotFound() when notFound != null:
return notFound();case _SearchFailure() when failure != null:
return failure(_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _SearchInitial implements SearchStatus {
  const _SearchInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchStatus.initial()';
}


}




/// @nodoc


class _SearchLoading implements SearchStatus {
  const _SearchLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchStatus.loading()';
}


}




/// @nodoc


class _SearchLoaded implements SearchStatus {
  const _SearchLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchStatus.loaded()';
}


}




/// @nodoc


class _SearchNotFound implements SearchStatus {
  const _SearchNotFound();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchNotFound);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchStatus.notFound()';
}


}




/// @nodoc


class _SearchFailure implements SearchStatus {
  const _SearchFailure(this.errorMessage);
  

 final  String errorMessage;

/// Create a copy of SearchStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchFailureCopyWith<_SearchFailure> get copyWith => __$SearchFailureCopyWithImpl<_SearchFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchFailure&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage);

@override
String toString() {
  return 'SearchStatus.failure(errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$SearchFailureCopyWith<$Res> implements $SearchStatusCopyWith<$Res> {
  factory _$SearchFailureCopyWith(_SearchFailure value, $Res Function(_SearchFailure) _then) = __$SearchFailureCopyWithImpl;
@useResult
$Res call({
 String errorMessage
});




}
/// @nodoc
class __$SearchFailureCopyWithImpl<$Res>
    implements _$SearchFailureCopyWith<$Res> {
  __$SearchFailureCopyWithImpl(this._self, this._then);

  final _SearchFailure _self;
  final $Res Function(_SearchFailure) _then;

/// Create a copy of SearchStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,}) {
  return _then(_SearchFailure(
null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SearchState {

 SearchStatus get status; List<Product> get searchResults;
/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchStateCopyWith<SearchState> get copyWith => _$SearchStateCopyWithImpl<SearchState>(this as SearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.searchResults, searchResults));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(searchResults));

@override
String toString() {
  return 'SearchState(status: $status, searchResults: $searchResults)';
}


}

/// @nodoc
abstract mixin class $SearchStateCopyWith<$Res>  {
  factory $SearchStateCopyWith(SearchState value, $Res Function(SearchState) _then) = _$SearchStateCopyWithImpl;
@useResult
$Res call({
 SearchStatus status, List<Product> searchResults
});


$SearchStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$SearchStateCopyWithImpl<$Res>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._self, this._then);

  final SearchState _self;
  final $Res Function(SearchState) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? searchResults = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SearchStatus,searchResults: null == searchResults ? _self.searchResults : searchResults // ignore: cast_nullable_to_non_nullable
as List<Product>,
  ));
}
/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchStatusCopyWith<$Res> get status {
  
  return $SearchStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [SearchState].
extension SearchStatePatterns on SearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchState value)  $default,){
final _that = this;
switch (_that) {
case _SearchState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchState value)?  $default,){
final _that = this;
switch (_that) {
case _SearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SearchStatus status,  List<Product> searchResults)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchState() when $default != null:
return $default(_that.status,_that.searchResults);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SearchStatus status,  List<Product> searchResults)  $default,) {final _that = this;
switch (_that) {
case _SearchState():
return $default(_that.status,_that.searchResults);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SearchStatus status,  List<Product> searchResults)?  $default,) {final _that = this;
switch (_that) {
case _SearchState() when $default != null:
return $default(_that.status,_that.searchResults);case _:
  return null;

}
}

}

/// @nodoc


class _SearchState implements SearchState {
  const _SearchState({this.status = const SearchStatus.initial(), final  List<Product> searchResults = const []}): _searchResults = searchResults;
  

@override@JsonKey() final  SearchStatus status;
 final  List<Product> _searchResults;
@override@JsonKey() List<Product> get searchResults {
  if (_searchResults is EqualUnmodifiableListView) return _searchResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_searchResults);
}


/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchStateCopyWith<_SearchState> get copyWith => __$SearchStateCopyWithImpl<_SearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._searchResults, _searchResults));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_searchResults));

@override
String toString() {
  return 'SearchState(status: $status, searchResults: $searchResults)';
}


}

/// @nodoc
abstract mixin class _$SearchStateCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory _$SearchStateCopyWith(_SearchState value, $Res Function(_SearchState) _then) = __$SearchStateCopyWithImpl;
@override @useResult
$Res call({
 SearchStatus status, List<Product> searchResults
});


@override $SearchStatusCopyWith<$Res> get status;

}
/// @nodoc
class __$SearchStateCopyWithImpl<$Res>
    implements _$SearchStateCopyWith<$Res> {
  __$SearchStateCopyWithImpl(this._self, this._then);

  final _SearchState _self;
  final $Res Function(_SearchState) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? searchResults = null,}) {
  return _then(_SearchState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SearchStatus,searchResults: null == searchResults ? _self._searchResults : searchResults // ignore: cast_nullable_to_non_nullable
as List<Product>,
  ));
}

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchStatusCopyWith<$Res> get status {
  
  return $SearchStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

// dart format on
