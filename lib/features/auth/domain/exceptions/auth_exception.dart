/// Base class for authentication exceptions.
sealed class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Invalid email or password.
class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException() : super('Invalid email or password');
}

/// Email already in use.
class EmailAlreadyInUseException extends AuthException {
  const EmailAlreadyInUseException() : super('Email already in use');
}

/// Weak password.
class WeakPasswordException extends AuthException {
  const WeakPasswordException()
      : super('Password is too weak. Use at least 8 characters');
}

/// User not found.
class UserNotFoundException extends AuthException {
  const UserNotFoundException() : super('User not found');
}

/// Network error.
class NetworkException extends AuthException {
  const NetworkException()
      : super('Network error. Please check your connection');
}

/// Unknown error.
class UnknownAuthException extends AuthException {
  const UnknownAuthException([String? details])
      : super(details ?? 'An unknown error occurred');
}
