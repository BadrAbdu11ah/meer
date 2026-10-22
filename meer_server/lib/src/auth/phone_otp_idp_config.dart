import 'package:serverpod_auth_idp_server/core.dart';

import 'phone_otp_idp.dart';

class PhoneOtpIdpConfig extends IdentityProviderBuilder<PhoneOtpIdp> {
  @override
  PhoneOtpIdp build({
    required TokenManager tokenManager,
    required AuthUsers authUsers,
    required UserProfiles userProfiles,
  }) {
    return PhoneOtpIdp(
      tokenIssuer: tokenManager,
      authUsers: authUsers,
    );
  }
}
