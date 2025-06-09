import 'package:movie_app/core/base/base_response_model.dart';
import 'package:movie_app/features/auth/data/models/auth_response.dart';

abstract class AuthRepository {
  Future<BaseResponseModel<AuthResponse>> login(LoginRequest request);
  Future<BaseResponseModel<AuthResponse>> register(RegisterRequest request);
  Future<void> logout();
  Future<bool> get isLoggedIn;
  Future<String?> get token;
} 