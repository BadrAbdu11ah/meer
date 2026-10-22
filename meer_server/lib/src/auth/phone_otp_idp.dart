import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:meer_server/src/generated/protocol.dart';

class PhoneOtpIdp implements IdentityProvider {
  final TokenIssuer _tokenIssuer;
  final AuthUsers _authUsers;

  PhoneOtpIdp({
    required this._tokenIssuer,
    required this._authUsers,
  });

  @override
  String get method => 'phone_otp';

  Future<AuthSuccess> login(
    Session session, {
    required String phone,
  }) async {
    return DatabaseUtil.runInTransactionOrSavepoint(
      session.db,
      null,
      (transaction) async {
        // 1. البحث عن حساب المصادقة المرتبط بهذا الرقم.
        final account = await PhoneAuthAccount.db.findFirstRow(
          session,
          where: (t) => t.phone.equals(phone),
          transaction: transaction,
        );

        // 2. البحث عن سجل المستخدم التجاري في مِيْر.
        var appUser = await User.db.findFirstRow(
          session,
          where: (t) => t.phone.equals(phone),
          transaction: transaction,
        );

        late final AuthUserModel authUser;

        if (account != null) {
          // الرقم مسجل سابقًا: استرجاع حساب Serverpod نفسه.
          final authUserId = account.authUserId;

          authUser = await _authUsers.get(
            session,
            authUserId: authUserId,
            transaction: transaction,
          );

          if (authUser.blocked) {
            throw StateError('هذا الحساب محظور.');
          }

          // منع ربط سجل مِيْر بحساب مصادقة مختلف دون إجراء ربط صريح.
          if (appUser?.authUserId != null &&
              appUser!.authUserId != authUser.id) {
            throw StateError(
              'رقم الهاتف مرتبط بحساب آخر. '
              'سجّل الدخول بطريقة الحساب المرتبط أولًا.',
            );
          }
        } else {
          // لا نربط تلقائيًا رقم هاتف بحساب Google موجود
          // اعتمادًا على رقم الهاتف وحده في جدول User.
          if (appUser?.authUserId != null) {
            throw StateError(
              'يوجد حساب مرتبط بطريقة دخول أخرى. '
              'يجب ربط رقم الهاتف بالحساب صراحةً.',
            );
          }

          // 3. إنشاء حساب المصادقة الحديث عند أول تسجيل.
          authUser = await _authUsers.create(
            session,
            transaction: transaction,
          );

          // 4. حفظ الربط بين رقم الهاتف وحساب المصادقة.
          await PhoneAuthAccount.db.insertRow(
            session,
            PhoneAuthAccount(
              authUserId: authUser.id,
              phone: phone,
              createdAt: DateTime.now().toUtc(),
            ),
            transaction: transaction,
          );
        }

        // 5. إنشاء سجل مِيْر أو ربط السجل القديم بالحساب.
        if (appUser == null) {
          appUser = User(
            authUserId: authUser.id,
            phone: phone,
            fullName: 'مستخدم $phone',
            role: 'customer',
            createdAt: DateTime.now().toUtc(),
          );

          await User.db.insertRow(
            session,
            appUser,
            transaction: transaction,
          );
        } else if (appUser.authUserId == null) {
          appUser.authUserId = authUser.id;

          await User.db.updateRow(
            session,
            appUser,
            transaction: transaction,
          );
        }

        // 6. إصدار الجلسة باستخدام مدير الرموز الحديث.
        return _tokenIssuer.issueToken(
          session,
          authUserId: authUser.id,
          method: method,
          scopes: authUser.scopes,
          transaction: transaction,
        );
      },
    );
  }

  @override
  Future<void> mergeAuthUsers(
    Session session, {
    required UuidValue userToKeepId,
    required UuidValue userToRemoveId,
    required Transaction transaction,
  }) async {
    await PhoneAuthAccount.db.updateWhere(
      session,
      where: (t) => t.authUserId.equals(userToRemoveId),
      columnValues: (t) => [
        t.authUserId(userToKeepId),
      ],
      transaction: transaction,
    );

    await User.db.updateWhere(
      session,
      where: (t) => t.authUserId.equals(userToRemoveId),
      columnValues: (t) => [
        t.authUserId(userToKeepId),
      ],
      transaction: transaction,
    );
  }
}
