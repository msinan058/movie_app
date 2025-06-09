import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_app/core/init/network/network_manager.dart';
import 'package:movie_app/core/init/theme/theme_cubit.dart';
import 'package:movie_app/core/init/lang/localization_cubit.dart';
import 'package:movie_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movie_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:movie_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:movie_app/features/home/data/repositories/movie_repository_impl.dart';
import 'package:movie_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:movie_app/features/profile/data/repositories/user_repository_impl.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // External
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerSingleton<FirebaseAnalytics>(FirebaseAnalytics.instance);

  // Network
  getIt.registerSingleton<NetworkManager>(NetworkManager.instance);

  // Repositories
  getIt.registerLazySingleton<AuthRepositoryImpl>(() => AuthRepositoryImpl());
  getIt.registerLazySingleton<MovieRepositoryImpl>(() => MovieRepositoryImpl());
  getIt.registerLazySingleton<UserRepositoryImpl>(() => UserRepositoryImpl());

  // Blocs & Cubits
  getIt.registerFactory(() => AuthBloc());
  getIt.registerFactory(() => HomeBloc(movieRepository: getIt<MovieRepositoryImpl>()));
  getIt.registerFactory(() => ProfileBloc(
    userRepository: getIt<UserRepositoryImpl>(),
    movieRepository: getIt<MovieRepositoryImpl>(),
  ));
  getIt.registerFactory(() => LocalizationCubit(getIt<SharedPreferences>()));
  getIt.registerFactory(() => ThemeCubit(getIt<SharedPreferences>()));
} 