import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:global_diaspora_events/core/error/failure.dart';
import 'package:global_diaspora_events/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _client;
  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl(this._client, this._googleSignIn);

  @override
  Stream<User?> get authStateChanges =>
      _client.auth.onAuthStateChange.map((event) => event.session?.user);

  @override
  User? get currentUser => _client.auth.currentUser;

  @override
  Future<Either<Failure, AuthResponse>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return right(response);
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
      );
      return right(response);
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null)
        return left(const AuthFailure('Google sign in cancelled'));

      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null || idToken == null) {
        return left(
          const AuthFailure('Missing idToken or accessToken from Google'),
        );
      }

      await _client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
      return right(null);
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signInWithApple() async {
    // Apple sign in typically requires native implementation details
    // For now, we'll use the Supabase standard OAuth flow or placeholder
    try {
      await _client.auth.signInWithOAuth(OAuthProvider.apple);
      return right(null);
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await Future.wait([_client.auth.signOut(), _googleSignIn.signOut()]);
      return right(null);
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }
}
