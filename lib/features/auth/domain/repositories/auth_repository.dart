import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:global_diaspora_events/core/error/failure.dart';

abstract class AuthRepository {
  Stream<User?> get authStateChanges;
  User? get currentUser;
  Future<Either<Failure, AuthResponse>> signInWithEmail({
    required String email,
    required String password,
  });
  Future<Either<Failure, AuthResponse>> signUpWithEmail({
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> signInWithGoogle();
  Future<Either<Failure, void>> signInWithApple();
  Future<Either<Failure, void>> signOut();
}
