/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:meer_server/src/generated/protocol.dart' as _i58zzwu7;
import 'package:serverpod/serverpod.dart' as _is;
import '../model/order_info.dart' as _iju22qew;

abstract class OrderPresentation
    implements _is.SerializableModel, _is.ProtocolSerialization {
  OrderPresentation._({
    required this.order,
    required this.counterpartyName,
    required this.isSellerView,
  });

  factory OrderPresentation({
    required _iju22qew.OrderInfo order,
    required String counterpartyName,
    required bool isSellerView,
  }) = _OrderPresentationImpl;

  factory OrderPresentation.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderPresentation(
      order: _i58zzwu7.Protocol().deserialize<_iju22qew.OrderInfo>(
        jsonSerialization['order'],
      ),
      counterpartyName: jsonSerialization['counterpartyName'] as String,
      isSellerView: _is.BoolJsonExtension.fromJson(
        jsonSerialization['isSellerView'],
      ),
    );
  }

  _iju22qew.OrderInfo order;

  String counterpartyName;

  bool isSellerView;

  /// Returns a shallow copy of this [OrderPresentation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OrderPresentation copyWith({
    _iju22qew.OrderInfo? order,
    String? counterpartyName,
    bool? isSellerView,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderPresentation',
      'order': order.toJson(),
      'counterpartyName': counterpartyName,
      'isSellerView': isSellerView,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderPresentation',
      'order': order.toJsonForProtocol(),
      'counterpartyName': counterpartyName,
      'isSellerView': isSellerView,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _OrderPresentationImpl extends OrderPresentation {
  _OrderPresentationImpl({
    required _iju22qew.OrderInfo order,
    required String counterpartyName,
    required bool isSellerView,
  }) : super._(
         order: order,
         counterpartyName: counterpartyName,
         isSellerView: isSellerView,
       );

  /// Returns a shallow copy of this [OrderPresentation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OrderPresentation copyWith({
    _iju22qew.OrderInfo? order,
    String? counterpartyName,
    bool? isSellerView,
  }) {
    return OrderPresentation(
      order: order ?? this.order.copyWith(),
      counterpartyName: counterpartyName ?? this.counterpartyName,
      isSellerView: isSellerView ?? this.isSellerView,
    );
  }
}
