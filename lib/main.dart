import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_app/core/init/navigation/go_router.dart';
import 'package:movie_app/core/init/theme/app_theme.dart';
import 'package:movie_app/core/init/theme/theme_cubit.dart';
import 'package:movie_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movie_app/core/init/lang/localization_cubit.dart';
import 'package:movie_app/core/init/lang/app_localizations.dart';
import 'package:movie_app/core/init/di/injection_container.dart' as di;
import 'package:movie_app/core/init/firebase/firebase_init.dart';
import 'package:movie_app/core/init/app/app_init.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await FirebaseInit.init();

  // Initialize App
  await AppInit.init();

  // Setup Dependencies
  await di.setupDependencies();

  // Configure CachedNetworkImage
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  PaintingBinding.instance.imageCache.maximumSizeBytes = 200 * 1024 * 1024; // 200 MB
  PaintingBinding.instance.imageCache.maximumSize = 1000; // Maximum number of images to cache

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.getIt<AuthBloc>()),
        BlocProvider(create: (context) => di.getIt<LocalizationCubit>()),
        BlocProvider(create: (context) => di.getIt<ThemeCubit>()),
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<LocalizationCubit, Locale>(
            builder: (context, locale) {
              return BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, themeMode) {
                  return MaterialApp.router(
                    title: 'Movie App',
                    theme: AppTheme.instance.lightTheme,
                    darkTheme: AppTheme.instance.darkTheme,
                    themeMode: themeMode,
                    routerConfig: goRouter,
                    debugShowCheckedModeBanner: false,
                    locale: locale,
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('en'),
                      Locale('tr'),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
