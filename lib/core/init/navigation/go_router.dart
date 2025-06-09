import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:movie_app/features/auth/presentation/views/login_screen.dart';
import 'package:movie_app/features/auth/presentation/views/register_screen.dart';
import 'package:movie_app/features/home/presentation/views/home_screen.dart';
import 'package:movie_app/features/profile/presentation/views/add_profile_photo_screen.dart';
import 'package:movie_app/features/profile/presentation/views/profile_screen.dart';
import 'package:movie_app/features/shell/presentation/views/shell_screen.dart';
import 'package:movie_app/features/splash/presentation/views/splash_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  debugLogDiagnostics: true,
  observers: [
    FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
  ],
  routes: [
    // Splash Screen
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    
    // Auth Routes
    GoRoute(
      path: '/login',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const RegisterScreen(),
    ),

    // Shell Route (contains bottom navigation)
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => ShellScreen(child: child),
      routes: [
        // Home Route
        GoRoute(
          path: '/home',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const HomeScreen(),
        ),
        // Profile Route
        GoRoute(
          path: '/profile',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            final shouldRefresh = extra?['shouldRefresh'] as bool? ?? false;
            return ProfileScreen(shouldRefresh: shouldRefresh);
          },
        ),
      ],
    ),

    // Add Photo Route (outside shell, full screen modal)
    GoRoute(
      path: '/add-photo',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const AddProfilePhotoScreen(),
    ),
  ],
); 