import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/exceptions/auth_exception.dart';

/// Supabase implementation of [AuthRepository].
class SupabaseAuthRepository implements AuthRepository {
  final sb.SupabaseClient _supabase;

  SupabaseAuthRepository(this._supabase);

  @override
  Future<User> signUp({
    required String email,
    required String password,
    String? fullName,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: fullName != null ? {'full_name': fullName} : null,
      );

      if (response.user == null) {
        throw const UnknownAuthException('Sign up failed');
      }

      // Create user profile in database
      await _supabase.from('users').insert({
        'id': response.user!.id,
        'email': email,
        'full_name': fullName,
      });

      return _mapAuthUserToUser(response.user!);
    } on sb.AuthException catch (e) {
      throw _mapAuthException(e);
    } catch (e) {
      throw UnknownAuthException(e.toString());
    }
  }

  @override
  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw const InvalidCredentialsException();
      }

      return _mapAuthUserToUser(response.user!);
    } on sb.AuthException catch (e) {
      throw _mapAuthException(e);
    } catch (e) {
      throw UnknownAuthException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } on sb.AuthException catch (e) {
      throw _mapAuthException(e);
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } on sb.AuthException catch (e) {
      throw _mapAuthException(e);
    }
  }

  @override
  Stream<User?> get authStateChanges {
    return _supabase.auth.onAuthStateChange.map((event) {
      final user = event.session?.user;
      return user != null ? _mapAuthUserToUser(user) : null;
    });
  }

  @override
  Future<User?> getCurrentUser() async {
    final user = _supabase.auth.currentUser;
    return user != null ? _mapAuthUserToUser(user) : null;
  }

  /// Maps Supabase AuthUser to domain User entity.
  User _mapAuthUserToUser(sb.User authUser) {
    return User(
      id: authUser.id,
      email: authUser.email ?? '',
      fullName: authUser.userMetadata?['full_name'] as String?,
      createdAt: authUser.createdAt != null
          ? DateTime.parse(authUser.createdAt)
          : null,
    );
  }

  /// Maps Supabase AuthException to domain AuthException.
  AuthException _mapAuthException(sb.AuthException e) {
    final message = e.message.toLowerCase();

    if (message.contains('invalid') || message.contains('credentials')) {
      return const InvalidCredentialsException();
    }
    if (message.contains('already') || message.contains('exists')) {
      return const EmailAlreadyInUseException();
    }
    if (message.contains('weak') || message.contains('password')) {
      return const WeakPasswordException();
    }
    if (message.contains('not found')) {
      return const UserNotFoundException();
    }
    if (message.contains('network')) {
      return const NetworkException();
    }

    return UnknownAuthException(e.message);
  }
}
