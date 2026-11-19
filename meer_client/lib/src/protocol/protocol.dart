/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:meer_client/src/protocol/model/cart_item_presentation.dart'
    as _illo3ltv;
import 'package:meer_client/src/protocol/model/order_item_request.dart'
    as _ix7syfm6;
import 'package:meer_client/src/protocol/model/order_presentation.dart'
    as _izvi99z2;
import 'package:meer_client/src/protocol/model/product.dart' as _i90cwas4;
import 'package:meer_client/src/protocol/model/product_presentation.dart'
    as _ietsoqkp;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i312scxx;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'model/cart_item_presentation.dart' as _iodaj5xe;
import 'model/cart_item_record.dart' as _ivirwujx;
import 'model/favorite_product.dart' as _i8l2y79r;
import 'model/image_upload_description.dart' as _ir1pddjn;
import 'model/meer_city.dart' as _idc5ggrx;
import 'model/meer_exception.dart' as _ixmkl8ss;
import 'model/MeerUserProfile.dart' as _ii0ycxhg;
import 'model/order_info.dart' as _ig93noqx;
import 'model/order_item.dart' as _iae72vfi;
import 'model/order_item_request.dart' as _i52izl0k;
import 'model/order_presentation.dart' as _ipeun42e;
import 'model/phone_auth_result.dart' as _iu539ble;
import 'model/product.dart' as _igfqb4xa;
import 'model/product_presentation.dart' as _i1kvhqyp;
import 'model/seller_public_info.dart' as _iigi60b2;
import 'model/user_device_installation.dart' as _iavwcg9k;
export 'greetings/greeting.dart';
export 'model/MeerUserProfile.dart';
export 'model/cart_item_presentation.dart';
export 'model/cart_item_record.dart';
export 'model/favorite_product.dart';
export 'model/image_upload_description.dart';
export 'model/meer_city.dart';
export 'model/meer_exception.dart';
export 'model/order_info.dart';
export 'model/order_item.dart';
export 'model/order_item_request.dart';
export 'model/order_presentation.dart';
export 'model/phone_auth_result.dart';
export 'model/product.dart';
export 'model/product_presentation.dart';
export 'model/seller_public_info.dart';
export 'model/user_device_installation.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _ii0ycxhg.MeerUserProfile) {
      return _ii0ycxhg.MeerUserProfile.fromJson(data) as T;
    }
    if (t == _iodaj5xe.CartItemPresentation) {
      return _iodaj5xe.CartItemPresentation.fromJson(data) as T;
    }
    if (t == _ivirwujx.CartItemRecord) {
      return _ivirwujx.CartItemRecord.fromJson(data) as T;
    }
    if (t == _i8l2y79r.FavoriteProduct) {
      return _i8l2y79r.FavoriteProduct.fromJson(data) as T;
    }
    if (t == _ir1pddjn.ImageUploadDescription) {
      return _ir1pddjn.ImageUploadDescription.fromJson(data) as T;
    }
    if (t == _idc5ggrx.MeerCity) {
      return _idc5ggrx.MeerCity.fromJson(data) as T;
    }
    if (t == _ixmkl8ss.MeerException) {
      return _ixmkl8ss.MeerException.fromJson(data) as T;
    }
    if (t == _ig93noqx.OrderInfo) {
      return _ig93noqx.OrderInfo.fromJson(data) as T;
    }
    if (t == _iae72vfi.OrderItem) {
      return _iae72vfi.OrderItem.fromJson(data) as T;
    }
    if (t == _i52izl0k.OrderItemRequest) {
      return _i52izl0k.OrderItemRequest.fromJson(data) as T;
    }
    if (t == _ipeun42e.OrderPresentation) {
      return _ipeun42e.OrderPresentation.fromJson(data) as T;
    }
    if (t == _iu539ble.PhoneAuthResult) {
      return _iu539ble.PhoneAuthResult.fromJson(data) as T;
    }
    if (t == _igfqb4xa.Product) {
      return _igfqb4xa.Product.fromJson(data) as T;
    }
    if (t == _i1kvhqyp.ProductPresentation) {
      return _i1kvhqyp.ProductPresentation.fromJson(data) as T;
    }
    if (t == _iigi60b2.SellerPublicInfo) {
      return _iigi60b2.SellerPublicInfo.fromJson(data) as T;
    }
    if (t == _iavwcg9k.UserDeviceInstallation) {
      return _iavwcg9k.UserDeviceInstallation.fromJson(data) as T;
    }
    if (t == _isc.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ii0ycxhg.MeerUserProfile?>()) {
      return (data != null ? _ii0ycxhg.MeerUserProfile.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iodaj5xe.CartItemPresentation?>()) {
      return (data != null
              ? _iodaj5xe.CartItemPresentation.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ivirwujx.CartItemRecord?>()) {
      return (data != null ? _ivirwujx.CartItemRecord.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i8l2y79r.FavoriteProduct?>()) {
      return (data != null ? _i8l2y79r.FavoriteProduct.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ir1pddjn.ImageUploadDescription?>()) {
      return (data != null
              ? _ir1pddjn.ImageUploadDescription.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_idc5ggrx.MeerCity?>()) {
      return (data != null ? _idc5ggrx.MeerCity.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ixmkl8ss.MeerException?>()) {
      return (data != null ? _ixmkl8ss.MeerException.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ig93noqx.OrderInfo?>()) {
      return (data != null ? _ig93noqx.OrderInfo.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iae72vfi.OrderItem?>()) {
      return (data != null ? _iae72vfi.OrderItem.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i52izl0k.OrderItemRequest?>()) {
      return (data != null ? _i52izl0k.OrderItemRequest.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ipeun42e.OrderPresentation?>()) {
      return (data != null ? _ipeun42e.OrderPresentation.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iu539ble.PhoneAuthResult?>()) {
      return (data != null ? _iu539ble.PhoneAuthResult.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_igfqb4xa.Product?>()) {
      return (data != null ? _igfqb4xa.Product.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i1kvhqyp.ProductPresentation?>()) {
      return (data != null
              ? _i1kvhqyp.ProductPresentation.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iigi60b2.SellerPublicInfo?>()) {
      return (data != null ? _iigi60b2.SellerPublicInfo.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iavwcg9k.UserDeviceInstallation?>()) {
      return (data != null
              ? _iavwcg9k.UserDeviceInstallation.fromJson(data)
              : null)
          as T;
    }
    if (t == List<_iae72vfi.OrderItem>) {
      return (data as List)
              .map((e) => deserialize<_iae72vfi.OrderItem>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iae72vfi.OrderItem>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iae72vfi.OrderItem>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_illo3ltv.CartItemPresentation>) {
      return (data as List)
              .map((e) => deserialize<_illo3ltv.CartItemPresentation>(e))
              .toList()
          as T;
    }
    if (t == List<_ietsoqkp.ProductPresentation>) {
      return (data as List)
              .map((e) => deserialize<_ietsoqkp.ProductPresentation>(e))
              .toList()
          as T;
    }
    if (t == List<_ix7syfm6.OrderItemRequest>) {
      return (data as List)
              .map((e) => deserialize<_ix7syfm6.OrderItemRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_izvi99z2.OrderPresentation>) {
      return (data as List)
              .map((e) => deserialize<_izvi99z2.OrderPresentation>(e))
              .toList()
          as T;
    }
    if (t == List<_i90cwas4.Product>) {
      return (data as List)
              .map((e) => deserialize<_i90cwas4.Product>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i312scxx.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _izw8z7ou.Greeting => 'Greeting',
      _ii0ycxhg.MeerUserProfile => 'MeerUserProfile',
      _iodaj5xe.CartItemPresentation => 'CartItemPresentation',
      _ivirwujx.CartItemRecord => 'CartItemRecord',
      _i8l2y79r.FavoriteProduct => 'FavoriteProduct',
      _ir1pddjn.ImageUploadDescription => 'ImageUploadDescription',
      _idc5ggrx.MeerCity => 'MeerCity',
      _ixmkl8ss.MeerException => 'MeerException',
      _ig93noqx.OrderInfo => 'OrderInfo',
      _iae72vfi.OrderItem => 'OrderItem',
      _i52izl0k.OrderItemRequest => 'OrderItemRequest',
      _ipeun42e.OrderPresentation => 'OrderPresentation',
      _iu539ble.PhoneAuthResult => 'PhoneAuthResult',
      _igfqb4xa.Product => 'Product',
      _i1kvhqyp.ProductPresentation => 'ProductPresentation',
      _iigi60b2.SellerPublicInfo => 'SellerPublicInfo',
      _iavwcg9k.UserDeviceInstallation => 'UserDeviceInstallation',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('meer.', '');
    }

    switch (data) {
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _ii0ycxhg.MeerUserProfile():
        return 'MeerUserProfile';
      case _iodaj5xe.CartItemPresentation():
        return 'CartItemPresentation';
      case _ivirwujx.CartItemRecord():
        return 'CartItemRecord';
      case _i8l2y79r.FavoriteProduct():
        return 'FavoriteProduct';
      case _ir1pddjn.ImageUploadDescription():
        return 'ImageUploadDescription';
      case _idc5ggrx.MeerCity():
        return 'MeerCity';
      case _ixmkl8ss.MeerException():
        return 'MeerException';
      case _ig93noqx.OrderInfo():
        return 'OrderInfo';
      case _iae72vfi.OrderItem():
        return 'OrderItem';
      case _i52izl0k.OrderItemRequest():
        return 'OrderItemRequest';
      case _ipeun42e.OrderPresentation():
        return 'OrderPresentation';
      case _iu539ble.PhoneAuthResult():
        return 'PhoneAuthResult';
      case _igfqb4xa.Product():
        return 'Product';
      case _i1kvhqyp.ProductPresentation():
        return 'ProductPresentation';
      case _iigi60b2.SellerPublicInfo():
        return 'SellerPublicInfo';
      case _iavwcg9k.UserDeviceInstallation():
        return 'UserDeviceInstallation';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _i312scxx.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod_auth.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'MeerUserProfile') {
      return deserialize<_ii0ycxhg.MeerUserProfile>(data['data']);
    }
    if (dataClassName == 'CartItemPresentation') {
      return deserialize<_iodaj5xe.CartItemPresentation>(data['data']);
    }
    if (dataClassName == 'CartItemRecord') {
      return deserialize<_ivirwujx.CartItemRecord>(data['data']);
    }
    if (dataClassName == 'FavoriteProduct') {
      return deserialize<_i8l2y79r.FavoriteProduct>(data['data']);
    }
    if (dataClassName == 'ImageUploadDescription') {
      return deserialize<_ir1pddjn.ImageUploadDescription>(data['data']);
    }
    if (dataClassName == 'MeerCity') {
      return deserialize<_idc5ggrx.MeerCity>(data['data']);
    }
    if (dataClassName == 'MeerException') {
      return deserialize<_ixmkl8ss.MeerException>(data['data']);
    }
    if (dataClassName == 'OrderInfo') {
      return deserialize<_ig93noqx.OrderInfo>(data['data']);
    }
    if (dataClassName == 'OrderItem') {
      return deserialize<_iae72vfi.OrderItem>(data['data']);
    }
    if (dataClassName == 'OrderItemRequest') {
      return deserialize<_i52izl0k.OrderItemRequest>(data['data']);
    }
    if (dataClassName == 'OrderPresentation') {
      return deserialize<_ipeun42e.OrderPresentation>(data['data']);
    }
    if (dataClassName == 'PhoneAuthResult') {
      return deserialize<_iu539ble.PhoneAuthResult>(data['data']);
    }
    if (dataClassName == 'Product') {
      return deserialize<_igfqb4xa.Product>(data['data']);
    }
    if (dataClassName == 'ProductPresentation') {
      return deserialize<_i1kvhqyp.ProductPresentation>(data['data']);
    }
    if (dataClassName == 'SellerPublicInfo') {
      return deserialize<_iigi60b2.SellerPublicInfo>(data['data']);
    }
    if (dataClassName == 'UserDeviceInstallation') {
      return deserialize<_iavwcg9k.UserDeviceInstallation>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i312scxx.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('meer', this);
    _i312scxx.Protocol().registerHostProtocol('meer', this);
    _iacc.Protocol().registerHostProtocol('meer', this);
  }

  @override
  String getModuleName() => 'meer';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i312scxx.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
