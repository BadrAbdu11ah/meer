/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:meer_server/src/generated/protocol.dart' as _i58zzwu7;
import 'package:serverpod/serverpod.dart' as _is;
import '../model/order_item.dart' as _ixwt4bxc;
import '../model/user.dart' as _ii4paws6;

abstract class OrderInfo
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  OrderInfo._({
    this.id,
    required this.customerId,
    this.customer,
    required this.sellerId,
    this.seller,
    this.driverId,
    required this.status,
    required this.totalAmount,
    required this.deliveryAddress,
    this.deliveryLatitude,
    this.deliveryLongitude,
    required this.createdAt,
    this.items,
  });

  factory OrderInfo({
    int? id,
    required int customerId,
    _ii4paws6.User? customer,
    required int sellerId,
    _ii4paws6.User? seller,
    int? driverId,
    required String status,
    required double totalAmount,
    required String deliveryAddress,
    double? deliveryLatitude,
    double? deliveryLongitude,
    required DateTime createdAt,
    List<_ixwt4bxc.OrderItem>? items,
  }) = _OrderInfoImpl;

  factory OrderInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderInfo(
      id: jsonSerialization['id'] as int?,
      customerId: jsonSerialization['customerId'] as int,
      customer: jsonSerialization['customer'] == null
          ? null
          : _i58zzwu7.Protocol().deserialize<_ii4paws6.User>(
              jsonSerialization['customer'],
            ),
      sellerId: jsonSerialization['sellerId'] as int,
      seller: jsonSerialization['seller'] == null
          ? null
          : _i58zzwu7.Protocol().deserialize<_ii4paws6.User>(
              jsonSerialization['seller'],
            ),
      driverId: jsonSerialization['driverId'] as int?,
      status: jsonSerialization['status'] as String,
      totalAmount: (jsonSerialization['totalAmount'] as num).toDouble(),
      deliveryAddress: jsonSerialization['deliveryAddress'] as String,
      deliveryLatitude: (jsonSerialization['deliveryLatitude'] as num?)
          ?.toDouble(),
      deliveryLongitude: (jsonSerialization['deliveryLongitude'] as num?)
          ?.toDouble(),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      items: jsonSerialization['items'] == null
          ? null
          : _i58zzwu7.Protocol().deserialize<List<_ixwt4bxc.OrderItem>>(
              jsonSerialization['items'],
            ),
    );
  }

  static final t = OrderInfoTable();

  static const db = OrderInfoRepository._();

  @override
  int? id;

  int customerId;

  _ii4paws6.User? customer;

  int sellerId;

  _ii4paws6.User? seller;

  int? driverId;

  String status;

  double totalAmount;

  String deliveryAddress;

  double? deliveryLatitude;

  double? deliveryLongitude;

  DateTime createdAt;

  List<_ixwt4bxc.OrderItem>? items;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [OrderInfo]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OrderInfo copyWith({
    int? id,
    int? customerId,
    _ii4paws6.User? customer,
    int? sellerId,
    _ii4paws6.User? seller,
    int? driverId,
    String? status,
    double? totalAmount,
    String? deliveryAddress,
    double? deliveryLatitude,
    double? deliveryLongitude,
    DateTime? createdAt,
    List<_ixwt4bxc.OrderItem>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderInfo',
      if (id != null) 'id': id,
      'customerId': customerId,
      if (customer != null) 'customer': customer?.toJson(),
      'sellerId': sellerId,
      if (seller != null) 'seller': seller?.toJson(),
      if (driverId != null) 'driverId': driverId,
      'status': status,
      'totalAmount': totalAmount,
      'deliveryAddress': deliveryAddress,
      if (deliveryLatitude != null) 'deliveryLatitude': deliveryLatitude,
      if (deliveryLongitude != null) 'deliveryLongitude': deliveryLongitude,
      'createdAt': createdAt.toJson(),
      if (items != null) 'items': items?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderInfo',
      if (id != null) 'id': id,
      'customerId': customerId,
      if (customer != null) 'customer': customer?.toJsonForProtocol(),
      'sellerId': sellerId,
      if (seller != null) 'seller': seller?.toJsonForProtocol(),
      if (driverId != null) 'driverId': driverId,
      'status': status,
      'totalAmount': totalAmount,
      'deliveryAddress': deliveryAddress,
      if (deliveryLatitude != null) 'deliveryLatitude': deliveryLatitude,
      if (deliveryLongitude != null) 'deliveryLongitude': deliveryLongitude,
      'createdAt': createdAt.toJson(),
      if (items != null)
        'items': items?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static OrderInfoInclude include({
    _ii4paws6.UserInclude? customer,
    _ii4paws6.UserInclude? seller,
    _ixwt4bxc.OrderItemIncludeList? items,
  }) {
    return OrderInfoInclude._(
      customer: customer,
      seller: seller,
      items: items,
    );
  }

  static OrderInfoIncludeList includeList({
    _is.WhereExpressionBuilder<OrderInfoTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OrderInfoTable>? orderBy,
    _is.OrderByListBuilder<OrderInfoTable>? orderByList,
    OrderInfoInclude? include,
  }) {
    return OrderInfoIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrderInfo.t),
      orderByList: orderByList?.call(OrderInfo.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderInfoImpl extends OrderInfo {
  _OrderInfoImpl({
    int? id,
    required int customerId,
    _ii4paws6.User? customer,
    required int sellerId,
    _ii4paws6.User? seller,
    int? driverId,
    required String status,
    required double totalAmount,
    required String deliveryAddress,
    double? deliveryLatitude,
    double? deliveryLongitude,
    required DateTime createdAt,
    List<_ixwt4bxc.OrderItem>? items,
  }) : super._(
         id: id,
         customerId: customerId,
         customer: customer,
         sellerId: sellerId,
         seller: seller,
         driverId: driverId,
         status: status,
         totalAmount: totalAmount,
         deliveryAddress: deliveryAddress,
         deliveryLatitude: deliveryLatitude,
         deliveryLongitude: deliveryLongitude,
         createdAt: createdAt,
         items: items,
       );

  /// Returns a shallow copy of this [OrderInfo]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OrderInfo copyWith({
    Object? id = _Undefined,
    int? customerId,
    Object? customer = _Undefined,
    int? sellerId,
    Object? seller = _Undefined,
    Object? driverId = _Undefined,
    String? status,
    double? totalAmount,
    String? deliveryAddress,
    Object? deliveryLatitude = _Undefined,
    Object? deliveryLongitude = _Undefined,
    DateTime? createdAt,
    Object? items = _Undefined,
  }) {
    return OrderInfo(
      id: id is int? ? id : this.id,
      customerId: customerId ?? this.customerId,
      customer: customer is _ii4paws6.User?
          ? customer
          : this.customer?.copyWith(),
      sellerId: sellerId ?? this.sellerId,
      seller: seller is _ii4paws6.User? ? seller : this.seller?.copyWith(),
      driverId: driverId is int? ? driverId : this.driverId,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryLatitude: deliveryLatitude is double?
          ? deliveryLatitude
          : this.deliveryLatitude,
      deliveryLongitude: deliveryLongitude is double?
          ? deliveryLongitude
          : this.deliveryLongitude,
      createdAt: createdAt ?? this.createdAt,
      items: items is List<_ixwt4bxc.OrderItem>?
          ? items
          : this.items?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class OrderInfoUpdateTable extends _is.UpdateTable<OrderInfoTable> {
  OrderInfoUpdateTable(super.table);

  _is.ColumnValue<int, int> customerId(int value) => _is.ColumnValue(
    table.customerId,
    value,
  );

  _is.ColumnValue<int, int> sellerId(int value) => _is.ColumnValue(
    table.sellerId,
    value,
  );

  _is.ColumnValue<int, int> driverId(int? value) => _is.ColumnValue(
    table.driverId,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<double, double> totalAmount(double value) => _is.ColumnValue(
    table.totalAmount,
    value,
  );

  _is.ColumnValue<String, String> deliveryAddress(String value) =>
      _is.ColumnValue(
        table.deliveryAddress,
        value,
      );

  _is.ColumnValue<double, double> deliveryLatitude(double? value) =>
      _is.ColumnValue(
        table.deliveryLatitude,
        value,
      );

  _is.ColumnValue<double, double> deliveryLongitude(double? value) =>
      _is.ColumnValue(
        table.deliveryLongitude,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class OrderInfoTable extends _is.Table<int?> {
  OrderInfoTable({super.tableRelation}) : super(tableName: 'order_info') {
    updateTable = OrderInfoUpdateTable(this);
    customerId = _is.ColumnInt(
      'customerId',
      this,
    );
    sellerId = _is.ColumnInt(
      'sellerId',
      this,
    );
    driverId = _is.ColumnInt(
      'driverId',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    totalAmount = _is.ColumnDouble(
      'totalAmount',
      this,
    );
    deliveryAddress = _is.ColumnString(
      'deliveryAddress',
      this,
    );
    deliveryLatitude = _is.ColumnDouble(
      'deliveryLatitude',
      this,
    );
    deliveryLongitude = _is.ColumnDouble(
      'deliveryLongitude',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final OrderInfoUpdateTable updateTable;

  late final _is.ColumnInt customerId;

  _ii4paws6.UserTable? _customer;

  late final _is.ColumnInt sellerId;

  _ii4paws6.UserTable? _seller;

  late final _is.ColumnInt driverId;

  late final _is.ColumnString status;

  late final _is.ColumnDouble totalAmount;

  late final _is.ColumnString deliveryAddress;

  late final _is.ColumnDouble deliveryLatitude;

  late final _is.ColumnDouble deliveryLongitude;

  late final _is.ColumnDateTime createdAt;

  _ixwt4bxc.OrderItemTable? ___items;

  _is.ManyRelation<_ixwt4bxc.OrderItemTable>? _items;

  _ii4paws6.UserTable get customer {
    if (_customer != null) return _customer!;
    _customer = _is.createRelationTable(
      relationFieldName: 'customer',
      field: OrderInfo.t.customerId,
      foreignField: _ii4paws6.User.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ii4paws6.UserTable(tableRelation: foreignTableRelation),
    );
    return _customer!;
  }

  _ii4paws6.UserTable get seller {
    if (_seller != null) return _seller!;
    _seller = _is.createRelationTable(
      relationFieldName: 'seller',
      field: OrderInfo.t.sellerId,
      foreignField: _ii4paws6.User.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ii4paws6.UserTable(tableRelation: foreignTableRelation),
    );
    return _seller!;
  }

  _ixwt4bxc.OrderItemTable get __items {
    if (___items != null) return ___items!;
    ___items = _is.createRelationTable(
      relationFieldName: '__items',
      field: OrderInfo.t.id,
      foreignField: _ixwt4bxc.OrderItem.t.orderId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ixwt4bxc.OrderItemTable(tableRelation: foreignTableRelation),
    );
    return ___items!;
  }

  _is.ManyRelation<_ixwt4bxc.OrderItemTable> get items {
    if (_items != null) return _items!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'items',
      field: OrderInfo.t.id,
      foreignField: _ixwt4bxc.OrderItem.t.orderId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ixwt4bxc.OrderItemTable(tableRelation: foreignTableRelation),
    );
    _items = _is.ManyRelation<_ixwt4bxc.OrderItemTable>(
      tableWithRelations: relationTable,
      table: _ixwt4bxc.OrderItemTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _items!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    customerId,
    sellerId,
    driverId,
    status,
    totalAmount,
    deliveryAddress,
    deliveryLatitude,
    deliveryLongitude,
    createdAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'customer') {
      return customer;
    }
    if (relationField == 'seller') {
      return seller;
    }
    if (relationField == 'items') {
      return __items;
    }
    return null;
  }
}

class OrderInfoInclude extends _is.IncludeObject {
  OrderInfoInclude._({
    _ii4paws6.UserInclude? customer,
    _ii4paws6.UserInclude? seller,
    _ixwt4bxc.OrderItemIncludeList? items,
  }) {
    _customer = customer;
    _seller = seller;
    _items = items;
  }

  _ii4paws6.UserInclude? _customer;

  _ii4paws6.UserInclude? _seller;

  _ixwt4bxc.OrderItemIncludeList? _items;

  @override
  Map<String, _is.Include?> get includes => {
    'customer': _customer,
    'seller': _seller,
    'items': _items,
  };

  @override
  _is.Table<int?> get table => OrderInfo.t;
}

class OrderInfoIncludeList extends _is.IncludeList {
  OrderInfoIncludeList._({
    _is.WhereExpressionBuilder<OrderInfoTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OrderInfo.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => OrderInfo.t;
}

class OrderInfoRepository {
  const OrderInfoRepository._();

  final attach = const OrderInfoAttachRepository._();

  final attachRow = const OrderInfoAttachRowRepository._();

  /// Returns a list of [OrderInfo]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<OrderInfo>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OrderInfoTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OrderInfoTable>? orderBy,
    _is.OrderByListBuilder<OrderInfoTable>? orderByList,
    _is.Transaction? transaction,
    OrderInfoInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OrderInfo>(
      where: where?.call(OrderInfo.t),
      orderBy: orderBy?.call(OrderInfo.t),
      orderByList: orderByList?.call(OrderInfo.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OrderInfo] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<OrderInfo?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OrderInfoTable>? where,
    int? offset,
    _is.OrderByBuilder<OrderInfoTable>? orderBy,
    _is.OrderByListBuilder<OrderInfoTable>? orderByList,
    _is.Transaction? transaction,
    OrderInfoInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OrderInfo>(
      where: where?.call(OrderInfo.t),
      orderBy: orderBy?.call(OrderInfo.t),
      orderByList: orderByList?.call(OrderInfo.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OrderInfo] by its [id] or null if no such row exists.
  Future<OrderInfo?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    OrderInfoInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OrderInfo>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OrderInfo]s in the list and returns the inserted rows.
  ///
  /// The returned [OrderInfo]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OrderInfo>> insert(
    _is.DatabaseSession session,
    List<OrderInfo> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<OrderInfo>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [OrderInfo] and returns the inserted row.
  ///
  /// The returned [OrderInfo] will have its `id` field set.
  Future<OrderInfo> insertRow(
    _is.DatabaseSession session,
    OrderInfo row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<OrderInfo>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [OrderInfo]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [OrderInfo]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OrderInfo>> upsert(
    _is.DatabaseSession session,
    List<OrderInfo> rows, {
    required _is.ColumnSelections<OrderInfoTable> conflictColumns,
    _is.ColumnSelections<OrderInfoTable>? updateColumns,
    _is.WhereExpressionBuilder<OrderInfoTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<OrderInfo>(
      rows,
      conflictColumns: conflictColumns(OrderInfo.t),
      updateColumns: updateColumns?.call(OrderInfo.t),
      updateWhere: updateWhere?.call(OrderInfo.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [OrderInfo] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [OrderInfo] will have its `id` field set.
  Future<OrderInfo?> upsertRow(
    _is.DatabaseSession session,
    OrderInfo row, {
    required _is.ColumnSelections<OrderInfoTable> conflictColumns,
    _is.ColumnSelections<OrderInfoTable>? updateColumns,
    _is.WhereExpressionBuilder<OrderInfoTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<OrderInfo>(
      row,
      conflictColumns: conflictColumns(OrderInfo.t),
      updateColumns: updateColumns?.call(OrderInfo.t),
      updateWhere: updateWhere?.call(OrderInfo.t),
      transaction: transaction,
    );
  }

  /// Updates all [OrderInfo]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OrderInfo>> update(
    _is.DatabaseSession session,
    List<OrderInfo> rows, {
    _is.ColumnSelections<OrderInfoTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<OrderInfo>(
      rows,
      columns: columns?.call(OrderInfo.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [OrderInfo]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OrderInfo> updateRow(
    _is.DatabaseSession session,
    OrderInfo row, {
    _is.ColumnSelections<OrderInfoTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<OrderInfo>(
      row,
      columns: columns?.call(OrderInfo.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrderInfo] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OrderInfo?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<OrderInfoUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<OrderInfo>(
      id,
      columnValues: columnValues(OrderInfo.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OrderInfo]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OrderInfo>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<OrderInfoUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<OrderInfoTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OrderInfoTable>? orderBy,
    _is.OrderByListBuilder<OrderInfoTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<OrderInfo>(
      columnValues: columnValues(OrderInfo.t.updateTable),
      where: where(OrderInfo.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrderInfo.t),
      orderByList: orderByList?.call(OrderInfo.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [OrderInfo]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OrderInfo>> delete(
    _is.DatabaseSession session,
    List<OrderInfo> rows, {
    _is.OrderByBuilder<OrderInfoTable>? orderBy,
    _is.OrderByListBuilder<OrderInfoTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<OrderInfo>(
      rows,
      orderBy: orderBy?.call(OrderInfo.t),
      orderByList: orderByList?.call(OrderInfo.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [OrderInfo].
  Future<OrderInfo> deleteRow(
    _is.DatabaseSession session,
    OrderInfo row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OrderInfo>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OrderInfo>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OrderInfoTable> where,
    _is.OrderByBuilder<OrderInfoTable>? orderBy,
    _is.OrderByListBuilder<OrderInfoTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<OrderInfo>(
      where: where(OrderInfo.t),
      orderBy: orderBy?.call(OrderInfo.t),
      orderByList: orderByList?.call(OrderInfo.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OrderInfoTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<OrderInfo>(
      where: where?.call(OrderInfo.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OrderInfo] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OrderInfoTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OrderInfo>(
      where: where(OrderInfo.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class OrderInfoAttachRepository {
  const OrderInfoAttachRepository._();

  /// Creates a relation between this [OrderInfo] and the given [OrderItem]s
  /// by setting each [OrderItem]'s foreign key `orderId` to refer to this [OrderInfo].
  Future<void> items(
    _is.DatabaseSession session,
    OrderInfo orderInfo,
    List<_ixwt4bxc.OrderItem> orderItem, {
    _is.Transaction? transaction,
  }) async {
    if (orderItem.any((e) => e.id == null)) {
      throw ArgumentError.notNull('orderItem.id');
    }
    if (orderInfo.id == null) {
      throw ArgumentError.notNull('orderInfo.id');
    }

    var $orderItem = orderItem
        .map((e) => e.copyWith(orderId: orderInfo.id))
        .toList();
    await session.db.update<_ixwt4bxc.OrderItem>(
      $orderItem,
      columns: [_ixwt4bxc.OrderItem.t.orderId],
      transaction: transaction,
    );
  }
}

class OrderInfoAttachRowRepository {
  const OrderInfoAttachRowRepository._();

  /// Creates a relation between the given [OrderInfo] and [User]
  /// by setting the [OrderInfo]'s foreign key `customerId` to refer to the [User].
  Future<void> customer(
    _is.DatabaseSession session,
    OrderInfo orderInfo,
    _ii4paws6.User customer, {
    _is.Transaction? transaction,
  }) async {
    if (orderInfo.id == null) {
      throw ArgumentError.notNull('orderInfo.id');
    }
    if (customer.id == null) {
      throw ArgumentError.notNull('customer.id');
    }

    var $orderInfo = orderInfo.copyWith(customerId: customer.id);
    await session.db.updateRow<OrderInfo>(
      $orderInfo,
      columns: [OrderInfo.t.customerId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [OrderInfo] and [User]
  /// by setting the [OrderInfo]'s foreign key `sellerId` to refer to the [User].
  Future<void> seller(
    _is.DatabaseSession session,
    OrderInfo orderInfo,
    _ii4paws6.User seller, {
    _is.Transaction? transaction,
  }) async {
    if (orderInfo.id == null) {
      throw ArgumentError.notNull('orderInfo.id');
    }
    if (seller.id == null) {
      throw ArgumentError.notNull('seller.id');
    }

    var $orderInfo = orderInfo.copyWith(sellerId: seller.id);
    await session.db.updateRow<OrderInfo>(
      $orderInfo,
      columns: [OrderInfo.t.sellerId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [OrderInfo] and the given [OrderItem]
  /// by setting the [OrderItem]'s foreign key `orderId` to refer to this [OrderInfo].
  Future<void> items(
    _is.DatabaseSession session,
    OrderInfo orderInfo,
    _ixwt4bxc.OrderItem orderItem, {
    _is.Transaction? transaction,
  }) async {
    if (orderItem.id == null) {
      throw ArgumentError.notNull('orderItem.id');
    }
    if (orderInfo.id == null) {
      throw ArgumentError.notNull('orderInfo.id');
    }

    var $orderItem = orderItem.copyWith(orderId: orderInfo.id);
    await session.db.updateRow<_ixwt4bxc.OrderItem>(
      $orderItem,
      columns: [_ixwt4bxc.OrderItem.t.orderId],
      transaction: transaction,
    );
  }
}
