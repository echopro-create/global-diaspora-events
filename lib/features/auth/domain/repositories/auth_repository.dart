import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/user.dart';

/// Authentication repository interface.
///
/// Defines contracts for authentication operations using Supabase.
abstract class AuthRepository {
  /// Signs up a new user with email and password.
  Future<User> signUp({
    required String email,
    required String password,
    String? fullName,
  });

  /// Signs in an existing user with email and password.
  Future<User> signIn({
    required String email,
    required String password,
  });

  /// Signs out the current user.
  Future<void> signOut();

  /// Sends a password reset email.
  Future<void> resetPassword(String email);

  /// Stream of auth state changes.
  ///
  /// Emits the current user when authenticated, or null when not.
  Stream<User?> get authStateChanges;

  /// Gets the current authenticated user.
  Future<User?> getCurrentUser();
}

/// Provider for AuthRepository.
///
/// Will be overridden with the actual implementation in the data layer.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  throw UnimplementedError('AuthRepository must be overridden');
});
