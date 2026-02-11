import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/providers/core_providers.dart';
import '../../data/auth_service.dart';

/// Provider для AuthService.
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.watch(supabaseClientProvider));
});

/// Provider для входа через Google.
final signInWithGoogleProvider = FutureProvider.autoDispose<bool>((ref) async {
  final authService = ref.watch(authServiceProvider);
  return authService.signInWithGoogle();
});

/// Provider для входа через Apple.
final signInWithAppleProvider = FutureProvider.autoDispose<bool>((ref) async {
  final authService = ref.watch(authServiceProvider);
  return authService.signInWithApple();
});

/// Provider для входа по email/password.
final signInWithEmailProvider = FutureProvider.autoDispose
    .family<AuthResponse, ({String email, String password})>((
      ref,
      credentials,
    ) async {
      final authService = ref.watch(authServiceProvider);
      return authService.signInWithEmail(
        email: credentials.email,
        password: credentials.password,
      );
    });

/// Provider для регистрации по email/password.
final signUpWithEmailProvider = FutureProvider.autoDispose
    .family<AuthResponse, ({String email, String password})>((
      ref,
      credentials,
    ) async {
      final authService = ref.watch(authServiceProvider);
      return authService.signUpWithEmail(
        email: credentials.email,
        password: credentials.password,
      );
    });

/// Provider для выхода.
final signOutProvider = FutureProvider.autoDispose<void>((ref) async {
  final authService = ref.watch(authServiceProvider);
  await authService.signOut();
  ref.invalidate(currentUserProvider);
});
