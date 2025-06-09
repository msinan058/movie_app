import 'package:movie_app/core/init/network/network_manager.dart';
import 'package:movie_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:movie_app/core/init/navigation/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInit {
  static Future<void> init() async {
    // Initialize network layer
    await NetworkManager.instance.setup();

    // Initialize SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Check auth status
    final authRepository = AuthRepositoryImpl();
    final isLoggedIn = await authRepository.isLoggedIn;
    final rememberMe = prefs.getBool('remember_me') ?? false;

    // Set initial route based on auth status
    if (isLoggedIn && rememberMe) {
      goRouter.go('/home');
    }
  }
} 