# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

IQRA is a Flutter mobile application with Firebase authentication (email/password, Google Sign-In, Apple Sign-In), multi-language support (English/Arabic), and theming (light/dark mode). User preferences persist via SharedPreferences.

## Development Commands

### Running and Building
```bash
# Run app
flutter run

# Build for specific platforms
flutter build apk          # Android
flutter build ios          # iOS
flutter build macos        # macOS

# Clean build artifacts
flutter clean
```

### Testing and Analysis
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Analyze code
flutter analyze
```

### Dependencies and Localization
```bash
# Install/update dependencies
flutter pub get

# Regenerate localization files
flutter gen-l10n
```

Localization config (`l10n.yaml`):
- ARB files: `lib/l10n/app_en.arb`, `lib/l10n/app_ar.arb`
- Generated files: `lib/l10n/app_localizations*.dart` (auto-generated, do not edit)

## Architecture

### Clean Architecture with Feature Modules

The codebase follows Clean Architecture organized by feature modules (e.g., `lib/modules/auth/`). Each module contains three layers:

**1. Domain Layer** (`domain/`)
- `entities/`: Core business objects (e.g., `UserEntity`)
- `repositories/`: Abstract repository interfaces
- `usecases/`: Business logic following the UseCase pattern
- `failures/`: Domain-specific failure types

**2. Infrastructure Layer** (`infrastructure/`)
- `models/`: Data models mapping to/from external sources
- `repositories/`: Concrete repository implementations
- `services/`: External service integrations (e.g., `FirebaseAuthService`)

**3. Presentation Layer** (`presentation/`)
- `bloc/`: BLoC state management (events, states, bloc)
- `pages/`: UI screens

### Dependency Injection (get_it)

All dependencies are registered in `lib/injection.dart`:
- Registration order matters: register dependencies before their dependents
- External dependencies (e.g., SharedPreferences) first
- Core services (LanguageManager, ThemeManager) as lazy singletons
- Feature services and repositories as lazy singletons
- BLoCs as factories (allows multiple instances)

### State Management (BLoC Pattern)

Uses `flutter_bloc` throughout:
- All BLoCs extend `Bloc<Event, State>`
- States use `Equatable` for value comparison
- Global BLoCs provided at app root in `main.dart`:
  - `LocalizationBloc`: Language/locale management
  - `ThemeBloc`: Theme mode management
  - `InternetConnectionBloc`: Network connectivity monitoring
  - `AuthBloc`: Authentication state
- BLoC observer (`IqraBlocObserver`) logs all state transitions

### Core Architecture Patterns

**UseCase Pattern**: All business logic encapsulated in use cases
```dart
abstract class UseCase<Type, Params> {
  FutureOr<Either<Failure, Type>> call(Params params);
}
```

**Error Handling**: Functional approach using `dartz`
- All repository methods return `Either<Failure, Success>`
- Service layer throws domain-specific failures (e.g., `AuthFailure`)
- Repository layer catches exceptions and converts to `Either`

**Managers for Persistence**:
- `LanguageManager` (`core/l10n/`): Persists locale preference
- `ThemeManager` (`core/themes/`): Persists theme mode
- Both use SharedPreferences for storage

### Authentication Flow

1. `AuthBloc` listens to Firebase auth state stream via `SubscribeAuthChanges` use case
2. Auth state changes trigger BLoC state updates
3. `app.dart` conditionally renders based on auth status:
   - No internet → `InternetConnectionPage`
   - Not authenticated → `SignInPage`
   - Authenticated → `AuthDemoPage`
4. All auth actions (sign in, sign up, social auth) flow through:
   - Event → AuthBloc → UseCase → Repository → Service → Firebase

### Firebase Configuration

- Initialized in `main.dart` using `DefaultFirebaseOptions.currentPlatform`
- Platform configs:
  - Android: `android/app/google-services.json`
  - iOS: `ios/GoogleService-Info.plist`
  - Generated options: `configs/firebase_options.dart`

**Apple Sign-In Configuration** (in `FirebaseAuthService`):
- Client ID: `com.iqranetwork.dashboard.authentication.service`
- Redirect URL: `https://auth.iqranetwork.com/__/auth/handler`

### Internet Connection Monitoring

`InternetConnectionBloc` uses dual-layer checking:
1. `connectivity_plus`: Monitors network interface changes
2. `internet_connection_checker`: Validates actual internet connectivity

The bloc subscribes to connectivity changes and emits state based on real internet availability, preventing false positives from network interface changes.

## Project Structure

- Entry point: `lib/main.dart`
- Root app widget: `lib/app.dart`
- Dependency injection: `lib/injection.dart`
- Feature modules: `lib/modules/` (domain + infrastructure + presentation)
- Shared code: `lib/core/` (blocs, themes, l10n, utilities)
- Re-export files: `*.dart` barrel files (e.g., `blocs.dart`, `auth.dart`) for cleaner imports

## Code Conventions

### BLoC Event Naming
- User actions: Use present tense (`SignInRequested`, `SignUpRequested`)
- System actions: Use imperative (`ListenAuthentication`, `ListenConnection`)

### Resource Cleanup
BLoCs that hold subscriptions must override `close()` to cancel them:
```dart
@override
Future<void> close() {
  _subscription?.cancel();
  return super.close();
}
```

### Firebase Error Mapping
`FirebaseAuthService` includes `_mapFirebaseAuthExceptionToMessage()` to convert Firebase error codes to user-friendly messages. Follow this pattern for other Firebase services.
