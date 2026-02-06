import '/auth/base_auth_user_provider.dart';

class DemoAuthUser extends BaseAuthUser {
  @override
  bool get loggedIn => true;

  @override
  bool get emailVerified => true;

  @override
  AuthUserInfo get authUserInfo => const AuthUserInfo(
        uid: 'demo_uid_001',
        email: 'demo@knex-app.xyz',
        displayName: 'Alex Sunshine',
        photoUrl: null,
        phoneNumber: '(305) 555-0123',
      );

  @override
  Future? delete() async {}

  @override
  Future? updateEmail(String email) async {}

  @override
  Future? updatePassword(String newPassword) async {}

  @override
  Future? sendEmailVerification() async {}

  @override
  Future refreshUser() async {}
}
