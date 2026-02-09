import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

class AuthService {
  final SupabaseClient _supabase;

  AuthService(this._supabase);

  Session? get currentSession => _supabase.auth.currentSession;
  User? get currentUser => _supabase.auth.currentUser;
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  // Local mock storage for offline mode
  final Map<String, dynamic> _localProfile = {};

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
    final Map<String, dynamic> updates = {
      'full_name': fullName,
      'origin_country': originCountry,
      'avatar_url': avatarUrl,
      'spotify_connected': spotifyConnected,
      'current_location': location,
      'updated_at': DateTime.now().toIso8601String(),
    };
    updates.removeWhere((key, value) => value == null);

    // Update local mock profile
    _localProfile.addAll(updates);

    final user = currentUser;
    if (user != null) {
      try {
        await _supabase.from('profiles').update(updates).eq('id', user.id);
      } catch (e) {
        // Ignore Supabase errors in offline mode
        debugPrint('Offline mode: Profile updated locally only. Error: $e');
      }
    } else {
      debugPrint('Offline mode: User is null, profile updated locally only.');
    }
  }

  Future<void> signInWithSpotify() async {
    await _supabase.auth.signInWithOAuth(
      OAuthProvider.spotify,
      redirectTo: 'global-diaspora-events://login-callback',
    );
  }

  Future<AuthResponse?> signInAnonymously() async {
    try {
      return await _supabase.auth.signInAnonymously();
    } catch (e) {
      debugPrint('Offline mode: Anonymous sign-in failed/skipped. Error: $e');
      return null; // Return null to indicate offline mode
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    final user = currentUser;
    if (user != null) {
      try {
        final data = await _supabase
            .from('profiles')
            .select()
            .eq('id', user.id)
            .single();
        // Update local cache
        _localProfile.addAll(data);
        return data;
      } catch (e) {
        debugPrint('Offline mode: Fetching local profile. Error: $e');
      }
    }
    return _localProfile;
  }
}

@riverpod
AuthService authService(Ref ref) {
  return AuthService(Supabase.instance.client);
}

@riverpod
Future<Map<String, dynamic>> userProfile(Ref ref) async {
  return ref.watch(authServiceProvider).getProfile();
}
