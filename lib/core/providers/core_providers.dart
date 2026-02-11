import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Core provider — Supabase client singleton.
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

/// Provider для текущего auth-пользователя (null если не авторизован).
///
/// Реактивно обновляется при любом изменении auth state
/// (login, logout, token refresh).
final currentUserProvider = Provider<User?>((ref) {
  // Подписыемся на стрим — при любом изменении провайдер пересчитается
  ref.watch(authStateProvider);
  return Supabase.instance.client.auth.currentUser;
});

/// Stream-provider для изменений auth state.
final authStateProvider = StreamProvider<AuthState>((ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
});
