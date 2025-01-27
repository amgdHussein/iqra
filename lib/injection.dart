import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/l10n/localization_manager.dart';
import 'core/themes/theme_manager.dart';
import 'modules/auth/auth.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // * External
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // * Core
  getIt.registerLazySingleton<LanguageManager>(() => LanguageManager(getIt<SharedPreferences>()));
  getIt.registerLazySingleton<ThemeManager>(() => ThemeManager(getIt<SharedPreferences>()));

  // * Features

  // ? Auth

  // Services
  getIt.registerLazySingleton<AuthService>(() => FirebaseAuthService());

  // Repository
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(service: getIt<AuthService>()));

  // UseCases
  getIt.registerLazySingleton<SignUpWithEmail>(() => SignUpWithEmail(repository: getIt<AuthRepository>()));
  getIt.registerLazySingleton<SignInWithEmail>(() => SignInWithEmail(repository: getIt<AuthRepository>()));
  getIt.registerLazySingleton<SignInWithGoogle>(() => SignInWithGoogle(repository: getIt<AuthRepository>()));
  getIt.registerLazySingleton<SignOut>(() => SignOut(repository: getIt<AuthRepository>()));
  getIt.registerLazySingleton<SubscribeAuthChanges>(() => SubscribeAuthChanges(repository: getIt<AuthRepository>()));

  // Blocs
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      subscribeAuthChanges: getIt<SubscribeAuthChanges>(),
      signUpWithEmail: getIt<SignUpWithEmail>(),
      signInWithEmail: getIt<SignInWithEmail>(),
      signInWithGoogle: getIt<SignInWithGoogle>(),
      signOut: getIt<SignOut>(),
    ),
  );
}
