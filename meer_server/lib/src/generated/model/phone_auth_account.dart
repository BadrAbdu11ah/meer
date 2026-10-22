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
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;

abstract class PhoneAuthAccount
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PhoneAuthAccount._({
    this.id,
    required this.authUserId,
    this.authUser,
    required this.phone,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory PhoneAuthAccount({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    required String phone,
    DateTime? createdAt,
  }) = _PhoneAuthAccountImpl;

  factory PhoneAuthAccount.fromJson(Map<String, dynamic> jsonSerialization) {
    return PhoneAuthAccount(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _i58zzwu7.Protocol().deserialize<_iacs.AuthUser>(
              jsonSerialization['authUser'],
            ),
      phone: jsonSerialization['phone'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = PhoneAuthAccountTable();

  static const db = PhoneAuthAccountRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  _iacs.AuthUser? authUser;

  String phone;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PhoneAuthAccount]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PhoneAuthAccount copyWith({
    int? id,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    String? phone,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PhoneAuthAccount',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'phone': phone,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static PhoneAuthAccountInclude include({_iacs.AuthUserInclude? authUser}) {
    return PhoneAuthAccountInclude._(authUser: authUser);
  }

  static PhoneAuthAccountIncludeList includeList({
    _is.WhereExpressionBuilder<PhoneAuthAccountTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PhoneAuthAccountTable>? orderBy,
    _is.OrderByListBuilder<PhoneAuthAccountTable>? orderByList,
    PhoneAuthAccountInclude? include,
  }) {
    return PhoneAuthAccountIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PhoneAuthAccount.t),
      orderByList: orderByList?.call(PhoneAuthAccount.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PhoneAuthAccountImpl extends PhoneAuthAccount {
  _PhoneAuthAccountImpl({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    required String phone,
    DateTime? createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         phone: phone,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PhoneAuthAccount]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PhoneAuthAccount copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    Object? authUser = _Undefined,
    String? phone,
    DateTime? createdAt,
  }) {
    return PhoneAuthAccount(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacs.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class PhoneAuthAccountUpdateTable
    extends _is.UpdateTable<PhoneAuthAccountTable> {
  PhoneAuthAccountUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> phone(String value) => _is.ColumnValue(
    table.phone,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class PhoneAuthAccountTable extends _is.Table<int?> {
  PhoneAuthAccountTable({super.tableRelation})
    : super(tableName: 'phone_auth_account') {
    updateTable = PhoneAuthAccountUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    phone = _is.ColumnString(
      'phone',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final PhoneAuthAccountUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  _iacs.AuthUserTable? _authUser;

  late final _is.ColumnString phone;

  late final _is.ColumnDateTime createdAt;

  _iacs.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _is.createRelationTable(
      relationFieldName: 'authUser',
      field: PhoneAuthAccount.t.authUserId,
      foreignField: _iacs.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iacs.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _authUser!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    phone,
    createdAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'authUser') {
      return authUser;
    }
    return null;
  }
}

class PhoneAuthAccountInclude extends _is.IncludeObject {
  PhoneAuthAccountInclude._({_iacs.AuthUserInclude? authUser}) {
    _authUser = authUser;
  }

  _iacs.AuthUserInclude? _authUser;

  @override
  Map<String, _is.Include?> get includes => {'authUser': _authUser};

  @override
  _is.Table<int?> get table => PhoneAuthAccount.t;
}

class PhoneAuthAccountIncludeList extends _is.IncludeList {
  PhoneAuthAccountIncludeList._({
    _is.WhereExpressionBuilder<PhoneAuthAccountTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PhoneAuthAccount.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PhoneAuthAccount.t;
}

class PhoneAuthAccountRepository {
  const PhoneAuthAccountRepository._();

  final attachRow = const PhoneAuthAccountAttachRowRepository._();

  /// Returns a list of [PhoneAuthAccount]s matching the given query parameters.
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
  Future<List<PhoneAuthAccount>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PhoneAuthAccountTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PhoneAuthAccountTable>? orderBy,
    _is.OrderByListBuilder<PhoneAuthAccountTable>? orderByList,
    _is.Transaction? transaction,
    PhoneAuthAccountInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PhoneAuthAccount>(
      where: where?.call(PhoneAuthAccount.t),
      orderBy: orderBy?.call(PhoneAuthAccount.t),
      orderByList: orderByList?.call(PhoneAuthAccount.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PhoneAuthAccount] matching the given query parameters.
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
  Future<PhoneAuthAccount?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PhoneAuthAccountTable>? where,
    int? offset,
    _is.OrderByBuilder<PhoneAuthAccountTable>? orderBy,
    _is.OrderByListBuilder<PhoneAuthAccountTable>? orderByList,
    _is.Transaction? transaction,
    PhoneAuthAccountInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PhoneAuthAccount>(
      where: where?.call(PhoneAuthAccount.t),
      orderBy: orderBy?.call(PhoneAuthAccount.t),
      orderByList: orderByList?.call(PhoneAuthAccount.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PhoneAuthAccount] by its [id] or null if no such row exists.
  Future<PhoneAuthAccount?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    PhoneAuthAccountInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PhoneAuthAccount>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PhoneAuthAccount]s in the list and returns the inserted rows.
  ///
  /// The returned [PhoneAuthAccount]s will have their `id` fields set.
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
  Future<List<PhoneAuthAccount>> insert(
    _is.DatabaseSession session,
    List<PhoneAuthAccount> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PhoneAuthAccount>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PhoneAuthAccount] and returns the inserted row.
  ///
  /// The returned [PhoneAuthAccount] will have its `id` field set.
  Future<PhoneAuthAccount> insertRow(
    _is.DatabaseSession session,
    PhoneAuthAccount row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PhoneAuthAccount>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PhoneAuthAccount]s in the list and returns the resulting rows.
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
  /// The returned [PhoneAuthAccount]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PhoneAuthAccount>> upsert(
    _is.DatabaseSession session,
    List<PhoneAuthAccount> rows, {
    required _is.ColumnSelections<PhoneAuthAccountTable> conflictColumns,
    _is.ColumnSelections<PhoneAuthAccountTable>? updateColumns,
    _is.WhereExpressionBuilder<PhoneAuthAccountTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PhoneAuthAccount>(
      rows,
      conflictColumns: conflictColumns(PhoneAuthAccount.t),
      updateColumns: updateColumns?.call(PhoneAuthAccount.t),
      updateWhere: updateWhere?.call(PhoneAuthAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PhoneAuthAccount] and returns the resulting row.
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
  /// The returned [PhoneAuthAccount] will have its `id` field set.
  Future<PhoneAuthAccount?> upsertRow(
    _is.DatabaseSession session,
    PhoneAuthAccount row, {
    required _is.ColumnSelections<PhoneAuthAccountTable> conflictColumns,
    _is.ColumnSelections<PhoneAuthAccountTable>? updateColumns,
    _is.WhereExpressionBuilder<PhoneAuthAccountTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PhoneAuthAccount>(
      row,
      conflictColumns: conflictColumns(PhoneAuthAccount.t),
      updateColumns: updateColumns?.call(PhoneAuthAccount.t),
      updateWhere: updateWhere?.call(PhoneAuthAccount.t),
      transaction: transaction,
    );
  }

  /// Updates all [PhoneAuthAccount]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PhoneAuthAccount>> update(
    _is.DatabaseSession session,
    List<PhoneAuthAccount> rows, {
    _is.ColumnSelections<PhoneAuthAccountTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PhoneAuthAccount>(
      rows,
      columns: columns?.call(PhoneAuthAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PhoneAuthAccount]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PhoneAuthAccount> updateRow(
    _is.DatabaseSession session,
    PhoneAuthAccount row, {
    _is.ColumnSelections<PhoneAuthAccountTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PhoneAuthAccount>(
      row,
      columns: columns?.call(PhoneAuthAccount.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PhoneAuthAccount] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PhoneAuthAccount?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PhoneAuthAccountUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PhoneAuthAccount>(
      id,
      columnValues: columnValues(PhoneAuthAccount.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PhoneAuthAccount]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PhoneAuthAccount>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PhoneAuthAccountUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<PhoneAuthAccountTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PhoneAuthAccountTable>? orderBy,
    _is.OrderByListBuilder<PhoneAuthAccountTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PhoneAuthAccount>(
      columnValues: columnValues(PhoneAuthAccount.t.updateTable),
      where: where(PhoneAuthAccount.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PhoneAuthAccount.t),
      orderByList: orderByList?.call(PhoneAuthAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PhoneAuthAccount]s in the list and returns the deleted rows.
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
  Future<List<PhoneAuthAccount>> delete(
    _is.DatabaseSession session,
    List<PhoneAuthAccount> rows, {
    _is.OrderByBuilder<PhoneAuthAccountTable>? orderBy,
    _is.OrderByListBuilder<PhoneAuthAccountTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PhoneAuthAccount>(
      rows,
      orderBy: orderBy?.call(PhoneAuthAccount.t),
      orderByList: orderByList?.call(PhoneAuthAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PhoneAuthAccount].
  Future<PhoneAuthAccount> deleteRow(
    _is.DatabaseSession session,
    PhoneAuthAccount row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PhoneAuthAccount>(
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
  Future<List<PhoneAuthAccount>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PhoneAuthAccountTable> where,
    _is.OrderByBuilder<PhoneAuthAccountTable>? orderBy,
    _is.OrderByListBuilder<PhoneAuthAccountTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PhoneAuthAccount>(
      where: where(PhoneAuthAccount.t),
      orderBy: orderBy?.call(PhoneAuthAccount.t),
      orderByList: orderByList?.call(PhoneAuthAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PhoneAuthAccountTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PhoneAuthAccount>(
      where: where?.call(PhoneAuthAccount.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PhoneAuthAccount] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PhoneAuthAccountTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PhoneAuthAccount>(
      where: where(PhoneAuthAccount.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class PhoneAuthAccountAttachRowRepository {
  const PhoneAuthAccountAttachRowRepository._();

  /// Creates a relation between the given [PhoneAuthAccount] and [AuthUser]
  /// by setting the [PhoneAuthAccount]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _is.DatabaseSession session,
    PhoneAuthAccount phoneAuthAccount,
    _iacs.AuthUser authUser, {
    _is.Transaction? transaction,
  }) async {
    if (phoneAuthAccount.id == null) {
      throw ArgumentError.notNull('phoneAuthAccount.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $phoneAuthAccount = phoneAuthAccount.copyWith(authUserId: authUser.id);
    await session.db.updateRow<PhoneAuthAccount>(
      $phoneAuthAccount,
      columns: [PhoneAuthAccount.t.authUserId],
      transaction: transaction,
    );
  }
}
