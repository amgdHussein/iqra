import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/domain.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SubscribeAuthChanges subscribeAuthChanges;
  final SignInWithEmail signInWithEmail;
  final SignUpWithEmail signUpWithEmail;
  final SignInWithGoogle signInWithGoogle;
  final SignInWithApple signInWithApple;
  final SignOut signOut;

  AuthBloc({
    required this.subscribeAuthChanges,
    required this.signInWithEmail,
    required this.signUpWithEmail,
    required this.signInWithGoogle,
    required this.signInWithApple,
    required this.signOut,
  }) : super(AuthState.initial()) {
    // When the Bloc is first created, we will listen to the authentication state changes and emit the appropriate states
    on<ListenAuthentication>((event, emit) async {
      emit(AuthState(status: AuthStatus.loading)); // Emit the Loading State

      final result = subscribeAuthChanges();

      return result.fold(
        (failure) => emit(AuthError(status: AuthStatus.error, error: failure.message)),
        (stream) => emit.forEach<User?>(
          stream,
          onData: (user) {
            if (user != null) {
              // User is authenticated
              return AuthState(status: AuthStatus.authenticated);
            } else {
              // User is unauthenticated
              return AuthState(status: AuthStatus.unauthenticated);
            }
          },
          onError: (error, _) {
            if (error is AuthFailure) {
              return AuthError(status: AuthStatus.error, error: error.message);
            }

            return AuthError(status: AuthStatus.error, error: 'Unknown error occurred.');
          },
        ),
      );
    });

    // When User Presses the SignIn Button, we will send the SignInRequested Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated
    on<SignInRequested>((event, emit) async {
      emit(AuthState(status: AuthStatus.loading));

      final result = await signInWithEmail(SignInParams(email: event.email, password: event.password));

      return result.fold(
        (failure) => emit(AuthError(status: AuthStatus.error, error: failure.message)),
        (user) => emit(AuthState(status: AuthStatus.authenticated)),
      );
    });

    // When User Presses the SignUp Button, we will send the SignUpRequest Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated
    on<SignUpRequested>((event, emit) async {
      emit(AuthState(status: AuthStatus.loading));

      final result = await signUpWithEmail(SignUpParams(email: event.email, password: event.password));

      return result.fold(
        (failure) => emit(AuthError(status: AuthStatus.error, error: failure.message)),
        (user) => emit(AuthState(status: AuthStatus.authenticated)),
      );
    });

    // When User Presses the Google Login Button, we will send the GoogleSignInRequest Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated
    on<GoogleSignInRequested>((event, emit) async {
      emit(AuthState(status: AuthStatus.loading));

      final result = await signInWithGoogle();

      return result.fold(
        (failure) => emit(AuthError(status: AuthStatus.error, error: failure.message)),
        (user) => emit(AuthState(status: AuthStatus.authenticated)),
      );
    });

    // When User Presses the Apple Login Button, we will send the AppleSignInRequest Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated
    on<AppleSignInRequested>((event, emit) async {
      emit(AuthState(status: AuthStatus.loading));

      final result = await signInWithApple();

      return result.fold(
        (failure) => emit(AuthError(status: AuthStatus.error, error: failure.message)),
        (user) => emit(AuthState(status: AuthStatus.authenticated)),
      );
    });

    // When User Presses the SignOut Button, we will send the SignOutRequested Event to the AuthBloc to handle it and emit the UnAuthenticated State
    on<SignOutRequested>((event, emit) async {
      emit(AuthState(status: AuthStatus.loading));

      final result = await signOut();

      return result.fold(
        (failure) => emit(AuthError(status: AuthStatus.error, error: failure.message)),
        (_) => emit(AuthState(status: AuthStatus.unauthenticated)),
      );
    });
  }
}
