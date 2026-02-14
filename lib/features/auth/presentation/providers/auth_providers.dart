import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:global_diaspora_events/features/auth/domain/repositories/auth_repository.dart';
import 'package:global_diaspora_events/features/auth/data/repositories/auth_repository_impl.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
GoogleSignIn googleSignIn(Ref ref) {
  return GoogleSignIn.instance;
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  final client = Supabase.instance.client;
  final google = ref.watch(googleSignInProvider);
  return AuthRepositoryImpl(client, google);
}

@riverpod
Stream<User?> authStateChanges(Ref ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
}

@riverpod
User? currentUser(Ref ref) {
  return ref.watch(authRepositoryProvider).currentUser;
}
