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

abstract class UserDeviceInstallation
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  UserDeviceInstallation._({
    this.id,
    required this.authUserId,
    required this.installationId,
    required this.platform,
    DateTime? createdAt,
    DateTime? lastSeenAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       lastSeenAt = lastSeenAt ?? DateTime.now();

  factory UserDeviceInstallation({
    int? id,
    required _is.UuidValue authUserId,
    required String installationId,
    required String platform,
    DateTime? createdAt,
    DateTime? lastSeenAt,
  }) = _UserDeviceInstallationImpl;

  factory UserDeviceInstallation.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UserDeviceInstallation(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      installationId: jsonSerialization['installationId'] as String,
      platform: jsonSerialization['platform'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      lastSeenAt: jsonSerialization['lastSeenAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['lastSeenAt']),
    );
  }

  static final t = UserDeviceInstallationTable();

  static const db = UserDeviceInstallationRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  String installationId;

  String platform;

  DateTime createdAt;

  DateTime lastSeenAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserDeviceInstallation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  UserDeviceInstallation copyWith({
    int? id,
    _is.UuidValue? authUserId,
    String? installationId,
    String? platform,
    DateTime? createdAt,
    DateTime? lastSeenAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserDeviceInstallation',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'installationId': installationId,
      'platform': platform,
      'createdAt': createdAt.toJson(),
      'lastSeenAt': lastSeenAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserDeviceInstallation',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'installationId': installationId,
      'platform': platform,
      'createdAt': createdAt.toJson(),
      'lastSeenAt': lastSeenAt.toJson(),
    };
  }

  static UserDeviceInstallationInclude include() {
    return UserDeviceInstallationInclude._();
  }

  static UserDeviceInstallationIncludeList includeList({
    _is.WhereExpressionBuilder<UserDeviceInstallationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserDeviceInstallationTable>? orderBy,
    _is.OrderByListBuilder<UserDeviceInstallationTable>? orderByList,
    UserDeviceInstallationInclude? include,
  }) {
    return UserDeviceInstallationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserDeviceInstallation.t),
      orderByList: orderByList?.call(UserDeviceInstallation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserDeviceInstallationImpl extends UserDeviceInstallation {
  _UserDeviceInstallationImpl({
    int? id,
    required _is.UuidValue authUserId,
    required String installationId,
    required String platform,
    DateTime? createdAt,
    DateTime? lastSeenAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         installationId: installationId,
         platform: platform,
         createdAt: createdAt,
         lastSeenAt: lastSeenAt,
       );

  /// Returns a shallow copy of this [UserDeviceInstallation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  UserDeviceInstallation copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    String? installationId,
    String? platform,
    DateTime? createdAt,
    DateTime? lastSeenAt,
  }) {
    return UserDeviceInstallation(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      installationId: installationId ?? this.installationId,
      platform: platform ?? this.platform,
      createdAt: createdAt ?? this.createdAt,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
    );
  }
}

class UserDeviceInstallationUpdateTable
    extends _is.UpdateTable<UserDeviceInstallationTable> {
  UserDeviceInstallationUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> installationId(String value) =>
      _is.ColumnValue(
        table.installationId,
        value,
      );

  _is.ColumnValue<String, String> platform(String value) => _is.ColumnValue(
    table.platform,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastSeenAt(DateTime value) =>
      _is.ColumnValue(
        table.lastSeenAt,
        value,
      );
}

class UserDeviceInstallationTable extends _is.Table<int?> {
  UserDeviceInstallationTable({super.tableRelation})
    : super(tableName: 'user_device_installation') {
    updateTable = UserDeviceInstallationUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    installationId = _is.ColumnString(
      'installationId',
      this,
    );
    platform = _is.ColumnString(
      'platform',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    lastSeenAt = _is.ColumnDateTime(
      'lastSeenAt',
      this,
      hasDefault: true,
    );
  }

  late final UserDeviceInstallationUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString installationId;

  late final _is.ColumnString platform;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime lastSeenAt;

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    installationId,
    platform,
    createdAt,
    lastSeenAt,
  ];
}

class UserDeviceInstallationInclude extends _is.IncludeObject {
  UserDeviceInstallationInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => UserDeviceInstallation.t;
}

class UserDeviceInstallationIncludeList extends _is.IncludeList {
  UserDeviceInstallationIncludeList._({
    _is.WhereExpressionBuilder<UserDeviceInstallationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserDeviceInstallation.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => UserDeviceInstallation.t;
}

class UserDeviceInstallationRepository {
  const UserDeviceInstallationRepository._();

  /// Returns a list of [UserDeviceInstallation]s matching the given query parameters.
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
  Future<List<UserDeviceInstallation>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserDeviceInstallationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserDeviceInstallationTable>? orderBy,
    _is.OrderByListBuilder<UserDeviceInstallationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserDeviceInstallation>(
      where: where?.call(UserDeviceInstallation.t),
      orderBy: orderBy?.call(UserDeviceInstallation.t),
      orderByList: orderByList?.call(UserDeviceInstallation.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserDeviceInstallation] matching the given query parameters.
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
  Future<UserDeviceInstallation?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserDeviceInstallationTable>? where,
    int? offset,
    _is.OrderByBuilder<UserDeviceInstallationTable>? orderBy,
    _is.OrderByListBuilder<UserDeviceInstallationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserDeviceInstallation>(
      where: where?.call(UserDeviceInstallation.t),
      orderBy: orderBy?.call(UserDeviceInstallation.t),
      orderByList: orderByList?.call(UserDeviceInstallation.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserDeviceInstallation] by its [id] or null if no such row exists.
  Future<UserDeviceInstallation?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserDeviceInstallation>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserDeviceInstallation]s in the list and returns the inserted rows.
  ///
  /// The returned [UserDeviceInstallation]s will have their `id` fields set.
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
  Future<List<UserDeviceInstallation>> insert(
    _is.DatabaseSession session,
    List<UserDeviceInstallation> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<UserDeviceInstallation>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [UserDeviceInstallation] and returns the inserted row.
  ///
  /// The returned [UserDeviceInstallation] will have its `id` field set.
  Future<UserDeviceInstallation> insertRow(
    _is.DatabaseSession session,
    UserDeviceInstallation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserDeviceInstallation>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [UserDeviceInstallation]s in the list and returns the resulting rows.
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
  /// The returned [UserDeviceInstallation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserDeviceInstallation>> upsert(
    _is.DatabaseSession session,
    List<UserDeviceInstallation> rows, {
    required _is.ColumnSelections<UserDeviceInstallationTable> conflictColumns,
    _is.ColumnSelections<UserDeviceInstallationTable>? updateColumns,
    _is.WhereExpressionBuilder<UserDeviceInstallationTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<UserDeviceInstallation>(
      rows,
      conflictColumns: conflictColumns(UserDeviceInstallation.t),
      updateColumns: updateColumns?.call(UserDeviceInstallation.t),
      updateWhere: updateWhere?.call(UserDeviceInstallation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [UserDeviceInstallation] and returns the resulting row.
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
  /// The returned [UserDeviceInstallation] will have its `id` field set.
  Future<UserDeviceInstallation?> upsertRow(
    _is.DatabaseSession session,
    UserDeviceInstallation row, {
    required _is.ColumnSelections<UserDeviceInstallationTable> conflictColumns,
    _is.ColumnSelections<UserDeviceInstallationTable>? updateColumns,
    _is.WhereExpressionBuilder<UserDeviceInstallationTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<UserDeviceInstallation>(
      row,
      conflictColumns: conflictColumns(UserDeviceInstallation.t),
      updateColumns: updateColumns?.call(UserDeviceInstallation.t),
      updateWhere: updateWhere?.call(UserDeviceInstallation.t),
      transaction: transaction,
    );
  }

  /// Updates all [UserDeviceInstallation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserDeviceInstallation>> update(
    _is.DatabaseSession session,
    List<UserDeviceInstallation> rows, {
    _is.ColumnSelections<UserDeviceInstallationTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<UserDeviceInstallation>(
      rows,
      columns: columns?.call(UserDeviceInstallation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [UserDeviceInstallation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserDeviceInstallation> updateRow(
    _is.DatabaseSession session,
    UserDeviceInstallation row, {
    _is.ColumnSelections<UserDeviceInstallationTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserDeviceInstallation>(
      row,
      columns: columns?.call(UserDeviceInstallation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserDeviceInstallation] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserDeviceInstallation?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<UserDeviceInstallationUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<UserDeviceInstallation>(
      id,
      columnValues: columnValues(UserDeviceInstallation.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserDeviceInstallation]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserDeviceInstallation>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<UserDeviceInstallationUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<UserDeviceInstallationTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserDeviceInstallationTable>? orderBy,
    _is.OrderByListBuilder<UserDeviceInstallationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<UserDeviceInstallation>(
      columnValues: columnValues(UserDeviceInstallation.t.updateTable),
      where: where(UserDeviceInstallation.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserDeviceInstallation.t),
      orderByList: orderByList?.call(UserDeviceInstallation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [UserDeviceInstallation]s in the list and returns the deleted rows.
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
  Future<List<UserDeviceInstallation>> delete(
    _is.DatabaseSession session,
    List<UserDeviceInstallation> rows, {
    _is.OrderByBuilder<UserDeviceInstallationTable>? orderBy,
    _is.OrderByListBuilder<UserDeviceInstallationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<UserDeviceInstallation>(
      rows,
      orderBy: orderBy?.call(UserDeviceInstallation.t),
      orderByList: orderByList?.call(UserDeviceInstallation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [UserDeviceInstallation].
  Future<UserDeviceInstallation> deleteRow(
    _is.DatabaseSession session,
    UserDeviceInstallation row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserDeviceInstallation>(
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
  Future<List<UserDeviceInstallation>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserDeviceInstallationTable> where,
    _is.OrderByBuilder<UserDeviceInstallationTable>? orderBy,
    _is.OrderByListBuilder<UserDeviceInstallationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<UserDeviceInstallation>(
      where: where(UserDeviceInstallation.t),
      orderBy: orderBy?.call(UserDeviceInstallation.t),
      orderByList: orderByList?.call(UserDeviceInstallation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserDeviceInstallationTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<UserDeviceInstallation>(
      where: where?.call(UserDeviceInstallation.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserDeviceInstallation] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserDeviceInstallationTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserDeviceInstallation>(
      where: where(UserDeviceInstallation.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
