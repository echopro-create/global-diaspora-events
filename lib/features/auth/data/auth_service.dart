import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Сервис авторизации через Supabase.
///
/// Поддерживает Google OAuth, Apple OAuth и Email/Password.
class AuthService {
  AuthService(this._client);

  final SupabaseClient _client;

  /// Текущий пользователь (null если не авторизован).
  User? get currentUser => _client.auth.currentUser;

  /// Стрим изменений состояния авторизации.
  Stream<AuthState> get onAuthStateChange => _client.auth.onAuthStateChange;

  // ─── Google OAuth ───────────────────────────────────────────

  /// Вход через Google OAuth.
  Future<bool> signInWithGoogle() async {
    try {
      return await _client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.gde://login-callback/',
      );
    } catch (e) {
      debugPrint('❌ Google sign-in failed: $e');
      rethrow;
    }
  }

  // ─── Apple OAuth ────────────────────────────────────────────

  /// Вход через Apple OAuth.
  Future<bool> signInWithApple() async {
    try {
      return await _client.auth.signInWithOAuth(
        OAuthProvider.apple,
        redirectTo: 'io.supabase.gde://login-callback/',
      );
    } catch (e) {
      debugPrint('❌ Apple sign-in failed: $e');
      rethrow;
    }
  }

  // ─── Email / Password ──────────────────────────────────────

  /// Регистрация по email/password.
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _client.auth.signUp(email: email, password: password);
    } catch (e) {
      debugPrint('❌ Email sign-up failed: $e');
      rethrow;
    }
  }

  /// Вход по email/password.
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      debugPrint('❌ Email sign-in failed: $e');
      rethrow;
    }
  }

  // ─── Sign Out ──────────────────────────────────────────────

  /// Выход из аккаунта.
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      debugPrint('❌ Sign-out failed: $e');
      rethrow;
    }
  }
}
