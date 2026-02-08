import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

class AuthService {
  final SupabaseClient _supabase;

  AuthService(this._supabase);

  Session? get currentSession => _supabase.auth.currentSession;
  User? get currentUser => _supabase.auth.currentUser;
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': fullName},
    );
    return response;
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  Future<void> updateProfile({
    String? fullName,
    String? originCountry,
    String? avatarUrl,
    bool? spotifyConnected,
    Map<String, dynamic>? location,
  }) async {
    final user = currentUser;
    if (user == null) throw Exception('User not logged in');

    final updates = {
      'full_name': ?fullName,
      'origin_country': ?originCountry,
      'avatar_url': ?avatarUrl,
      'spotify_connected': ?spotifyConnected,
      'current_location': ?location,
      'updated_at': DateTime.now().toIso8601String(),
    };

    await _supabase.from('profiles').update(updates).eq('id', user.id);
  }

  Future<void> signInWithSpotify() async {
    await _supabase.auth.signInWithOAuth(
      OAuthProvider.spotify,
      redirectTo: 'global-diaspora-events://login-callback',
    );
  }
}

@riverpod
AuthService authService(Ref ref) {
  return AuthService(Supabase.instance.client);
}
