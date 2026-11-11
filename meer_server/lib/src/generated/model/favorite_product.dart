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
import '../model/product.dart' as _im4wswb6;

abstract class FavoriteProduct
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  FavoriteProduct._({
    this.id,
    required this.userId,
    required this.productId,
    this.product,
    required this.createdAt,
  });

  factory FavoriteProduct({
    int? id,
    required int userId,
    required int productId,
    _im4wswb6.Product? product,
    required DateTime createdAt,
  }) = _FavoriteProductImpl;

  factory FavoriteProduct.fromJson(Map<String, dynamic> jsonSerialization) {
    return FavoriteProduct(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      productId: jsonSerialization['productId'] as int,
      product: jsonSerialization['product'] == null
          ? null
          : _i58zzwu7.Protocol().deserialize<_im4wswb6.Product>(
              jsonSerialization['product'],
            ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = FavoriteProductTable();

  static const db = FavoriteProductRepository._();

  @override
  int? id;

  int userId;

  int productId;

  _im4wswb6.Product? product;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FavoriteProduct]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FavoriteProduct copyWith({
    int? id,
    int? userId,
    int? productId,
    _im4wswb6.Product? product,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FavoriteProduct',
      if (id != null) 'id': id,
      'userId': userId,
      'productId': productId,
      if (product != null) 'product': product?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FavoriteProduct',
      if (id != null) 'id': id,
      'userId': userId,
      'productId': productId,
      if (product != null) 'product': product?.toJsonForProtocol(),
      'createdAt': createdAt.toJson(),
    };
  }

  static FavoriteProductInclude include({_im4wswb6.ProductInclude? product}) {
    return FavoriteProductInclude._(product: product);
  }

  static FavoriteProductIncludeList includeList({
    _is.WhereExpressionBuilder<FavoriteProductTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FavoriteProductTable>? orderBy,
    _is.OrderByListBuilder<FavoriteProductTable>? orderByList,
    FavoriteProductInclude? include,
  }) {
    return FavoriteProductIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FavoriteProduct.t),
      orderByList: orderByList?.call(FavoriteProduct.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FavoriteProductImpl extends FavoriteProduct {
  _FavoriteProductImpl({
    int? id,
    required int userId,
    required int productId,
    _im4wswb6.Product? product,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         productId: productId,
         product: product,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [FavoriteProduct]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FavoriteProduct copyWith({
    Object? id = _Undefined,
    int? userId,
    int? productId,
    Object? product = _Undefined,
    DateTime? createdAt,
  }) {
    return FavoriteProduct(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      product: product is _im4wswb6.Product?
          ? product
          : this.product?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class FavoriteProductUpdateTable extends _is.UpdateTable<FavoriteProductTable> {
  FavoriteProductUpdateTable(super.table);

  _is.ColumnValue<int, int> userId(int value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<int, int> productId(int value) => _is.ColumnValue(
    table.productId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class FavoriteProductTable extends _is.Table<int?> {
  FavoriteProductTable({super.tableRelation})
    : super(tableName: 'favorite_product') {
    updateTable = FavoriteProductUpdateTable(this);
    userId = _is.ColumnInt(
      'userId',
      this,
    );
    productId = _is.ColumnInt(
      'productId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final FavoriteProductUpdateTable updateTable;

  late final _is.ColumnInt userId;

  late final _is.ColumnInt productId;

  _im4wswb6.ProductTable? _product;

  late final _is.ColumnDateTime createdAt;

  _im4wswb6.ProductTable get product {
    if (_product != null) return _product!;
    _product = _is.createRelationTable(
      relationFieldName: 'product',
      field: FavoriteProduct.t.productId,
      foreignField: _im4wswb6.Product.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _im4wswb6.ProductTable(tableRelation: foreignTableRelation),
    );
    return _product!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    productId,
    createdAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'product') {
      return product;
    }
    return null;
  }
}

class FavoriteProductInclude extends _is.IncludeObject {
  FavoriteProductInclude._({_im4wswb6.ProductInclude? product}) {
    _product = product;
  }

  _im4wswb6.ProductInclude? _product;

  @override
  Map<String, _is.Include?> get includes => {'product': _product};

  @override
  _is.Table<int?> get table => FavoriteProduct.t;
}

class FavoriteProductIncludeList extends _is.IncludeList {
  FavoriteProductIncludeList._({
    _is.WhereExpressionBuilder<FavoriteProductTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FavoriteProduct.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FavoriteProduct.t;
}

class FavoriteProductRepository {
  const FavoriteProductRepository._();

  final attachRow = const FavoriteProductAttachRowRepository._();

  /// Returns a list of [FavoriteProduct]s matching the given query parameters.
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
  Future<List<FavoriteProduct>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FavoriteProductTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FavoriteProductTable>? orderBy,
    _is.OrderByListBuilder<FavoriteProductTable>? orderByList,
    _is.Transaction? transaction,
    FavoriteProductInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FavoriteProduct>(
      where: where?.call(FavoriteProduct.t),
      orderBy: orderBy?.call(FavoriteProduct.t),
      orderByList: orderByList?.call(FavoriteProduct.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FavoriteProduct] matching the given query parameters.
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
  Future<FavoriteProduct?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FavoriteProductTable>? where,
    int? offset,
    _is.OrderByBuilder<FavoriteProductTable>? orderBy,
    _is.OrderByListBuilder<FavoriteProductTable>? orderByList,
    _is.Transaction? transaction,
    FavoriteProductInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FavoriteProduct>(
      where: where?.call(FavoriteProduct.t),
      orderBy: orderBy?.call(FavoriteProduct.t),
      orderByList: orderByList?.call(FavoriteProduct.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FavoriteProduct] by its [id] or null if no such row exists.
  Future<FavoriteProduct?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    FavoriteProductInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FavoriteProduct>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FavoriteProduct]s in the list and returns the inserted rows.
  ///
  /// The returned [FavoriteProduct]s will have their `id` fields set.
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
  Future<List<FavoriteProduct>> insert(
    _is.DatabaseSession session,
    List<FavoriteProduct> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FavoriteProduct>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FavoriteProduct] and returns the inserted row.
  ///
  /// The returned [FavoriteProduct] will have its `id` field set.
  Future<FavoriteProduct> insertRow(
    _is.DatabaseSession session,
    FavoriteProduct row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FavoriteProduct>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FavoriteProduct]s in the list and returns the resulting rows.
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
  /// The returned [FavoriteProduct]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FavoriteProduct>> upsert(
    _is.DatabaseSession session,
    List<FavoriteProduct> rows, {
    required _is.ColumnSelections<FavoriteProductTable> conflictColumns,
    _is.ColumnSelections<FavoriteProductTable>? updateColumns,
    _is.WhereExpressionBuilder<FavoriteProductTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FavoriteProduct>(
      rows,
      conflictColumns: conflictColumns(FavoriteProduct.t),
      updateColumns: updateColumns?.call(FavoriteProduct.t),
      updateWhere: updateWhere?.call(FavoriteProduct.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FavoriteProduct] and returns the resulting row.
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
  /// The returned [FavoriteProduct] will have its `id` field set.
  Future<FavoriteProduct?> upsertRow(
    _is.DatabaseSession session,
    FavoriteProduct row, {
    required _is.ColumnSelections<FavoriteProductTable> conflictColumns,
    _is.ColumnSelections<FavoriteProductTable>? updateColumns,
    _is.WhereExpressionBuilder<FavoriteProductTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FavoriteProduct>(
      row,
      conflictColumns: conflictColumns(FavoriteProduct.t),
      updateColumns: updateColumns?.call(FavoriteProduct.t),
      updateWhere: updateWhere?.call(FavoriteProduct.t),
      transaction: transaction,
    );
  }

  /// Updates all [FavoriteProduct]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FavoriteProduct>> update(
    _is.DatabaseSession session,
    List<FavoriteProduct> rows, {
    _is.ColumnSelections<FavoriteProductTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FavoriteProduct>(
      rows,
      columns: columns?.call(FavoriteProduct.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FavoriteProduct]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FavoriteProduct> updateRow(
    _is.DatabaseSession session,
    FavoriteProduct row, {
    _is.ColumnSelections<FavoriteProductTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FavoriteProduct>(
      row,
      columns: columns?.call(FavoriteProduct.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FavoriteProduct] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FavoriteProduct?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FavoriteProductUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FavoriteProduct>(
      id,
      columnValues: columnValues(FavoriteProduct.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FavoriteProduct]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FavoriteProduct>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FavoriteProductUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<FavoriteProductTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FavoriteProductTable>? orderBy,
    _is.OrderByListBuilder<FavoriteProductTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FavoriteProduct>(
      columnValues: columnValues(FavoriteProduct.t.updateTable),
      where: where(FavoriteProduct.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FavoriteProduct.t),
      orderByList: orderByList?.call(FavoriteProduct.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FavoriteProduct]s in the list and returns the deleted rows.
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
  Future<List<FavoriteProduct>> delete(
    _is.DatabaseSession session,
    List<FavoriteProduct> rows, {
    _is.OrderByBuilder<FavoriteProductTable>? orderBy,
    _is.OrderByListBuilder<FavoriteProductTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FavoriteProduct>(
      rows,
      orderBy: orderBy?.call(FavoriteProduct.t),
      orderByList: orderByList?.call(FavoriteProduct.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FavoriteProduct].
  Future<FavoriteProduct> deleteRow(
    _is.DatabaseSession session,
    FavoriteProduct row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FavoriteProduct>(
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
  Future<List<FavoriteProduct>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FavoriteProductTable> where,
    _is.OrderByBuilder<FavoriteProductTable>? orderBy,
    _is.OrderByListBuilder<FavoriteProductTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FavoriteProduct>(
      where: where(FavoriteProduct.t),
      orderBy: orderBy?.call(FavoriteProduct.t),
      orderByList: orderByList?.call(FavoriteProduct.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FavoriteProductTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FavoriteProduct>(
      where: where?.call(FavoriteProduct.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FavoriteProduct] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FavoriteProductTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FavoriteProduct>(
      where: where(FavoriteProduct.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class FavoriteProductAttachRowRepository {
  const FavoriteProductAttachRowRepository._();

  /// Creates a relation between the given [FavoriteProduct] and [Product]
  /// by setting the [FavoriteProduct]'s foreign key `productId` to refer to the [Product].
  Future<void> product(
    _is.DatabaseSession session,
    FavoriteProduct favoriteProduct,
    _im4wswb6.Product product, {
    _is.Transaction? transaction,
  }) async {
    if (favoriteProduct.id == null) {
      throw ArgumentError.notNull('favoriteProduct.id');
    }
    if (product.id == null) {
      throw ArgumentError.notNull('product.id');
    }

    var $favoriteProduct = favoriteProduct.copyWith(productId: product.id);
    await session.db.updateRow<FavoriteProduct>(
      $favoriteProduct,
      columns: [FavoriteProduct.t.productId],
      transaction: transaction,
    );
  }
}
