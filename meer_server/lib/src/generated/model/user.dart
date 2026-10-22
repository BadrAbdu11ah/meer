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

abstract class User implements _is.TableRow<int?>, _is.ProtocolSerialization {
  User._({
    this.id,
    this.authUserId,
    this.authUser,
    required this.fullName,
    required this.phone,
    this.email,
    required this.role,
    this.address,
    this.latitude,
    this.longitude,
    required this.createdAt,
  });

  factory User({
    int? id,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    required String fullName,
    required String phone,
    String? email,
    required String role,
    String? address,
    double? latitude,
    double? longitude,
    required DateTime createdAt,
  }) = _UserImpl;

  factory User.fromJson(Map<String, dynamic> jsonSerialization) {
    return User(
      id: jsonSerialization['id'] as int?,
      authUserId: jsonSerialization['authUserId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['authUserId'],
            ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _i58zzwu7.Protocol().deserialize<_iacs.AuthUser>(
              jsonSerialization['authUser'],
            ),
      fullName: jsonSerialization['fullName'] as String,
      phone: jsonSerialization['phone'] as String,
      email: jsonSerialization['email'] as String?,
      role: jsonSerialization['role'] as String,
      address: jsonSerialization['address'] as String?,
      latitude: (jsonSerialization['latitude'] as num?)?.toDouble(),
      longitude: (jsonSerialization['longitude'] as num?)?.toDouble(),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = UserTable();

  static const db = UserRepository._();

  @override
  int? id;

  _is.UuidValue? authUserId;

  /// ربط المستخدم بحساب المصادقة في Serverpod
  _iacs.AuthUser? authUser;

  String fullName;

  String phone;

  String? email;

  String role;

  String? address;

  double? latitude;

  double? longitude;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  User copyWith({
    int? id,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    String? fullName,
    String? phone,
    String? email,
    String? role,
    String? address,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'User',
      if (id != null) 'id': id,
      if (authUserId != null) 'authUserId': authUserId?.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'fullName': fullName,
      'phone': phone,
      if (email != null) 'email': email,
      'role': role,
      if (address != null) 'address': address,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'User',
      if (id != null) 'id': id,
      if (authUserId != null) 'authUserId': authUserId?.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'fullName': fullName,
      'phone': phone,
      if (email != null) 'email': email,
      'role': role,
      if (address != null) 'address': address,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      'createdAt': createdAt.toJson(),
    };
  }

  static UserInclude include({_iacs.AuthUserInclude? authUser}) {
    return UserInclude._(authUser: authUser);
  }

  static UserIncludeList includeList({
    _is.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserTable>? orderBy,
    _is.OrderByListBuilder<UserTable>? orderByList,
    UserInclude? include,
  }) {
    return UserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    int? id,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    required String fullName,
    required String phone,
    String? email,
    required String role,
    String? address,
    double? latitude,
    double? longitude,
    required DateTime createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         fullName: fullName,
         phone: phone,
         email: email,
         role: role,
         address: address,
         latitude: latitude,
         longitude: longitude,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  User copyWith({
    Object? id = _Undefined,
    Object? authUserId = _Undefined,
    Object? authUser = _Undefined,
    String? fullName,
    String? phone,
    Object? email = _Undefined,
    String? role,
    Object? address = _Undefined,
    Object? latitude = _Undefined,
    Object? longitude = _Undefined,
    DateTime? createdAt,
  }) {
    return User(
      id: id is int? ? id : this.id,
      authUserId: authUserId is _is.UuidValue? ? authUserId : this.authUserId,
      authUser: authUser is _iacs.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      email: email is String? ? email : this.email,
      role: role ?? this.role,
      address: address is String? ? address : this.address,
      latitude: latitude is double? ? latitude : this.latitude,
      longitude: longitude is double? ? longitude : this.longitude,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class UserUpdateTable extends _is.UpdateTable<UserTable> {
  UserUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> fullName(String value) => _is.ColumnValue(
    table.fullName,
    value,
  );

  _is.ColumnValue<String, String> phone(String value) => _is.ColumnValue(
    table.phone,
    value,
  );

  _is.ColumnValue<String, String> email(String? value) => _is.ColumnValue(
    table.email,
    value,
  );

  _is.ColumnValue<String, String> role(String value) => _is.ColumnValue(
    table.role,
    value,
  );

  _is.ColumnValue<String, String> address(String? value) => _is.ColumnValue(
    table.address,
    value,
  );

  _is.ColumnValue<double, double> latitude(double? value) => _is.ColumnValue(
    table.latitude,
    value,
  );

  _is.ColumnValue<double, double> longitude(double? value) => _is.ColumnValue(
    table.longitude,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class UserTable extends _is.Table<int?> {
  UserTable({super.tableRelation}) : super(tableName: 'user') {
    updateTable = UserUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    fullName = _is.ColumnString(
      'fullName',
      this,
    );
    phone = _is.ColumnString(
      'phone',
      this,
    );
    email = _is.ColumnString(
      'email',
      this,
    );
    role = _is.ColumnString(
      'role',
      this,
    );
    address = _is.ColumnString(
      'address',
      this,
    );
    latitude = _is.ColumnDouble(
      'latitude',
      this,
    );
    longitude = _is.ColumnDouble(
      'longitude',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final UserUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  /// ربط المستخدم بحساب المصادقة في Serverpod
  _iacs.AuthUserTable? _authUser;

  late final _is.ColumnString fullName;

  late final _is.ColumnString phone;

  late final _is.ColumnString email;

  late final _is.ColumnString role;

  late final _is.ColumnString address;

  late final _is.ColumnDouble latitude;

  late final _is.ColumnDouble longitude;

  late final _is.ColumnDateTime createdAt;

  _iacs.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _is.createRelationTable(
      relationFieldName: 'authUser',
      field: User.t.authUserId,
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
    fullName,
    phone,
    email,
    role,
    address,
    latitude,
    longitude,
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

class UserInclude extends _is.IncludeObject {
  UserInclude._({_iacs.AuthUserInclude? authUser}) {
    _authUser = authUser;
  }

  _iacs.AuthUserInclude? _authUser;

  @override
  Map<String, _is.Include?> get includes => {'authUser': _authUser};

  @override
  _is.Table<int?> get table => User.t;
}

class UserIncludeList extends _is.IncludeList {
  UserIncludeList._({
    _is.WhereExpressionBuilder<UserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(User.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => User.t;
}

class UserRepository {
  const UserRepository._();

  final attachRow = const UserAttachRowRepository._();

  final detachRow = const UserDetachRowRepository._();

  /// Returns a list of [User]s matching the given query parameters.
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
  Future<List<User>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserTable>? orderBy,
    _is.OrderByListBuilder<UserTable>? orderByList,
    _is.Transaction? transaction,
    UserInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<User>(
      where: where?.call(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [User] matching the given query parameters.
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
  Future<User?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserTable>? where,
    int? offset,
    _is.OrderByBuilder<UserTable>? orderBy,
    _is.OrderByListBuilder<UserTable>? orderByList,
    _is.Transaction? transaction,
    UserInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<User>(
      where: where?.call(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [User] by its [id] or null if no such row exists.
  Future<User?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    UserInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<User>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [User]s in the list and returns the inserted rows.
  ///
  /// The returned [User]s will have their `id` fields set.
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
  Future<List<User>> insert(
    _is.DatabaseSession session,
    List<User> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<User>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [User] and returns the inserted row.
  ///
  /// The returned [User] will have its `id` field set.
  Future<User> insertRow(
    _is.DatabaseSession session,
    User row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<User>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [User]s in the list and returns the resulting rows.
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
  /// The returned [User]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<User>> upsert(
    _is.DatabaseSession session,
    List<User> rows, {
    required _is.ColumnSelections<UserTable> conflictColumns,
    _is.ColumnSelections<UserTable>? updateColumns,
    _is.WhereExpressionBuilder<UserTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<User>(
      rows,
      conflictColumns: conflictColumns(User.t),
      updateColumns: updateColumns?.call(User.t),
      updateWhere: updateWhere?.call(User.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [User] and returns the resulting row.
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
  /// The returned [User] will have its `id` field set.
  Future<User?> upsertRow(
    _is.DatabaseSession session,
    User row, {
    required _is.ColumnSelections<UserTable> conflictColumns,
    _is.ColumnSelections<UserTable>? updateColumns,
    _is.WhereExpressionBuilder<UserTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<User>(
      row,
      conflictColumns: conflictColumns(User.t),
      updateColumns: updateColumns?.call(User.t),
      updateWhere: updateWhere?.call(User.t),
      transaction: transaction,
    );
  }

  /// Updates all [User]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<User>> update(
    _is.DatabaseSession session,
    List<User> rows, {
    _is.ColumnSelections<UserTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<User>(
      rows,
      columns: columns?.call(User.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [User]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<User> updateRow(
    _is.DatabaseSession session,
    User row, {
    _is.ColumnSelections<UserTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<User>(
      row,
      columns: columns?.call(User.t),
      transaction: transaction,
    );
  }

  /// Updates a single [User] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<User?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<UserUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<User>(
      id,
      columnValues: columnValues(User.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [User]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<User>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<UserUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<UserTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserTable>? orderBy,
    _is.OrderByListBuilder<UserTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<User>(
      columnValues: columnValues(User.t.updateTable),
      where: where(User.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [User]s in the list and returns the deleted rows.
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
  Future<List<User>> delete(
    _is.DatabaseSession session,
    List<User> rows, {
    _is.OrderByBuilder<UserTable>? orderBy,
    _is.OrderByListBuilder<UserTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<User>(
      rows,
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [User].
  Future<User> deleteRow(
    _is.DatabaseSession session,
    User row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<User>(
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
  Future<List<User>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserTable> where,
    _is.OrderByBuilder<UserTable>? orderBy,
    _is.OrderByListBuilder<UserTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<User>(
      where: where(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<User>(
      where: where?.call(User.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [User] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<User>(
      where: where(User.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class UserAttachRowRepository {
  const UserAttachRowRepository._();

  /// Creates a relation between the given [User] and [AuthUser]
  /// by setting the [User]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _is.DatabaseSession session,
    User user,
    _iacs.AuthUser authUser, {
    _is.Transaction? transaction,
  }) async {
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $user = user.copyWith(authUserId: authUser.id);
    await session.db.updateRow<User>(
      $user,
      columns: [User.t.authUserId],
      transaction: transaction,
    );
  }
}

class UserDetachRowRepository {
  const UserDetachRowRepository._();

  /// Detaches the relation between this [User] and the [AuthUser] set in `authUser`
  /// by setting the [User]'s foreign key `authUserId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> authUser(
    _is.DatabaseSession session,
    User user, {
    _is.Transaction? transaction,
  }) async {
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $user = user.copyWith(authUserId: null);
    await session.db.updateRow<User>(
      $user,
      columns: [User.t.authUserId],
      transaction: transaction,
    );
  }
}
