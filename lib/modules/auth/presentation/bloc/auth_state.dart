part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class AuthState extends Equatable {
  final AuthStatus status;
  const AuthState({required this.status});

  factory AuthState.initial() {
    return const AuthState(status: AuthStatus.initial);
  }

  factory AuthState.change({required status}) {
    return AuthState(status: status);
  }

  @override
  String toString() => 'AuthState(status: $status)';

  @override
  List<Object> get props => [status];
}

// If any error occurs the state is changed to AuthError.
class AuthError extends AuthState {
  final String error;

  const AuthError({required super.status, required this.error});

  @override
  String toString() => 'AuthState(status: $status, error: $error)';

  @override
  List<Object> get props => [status, error];
}
