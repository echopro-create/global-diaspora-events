import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import '../domain/repositories/auth_repository.dart';
import '../domain/entities/user.dart';
import '../data/supabase_auth_repository.dart';

part 'auth_state_provider.g.dart';

/// Provides the AuthRepository implementation.
@riverpod
AuthRepository authRepository(Ref ref) {
  final supabase = Supabase.instance.client;
  return SupabaseAuthRepository(supabase);
}

/// Provides the current auth state (authenticated user or null).
@riverpod
Stream<User?> authState(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.authStateChanges;
}

/// Auth controller for authentication operations.
@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  /// Signs up a new user.
  Future<void> signUp({
    required String email,
    required String password,
    String? fullName,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.signUp(
        email: email,
        password: password,
        fullName: fullName,
      );
    });
  }

  /// Signs in an existing user.
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.signIn(email: email, password: password);
    });
  }

  /// Signs out the current user.
  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.signOut();
    });
  }

  /// Sends a password reset email.
  Future<void> resetPassword(String email) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      await repository.resetPassword(email);
    });
  }
}
