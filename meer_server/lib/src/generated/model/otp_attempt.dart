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
import 'package:serverpod/serverpod.dart' as _is;

abstract class OtpAttempt
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  OtpAttempt._({
    this.id,
    required this.phoneHash,
    this.ipHash,
    required this.purpose,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory OtpAttempt({
    int? id,
    required String phoneHash,
    String? ipHash,
    required String purpose,
    DateTime? createdAt,
  }) = _OtpAttemptImpl;

  factory OtpAttempt.fromJson(Map<String, dynamic> jsonSerialization) {
    return OtpAttempt(
      id: jsonSerialization['id'] as int?,
      phoneHash: jsonSerialization['phoneHash'] as String,
      ipHash: jsonSerialization['ipHash'] as String?,
      purpose: jsonSerialization['purpose'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = OtpAttemptTable();

  static const db = OtpAttemptRepository._();

  @override
  int? id;

  String phoneHash;

  String? ipHash;

  String purpose;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [OtpAttempt]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OtpAttempt copyWith({
    int? id,
    String? phoneHash,
    String? ipHash,
    String? purpose,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OtpAttempt',
      if (id != null) 'id': id,
      'phoneHash': phoneHash,
      if (ipHash != null) 'ipHash': ipHash,
      'purpose': purpose,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static OtpAttemptInclude include() {
    return OtpAttemptInclude._();
  }

  static OtpAttemptIncludeList includeList({
    _is.WhereExpressionBuilder<OtpAttemptTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OtpAttemptTable>? orderBy,
    _is.OrderByListBuilder<OtpAttemptTable>? orderByList,
    OtpAttemptInclude? include,
  }) {
    return OtpAttemptIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OtpAttempt.t),
      orderByList: orderByList?.call(OtpAttempt.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OtpAttemptImpl extends OtpAttempt {
  _OtpAttemptImpl({
    int? id,
    required String phoneHash,
    String? ipHash,
    required String purpose,
    DateTime? createdAt,
  }) : super._(
         id: id,
         phoneHash: phoneHash,
         ipHash: ipHash,
         purpose: purpose,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [OtpAttempt]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OtpAttempt copyWith({
    Object? id = _Undefined,
    String? phoneHash,
    Object? ipHash = _Undefined,
    String? purpose,
    DateTime? createdAt,
  }) {
    return OtpAttempt(
      id: id is int? ? id : this.id,
      phoneHash: phoneHash ?? this.phoneHash,
      ipHash: ipHash is String? ? ipHash : this.ipHash,
      purpose: purpose ?? this.purpose,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class OtpAttemptUpdateTable extends _is.UpdateTable<OtpAttemptTable> {
  OtpAttemptUpdateTable(super.table);

  _is.ColumnValue<String, String> phoneHash(String value) => _is.ColumnValue(
    table.phoneHash,
    value,
  );

  _is.ColumnValue<String, String> ipHash(String? value) => _is.ColumnValue(
    table.ipHash,
    value,
  );

  _is.ColumnValue<String, String> purpose(String value) => _is.ColumnValue(
    table.purpose,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class OtpAttemptTable extends _is.Table<int?> {
  OtpAttemptTable({super.tableRelation}) : super(tableName: 'otp_attempt') {
    updateTable = OtpAttemptUpdateTable(this);
    phoneHash = _is.ColumnString(
      'phoneHash',
      this,
    );
    ipHash = _is.ColumnString(
      'ipHash',
      this,
    );
    purpose = _is.ColumnString(
      'purpose',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final OtpAttemptUpdateTable updateTable;

  late final _is.ColumnString phoneHash;

  late final _is.ColumnString ipHash;

  late final _is.ColumnString purpose;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    phoneHash,
    ipHash,
    purpose,
    createdAt,
  ];
}

class OtpAttemptInclude extends _is.IncludeObject {
  OtpAttemptInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => OtpAttempt.t;
}

class OtpAttemptIncludeList extends _is.IncludeList {
  OtpAttemptIncludeList._({
    _is.WhereExpressionBuilder<OtpAttemptTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OtpAttempt.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => OtpAttempt.t;
}

class OtpAttemptRepository {
  const OtpAttemptRepository._();

  /// Returns a list of [OtpAttempt]s matching the given query parameters.
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
  Future<List<OtpAttempt>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OtpAttemptTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OtpAttemptTable>? orderBy,
    _is.OrderByListBuilder<OtpAttemptTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OtpAttempt>(
      where: where?.call(OtpAttempt.t),
      orderBy: orderBy?.call(OtpAttempt.t),
      orderByList: orderByList?.call(OtpAttempt.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OtpAttempt] matching the given query parameters.
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
  Future<OtpAttempt?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OtpAttemptTable>? where,
    int? offset,
    _is.OrderByBuilder<OtpAttemptTable>? orderBy,
    _is.OrderByListBuilder<OtpAttemptTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OtpAttempt>(
      where: where?.call(OtpAttempt.t),
      orderBy: orderBy?.call(OtpAttempt.t),
      orderByList: orderByList?.call(OtpAttempt.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OtpAttempt] by its [id] or null if no such row exists.
  Future<OtpAttempt?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OtpAttempt>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OtpAttempt]s in the list and returns the inserted rows.
  ///
  /// The returned [OtpAttempt]s will have their `id` fields set.
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
  Future<List<OtpAttempt>> insert(
    _is.DatabaseSession session,
    List<OtpAttempt> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<OtpAttempt>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [OtpAttempt] and returns the inserted row.
  ///
  /// The returned [OtpAttempt] will have its `id` field set.
  Future<OtpAttempt> insertRow(
    _is.DatabaseSession session,
    OtpAttempt row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<OtpAttempt>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [OtpAttempt]s in the list and returns the resulting rows.
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
  /// The returned [OtpAttempt]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OtpAttempt>> upsert(
    _is.DatabaseSession session,
    List<OtpAttempt> rows, {
    required _is.ColumnSelections<OtpAttemptTable> conflictColumns,
    _is.ColumnSelections<OtpAttemptTable>? updateColumns,
    _is.WhereExpressionBuilder<OtpAttemptTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<OtpAttempt>(
      rows,
      conflictColumns: conflictColumns(OtpAttempt.t),
      updateColumns: updateColumns?.call(OtpAttempt.t),
      updateWhere: updateWhere?.call(OtpAttempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [OtpAttempt] and returns the resulting row.
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
  /// The returned [OtpAttempt] will have its `id` field set.
  Future<OtpAttempt?> upsertRow(
    _is.DatabaseSession session,
    OtpAttempt row, {
    required _is.ColumnSelections<OtpAttemptTable> conflictColumns,
    _is.ColumnSelections<OtpAttemptTable>? updateColumns,
    _is.WhereExpressionBuilder<OtpAttemptTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<OtpAttempt>(
      row,
      conflictColumns: conflictColumns(OtpAttempt.t),
      updateColumns: updateColumns?.call(OtpAttempt.t),
      updateWhere: updateWhere?.call(OtpAttempt.t),
      transaction: transaction,
    );
  }

  /// Updates all [OtpAttempt]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OtpAttempt>> update(
    _is.DatabaseSession session,
    List<OtpAttempt> rows, {
    _is.ColumnSelections<OtpAttemptTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<OtpAttempt>(
      rows,
      columns: columns?.call(OtpAttempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [OtpAttempt]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OtpAttempt> updateRow(
    _is.DatabaseSession session,
    OtpAttempt row, {
    _is.ColumnSelections<OtpAttemptTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<OtpAttempt>(
      row,
      columns: columns?.call(OtpAttempt.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OtpAttempt] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OtpAttempt?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<OtpAttemptUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<OtpAttempt>(
      id,
      columnValues: columnValues(OtpAttempt.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OtpAttempt]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OtpAttempt>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<OtpAttemptUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<OtpAttemptTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OtpAttemptTable>? orderBy,
    _is.OrderByListBuilder<OtpAttemptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<OtpAttempt>(
      columnValues: columnValues(OtpAttempt.t.updateTable),
      where: where(OtpAttempt.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OtpAttempt.t),
      orderByList: orderByList?.call(OtpAttempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [OtpAttempt]s in the list and returns the deleted rows.
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
  Future<List<OtpAttempt>> delete(
    _is.DatabaseSession session,
    List<OtpAttempt> rows, {
    _is.OrderByBuilder<OtpAttemptTable>? orderBy,
    _is.OrderByListBuilder<OtpAttemptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<OtpAttempt>(
      rows,
      orderBy: orderBy?.call(OtpAttempt.t),
      orderByList: orderByList?.call(OtpAttempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [OtpAttempt].
  Future<OtpAttempt> deleteRow(
    _is.DatabaseSession session,
    OtpAttempt row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OtpAttempt>(
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
  Future<List<OtpAttempt>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OtpAttemptTable> where,
    _is.OrderByBuilder<OtpAttemptTable>? orderBy,
    _is.OrderByListBuilder<OtpAttemptTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<OtpAttempt>(
      where: where(OtpAttempt.t),
      orderBy: orderBy?.call(OtpAttempt.t),
      orderByList: orderByList?.call(OtpAttempt.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OtpAttemptTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<OtpAttempt>(
      where: where?.call(OtpAttempt.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OtpAttempt] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OtpAttemptTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OtpAttempt>(
      where: where(OtpAttempt.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
