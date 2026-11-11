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
import '../model/meer_city.dart' as _is2bz3ye;

abstract class MeerUserProfile
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  MeerUserProfile._({
    this.id,
    this.authUserId,
    this.authUser,
    required this.fullName,
    required this.phone,
    this.email,
    required this.role,
    bool? isSeller,
    this.address,
    this.latitude,
    this.longitude,
    this.storeName,
    this.storeDescription,
    this.storeAddress,
    this.storeCity,
    this.storeDistrict,
    this.storeLatitude,
    this.storeLongitude,
    required this.createdAt,
  }) : isSeller = isSeller ?? false;

  factory MeerUserProfile({
    int? id,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    required String fullName,
    required String phone,
    String? email,
    required String role,
    bool? isSeller,
    String? address,
    double? latitude,
    double? longitude,
    String? storeName,
    String? storeDescription,
    String? storeAddress,
    _is2bz3ye.MeerCity? storeCity,
    String? storeDistrict,
    double? storeLatitude,
    double? storeLongitude,
    required DateTime createdAt,
  }) = _MeerUserProfileImpl;

  factory MeerUserProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return MeerUserProfile(
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
      isSeller: jsonSerialization['isSeller'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isSeller']),
      address: jsonSerialization['address'] as String?,
      latitude: (jsonSerialization['latitude'] as num?)?.toDouble(),
      longitude: (jsonSerialization['longitude'] as num?)?.toDouble(),
      storeName: jsonSerialization['storeName'] as String?,
      storeDescription: jsonSerialization['storeDescription'] as String?,
      storeAddress: jsonSerialization['storeAddress'] as String?,
      storeCity: jsonSerialization['storeCity'] == null
          ? null
          : _is2bz3ye.MeerCity.fromJson(
              (jsonSerialization['storeCity'] as String),
            ),
      storeDistrict: jsonSerialization['storeDistrict'] as String?,
      storeLatitude: (jsonSerialization['storeLatitude'] as num?)?.toDouble(),
      storeLongitude: (jsonSerialization['storeLongitude'] as num?)?.toDouble(),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = MeerUserProfileTable();

  static const db = MeerUserProfileRepository._();

  @override
  int? id;

  _is.UuidValue? authUserId;

  _iacs.AuthUser? authUser;

  String fullName;

  String phone;

  String? email;

  String role;

  bool isSeller;

  String? address;

  double? latitude;

  double? longitude;

  String? storeName;

  String? storeDescription;

  String? storeAddress;

  _is2bz3ye.MeerCity? storeCity;

  String? storeDistrict;

  double? storeLatitude;

  double? storeLongitude;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [MeerUserProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MeerUserProfile copyWith({
    int? id,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    String? fullName,
    String? phone,
    String? email,
    String? role,
    bool? isSeller,
    String? address,
    double? latitude,
    double? longitude,
    String? storeName,
    String? storeDescription,
    String? storeAddress,
    _is2bz3ye.MeerCity? storeCity,
    String? storeDistrict,
    double? storeLatitude,
    double? storeLongitude,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MeerUserProfile',
      if (id != null) 'id': id,
      if (authUserId != null) 'authUserId': authUserId?.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'fullName': fullName,
      'phone': phone,
      if (email != null) 'email': email,
      'role': role,
      'isSeller': isSeller,
      if (address != null) 'address': address,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (storeName != null) 'storeName': storeName,
      if (storeDescription != null) 'storeDescription': storeDescription,
      if (storeAddress != null) 'storeAddress': storeAddress,
      if (storeCity != null) 'storeCity': storeCity?.toJson(),
      if (storeDistrict != null) 'storeDistrict': storeDistrict,
      if (storeLatitude != null) 'storeLatitude': storeLatitude,
      if (storeLongitude != null) 'storeLongitude': storeLongitude,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MeerUserProfile',
      if (id != null) 'id': id,
      if (authUserId != null) 'authUserId': authUserId?.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'fullName': fullName,
      'phone': phone,
      if (email != null) 'email': email,
      'role': role,
      'isSeller': isSeller,
      if (address != null) 'address': address,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (storeName != null) 'storeName': storeName,
      if (storeDescription != null) 'storeDescription': storeDescription,
      if (storeAddress != null) 'storeAddress': storeAddress,
      if (storeCity != null) 'storeCity': storeCity?.toJson(),
      if (storeDistrict != null) 'storeDistrict': storeDistrict,
      if (storeLatitude != null) 'storeLatitude': storeLatitude,
      if (storeLongitude != null) 'storeLongitude': storeLongitude,
      'createdAt': createdAt.toJson(),
    };
  }

  static MeerUserProfileInclude include({_iacs.AuthUserInclude? authUser}) {
    return MeerUserProfileInclude._(authUser: authUser);
  }

  static MeerUserProfileIncludeList includeList({
    _is.WhereExpressionBuilder<MeerUserProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MeerUserProfileTable>? orderBy,
    _is.OrderByListBuilder<MeerUserProfileTable>? orderByList,
    MeerUserProfileInclude? include,
  }) {
    return MeerUserProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MeerUserProfile.t),
      orderByList: orderByList?.call(MeerUserProfile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MeerUserProfileImpl extends MeerUserProfile {
  _MeerUserProfileImpl({
    int? id,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    required String fullName,
    required String phone,
    String? email,
    required String role,
    bool? isSeller,
    String? address,
    double? latitude,
    double? longitude,
    String? storeName,
    String? storeDescription,
    String? storeAddress,
    _is2bz3ye.MeerCity? storeCity,
    String? storeDistrict,
    double? storeLatitude,
    double? storeLongitude,
    required DateTime createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         fullName: fullName,
         phone: phone,
         email: email,
         role: role,
         isSeller: isSeller,
         address: address,
         latitude: latitude,
         longitude: longitude,
         storeName: storeName,
         storeDescription: storeDescription,
         storeAddress: storeAddress,
         storeCity: storeCity,
         storeDistrict: storeDistrict,
         storeLatitude: storeLatitude,
         storeLongitude: storeLongitude,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [MeerUserProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MeerUserProfile copyWith({
    Object? id = _Undefined,
    Object? authUserId = _Undefined,
    Object? authUser = _Undefined,
    String? fullName,
    String? phone,
    Object? email = _Undefined,
    String? role,
    bool? isSeller,
    Object? address = _Undefined,
    Object? latitude = _Undefined,
    Object? longitude = _Undefined,
    Object? storeName = _Undefined,
    Object? storeDescription = _Undefined,
    Object? storeAddress = _Undefined,
    Object? storeCity = _Undefined,
    Object? storeDistrict = _Undefined,
    Object? storeLatitude = _Undefined,
    Object? storeLongitude = _Undefined,
    DateTime? createdAt,
  }) {
    return MeerUserProfile(
      id: id is int? ? id : this.id,
      authUserId: authUserId is _is.UuidValue? ? authUserId : this.authUserId,
      authUser: authUser is _iacs.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      email: email is String? ? email : this.email,
      role: role ?? this.role,
      isSeller: isSeller ?? this.isSeller,
      address: address is String? ? address : this.address,
      latitude: latitude is double? ? latitude : this.latitude,
      longitude: longitude is double? ? longitude : this.longitude,
      storeName: storeName is String? ? storeName : this.storeName,
      storeDescription: storeDescription is String?
          ? storeDescription
          : this.storeDescription,
      storeAddress: storeAddress is String? ? storeAddress : this.storeAddress,
      storeCity: storeCity is _is2bz3ye.MeerCity? ? storeCity : this.storeCity,
      storeDistrict: storeDistrict is String?
          ? storeDistrict
          : this.storeDistrict,
      storeLatitude: storeLatitude is double?
          ? storeLatitude
          : this.storeLatitude,
      storeLongitude: storeLongitude is double?
          ? storeLongitude
          : this.storeLongitude,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class MeerUserProfileUpdateTable extends _is.UpdateTable<MeerUserProfileTable> {
  MeerUserProfileUpdateTable(super.table);

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

  _is.ColumnValue<bool, bool> isSeller(bool value) => _is.ColumnValue(
    table.isSeller,
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

  _is.ColumnValue<String, String> storeName(String? value) => _is.ColumnValue(
    table.storeName,
    value,
  );

  _is.ColumnValue<String, String> storeDescription(String? value) =>
      _is.ColumnValue(
        table.storeDescription,
        value,
      );

  _is.ColumnValue<String, String> storeAddress(String? value) =>
      _is.ColumnValue(
        table.storeAddress,
        value,
      );

  _is.ColumnValue<_is2bz3ye.MeerCity, _is2bz3ye.MeerCity> storeCity(
    _is2bz3ye.MeerCity? value,
  ) => _is.ColumnValue(
    table.storeCity,
    value,
  );

  _is.ColumnValue<String, String> storeDistrict(String? value) =>
      _is.ColumnValue(
        table.storeDistrict,
        value,
      );

  _is.ColumnValue<double, double> storeLatitude(double? value) =>
      _is.ColumnValue(
        table.storeLatitude,
        value,
      );

  _is.ColumnValue<double, double> storeLongitude(double? value) =>
      _is.ColumnValue(
        table.storeLongitude,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class MeerUserProfileTable extends _is.Table<int?> {
  MeerUserProfileTable({super.tableRelation}) : super(tableName: 'user') {
    updateTable = MeerUserProfileUpdateTable(this);
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
    isSeller = _is.ColumnBool(
      'isSeller',
      this,
      hasDefault: true,
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
    storeName = _is.ColumnString(
      'storeName',
      this,
    );
    storeDescription = _is.ColumnString(
      'storeDescription',
      this,
    );
    storeAddress = _is.ColumnString(
      'storeAddress',
      this,
    );
    storeCity = _is.ColumnEnum(
      'storeCity',
      this,
      _is.EnumSerialization.byName,
    );
    storeDistrict = _is.ColumnString(
      'storeDistrict',
      this,
    );
    storeLatitude = _is.ColumnDouble(
      'storeLatitude',
      this,
    );
    storeLongitude = _is.ColumnDouble(
      'storeLongitude',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final MeerUserProfileUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  _iacs.AuthUserTable? _authUser;

  late final _is.ColumnString fullName;

  late final _is.ColumnString phone;

  late final _is.ColumnString email;

  late final _is.ColumnString role;

  late final _is.ColumnBool isSeller;

  late final _is.ColumnString address;

  late final _is.ColumnDouble latitude;

  late final _is.ColumnDouble longitude;

  late final _is.ColumnString storeName;

  late final _is.ColumnString storeDescription;

  late final _is.ColumnString storeAddress;

  late final _is.ColumnEnum<_is2bz3ye.MeerCity> storeCity;

  late final _is.ColumnString storeDistrict;

  late final _is.ColumnDouble storeLatitude;

  late final _is.ColumnDouble storeLongitude;

  late final _is.ColumnDateTime createdAt;

  _iacs.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _is.createRelationTable(
      relationFieldName: 'authUser',
      field: MeerUserProfile.t.authUserId,
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
    isSeller,
    address,
    latitude,
    longitude,
    storeName,
    storeDescription,
    storeAddress,
    storeCity,
    storeDistrict,
    storeLatitude,
    storeLongitude,
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

class MeerUserProfileInclude extends _is.IncludeObject {
  MeerUserProfileInclude._({_iacs.AuthUserInclude? authUser}) {
    _authUser = authUser;
  }

  _iacs.AuthUserInclude? _authUser;

  @override
  Map<String, _is.Include?> get includes => {'authUser': _authUser};

  @override
  _is.Table<int?> get table => MeerUserProfile.t;
}

class MeerUserProfileIncludeList extends _is.IncludeList {
  MeerUserProfileIncludeList._({
    _is.WhereExpressionBuilder<MeerUserProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MeerUserProfile.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => MeerUserProfile.t;
}

class MeerUserProfileRepository {
  const MeerUserProfileRepository._();

  final attachRow = const MeerUserProfileAttachRowRepository._();

  final detachRow = const MeerUserProfileDetachRowRepository._();

  /// Returns a list of [MeerUserProfile]s matching the given query parameters.
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
  Future<List<MeerUserProfile>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MeerUserProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MeerUserProfileTable>? orderBy,
    _is.OrderByListBuilder<MeerUserProfileTable>? orderByList,
    _is.Transaction? transaction,
    MeerUserProfileInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MeerUserProfile>(
      where: where?.call(MeerUserProfile.t),
      orderBy: orderBy?.call(MeerUserProfile.t),
      orderByList: orderByList?.call(MeerUserProfile.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MeerUserProfile] matching the given query parameters.
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
  Future<MeerUserProfile?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MeerUserProfileTable>? where,
    int? offset,
    _is.OrderByBuilder<MeerUserProfileTable>? orderBy,
    _is.OrderByListBuilder<MeerUserProfileTable>? orderByList,
    _is.Transaction? transaction,
    MeerUserProfileInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MeerUserProfile>(
      where: where?.call(MeerUserProfile.t),
      orderBy: orderBy?.call(MeerUserProfile.t),
      orderByList: orderByList?.call(MeerUserProfile.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MeerUserProfile] by its [id] or null if no such row exists.
  Future<MeerUserProfile?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    MeerUserProfileInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MeerUserProfile>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MeerUserProfile]s in the list and returns the inserted rows.
  ///
  /// The returned [MeerUserProfile]s will have their `id` fields set.
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
  Future<List<MeerUserProfile>> insert(
    _is.DatabaseSession session,
    List<MeerUserProfile> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<MeerUserProfile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [MeerUserProfile] and returns the inserted row.
  ///
  /// The returned [MeerUserProfile] will have its `id` field set.
  Future<MeerUserProfile> insertRow(
    _is.DatabaseSession session,
    MeerUserProfile row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<MeerUserProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [MeerUserProfile]s in the list and returns the resulting rows.
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
  /// The returned [MeerUserProfile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MeerUserProfile>> upsert(
    _is.DatabaseSession session,
    List<MeerUserProfile> rows, {
    required _is.ColumnSelections<MeerUserProfileTable> conflictColumns,
    _is.ColumnSelections<MeerUserProfileTable>? updateColumns,
    _is.WhereExpressionBuilder<MeerUserProfileTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<MeerUserProfile>(
      rows,
      conflictColumns: conflictColumns(MeerUserProfile.t),
      updateColumns: updateColumns?.call(MeerUserProfile.t),
      updateWhere: updateWhere?.call(MeerUserProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [MeerUserProfile] and returns the resulting row.
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
  /// The returned [MeerUserProfile] will have its `id` field set.
  Future<MeerUserProfile?> upsertRow(
    _is.DatabaseSession session,
    MeerUserProfile row, {
    required _is.ColumnSelections<MeerUserProfileTable> conflictColumns,
    _is.ColumnSelections<MeerUserProfileTable>? updateColumns,
    _is.WhereExpressionBuilder<MeerUserProfileTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<MeerUserProfile>(
      row,
      conflictColumns: conflictColumns(MeerUserProfile.t),
      updateColumns: updateColumns?.call(MeerUserProfile.t),
      updateWhere: updateWhere?.call(MeerUserProfile.t),
      transaction: transaction,
    );
  }

  /// Updates all [MeerUserProfile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MeerUserProfile>> update(
    _is.DatabaseSession session,
    List<MeerUserProfile> rows, {
    _is.ColumnSelections<MeerUserProfileTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<MeerUserProfile>(
      rows,
      columns: columns?.call(MeerUserProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [MeerUserProfile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MeerUserProfile> updateRow(
    _is.DatabaseSession session,
    MeerUserProfile row, {
    _is.ColumnSelections<MeerUserProfileTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<MeerUserProfile>(
      row,
      columns: columns?.call(MeerUserProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MeerUserProfile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MeerUserProfile?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<MeerUserProfileUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<MeerUserProfile>(
      id,
      columnValues: columnValues(MeerUserProfile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MeerUserProfile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MeerUserProfile>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MeerUserProfileUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<MeerUserProfileTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MeerUserProfileTable>? orderBy,
    _is.OrderByListBuilder<MeerUserProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<MeerUserProfile>(
      columnValues: columnValues(MeerUserProfile.t.updateTable),
      where: where(MeerUserProfile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MeerUserProfile.t),
      orderByList: orderByList?.call(MeerUserProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [MeerUserProfile]s in the list and returns the deleted rows.
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
  Future<List<MeerUserProfile>> delete(
    _is.DatabaseSession session,
    List<MeerUserProfile> rows, {
    _is.OrderByBuilder<MeerUserProfileTable>? orderBy,
    _is.OrderByListBuilder<MeerUserProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<MeerUserProfile>(
      rows,
      orderBy: orderBy?.call(MeerUserProfile.t),
      orderByList: orderByList?.call(MeerUserProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [MeerUserProfile].
  Future<MeerUserProfile> deleteRow(
    _is.DatabaseSession session,
    MeerUserProfile row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MeerUserProfile>(
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
  Future<List<MeerUserProfile>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MeerUserProfileTable> where,
    _is.OrderByBuilder<MeerUserProfileTable>? orderBy,
    _is.OrderByListBuilder<MeerUserProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<MeerUserProfile>(
      where: where(MeerUserProfile.t),
      orderBy: orderBy?.call(MeerUserProfile.t),
      orderByList: orderByList?.call(MeerUserProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MeerUserProfileTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<MeerUserProfile>(
      where: where?.call(MeerUserProfile.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MeerUserProfile] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MeerUserProfileTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MeerUserProfile>(
      where: where(MeerUserProfile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class MeerUserProfileAttachRowRepository {
  const MeerUserProfileAttachRowRepository._();

  /// Creates a relation between the given [MeerUserProfile] and [AuthUser]
  /// by setting the [MeerUserProfile]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _is.DatabaseSession session,
    MeerUserProfile meerUserProfile,
    _iacs.AuthUser authUser, {
    _is.Transaction? transaction,
  }) async {
    if (meerUserProfile.id == null) {
      throw ArgumentError.notNull('meerUserProfile.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $meerUserProfile = meerUserProfile.copyWith(authUserId: authUser.id);
    await session.db.updateRow<MeerUserProfile>(
      $meerUserProfile,
      columns: [MeerUserProfile.t.authUserId],
      transaction: transaction,
    );
  }
}

class MeerUserProfileDetachRowRepository {
  const MeerUserProfileDetachRowRepository._();

  /// Detaches the relation between this [MeerUserProfile] and the [AuthUser] set in `authUser`
  /// by setting the [MeerUserProfile]'s foreign key `authUserId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> authUser(
    _is.DatabaseSession session,
    MeerUserProfile meerUserProfile, {
    _is.Transaction? transaction,
  }) async {
    if (meerUserProfile.id == null) {
      throw ArgumentError.notNull('meerUserProfile.id');
    }

    var $meerUserProfile = meerUserProfile.copyWith(authUserId: null);
    await session.db.updateRow<MeerUserProfile>(
      $meerUserProfile,
      columns: [MeerUserProfile.t.authUserId],
      transaction: transaction,
    );
  }
}
