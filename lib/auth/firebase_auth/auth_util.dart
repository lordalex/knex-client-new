
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_auth_manager.dart';
import '/demo/demo_config.dart';

export 'firebase_auth_manager.dart';

final _authManager = FirebaseAuthManager();
FirebaseAuthManager get authManager => _authManager;

String get currentUserEmail =>
    DemoConfig.isDemo ? 'demo@knex-app.xyz' : (currentUser?.email ?? '');

String get currentUserUid =>
    DemoConfig.isDemo ? 'demo_uid_001' : (currentUser?.uid ?? '');

String get currentUserDisplayName => currentUser?.displayName ?? '';

String get currentUserPhoto => currentUser?.photoUrl ?? '';

String get currentPhoneNumber => currentUser?.phoneNumber ?? '';

String get currentJwtToken =>
    DemoConfig.isDemo ? 'demo_jwt_token' : (_currentJwtToken ?? '');

bool get currentUserEmailVerified => currentUser?.emailVerified ?? false;

/// Create a Stream that listens to the current user's JWT Token, since Firebase
/// generates a new token every hour.
String? _currentJwtToken;
final jwtTokenStream = DemoConfig.isDemo
    ? Stream.value('demo_jwt_token').asBroadcastStream()
    : FirebaseAuth.instance
        .idTokenChanges()
        .map((user) async => _currentJwtToken = await user?.getIdToken())
        .asBroadcastStream();
