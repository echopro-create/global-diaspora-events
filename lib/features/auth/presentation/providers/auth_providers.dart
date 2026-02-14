import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:global_diaspora_events/features/auth/domain/repositories/auth_repository.dart';
import 'package:global_diaspora_events/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:global_diaspora_events/features/events/presentation/providers/event_providers.dart';

part 'auth_providers.g.dart';

@riverpod
GoogleSignIn googleSignIn(GoogleSignInRef ref) {
  return GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly'],
  );
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final client = ref.watch(supabaseClientProvider);
  final google = ref.watch(googleSignInProvider);
  return AuthRepositoryImpl(client, google);
}

@riverpod
Stream<User?> authStateChanges(AuthStateChangesRef ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
}

@riverpod
User? currentUser(CurrentUserRef ref) {
  return ref.watch(authRepositoryProvider).currentUser;
}
