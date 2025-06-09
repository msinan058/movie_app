import 'package:movie_app/core/base/base_response_model.dart';
import 'package:movie_app/core/base/base_service.dart';
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/core/init/logger/logger_manager.dart';
import 'package:movie_app/core/init/network/network_manager.dart';
import 'package:movie_app/features/auth/data/models/auth_response.dart';
import 'package:movie_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends BaseService implements AuthRepository {
  final _logger = LoggerManager.instance;
  final _networkManager = NetworkManager.instance;

  @override
  Future<BaseResponseModel<AuthResponse>> login(LoginRequest request) async {
    try {
      final response = await post<AuthResponse>(
        path: ApiConstants.login,
        data: request.toJson(),
        fromJson: AuthResponse.fromJson,
      );

      if (response.success && response.data != null) {
        await _networkManager.saveToken(response.data!.token);
      }

      return response;
    } catch (e, stackTrace) {
      _logger.error('Login failed', e, stackTrace);
      return BaseResponseModel.error(message: 'Login failed');
    }
  }

  @override
  Future<BaseResponseModel<AuthResponse>> register(RegisterRequest request) async {
    try {
      final response = await post<AuthResponse>(
        path: ApiConstants.register,
        data: request.toJson(),
        fromJson: AuthResponse.fromJson,
      );

      if (response.success && response.data != null) {
        await _networkManager.saveToken(response.data!.token);
      }

      return response;
    } catch (e, stackTrace) {
      _logger.error('Register failed', e, stackTrace);
      return BaseResponseModel.error(message: 'Register failed');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _networkManager.deleteToken();
    } catch (e, stackTrace) {
      _logger.error('Logout failed', e, stackTrace);
    }
  }

  @override
  Future<bool> get isLoggedIn async {
    final token = await _networkManager.getToken();
    return token != null;
  }

  @override
  Future<String?> get token => _networkManager.getToken();
} 