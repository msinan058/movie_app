import 'package:movie_app/core/base/base_response_model.dart';
import 'package:movie_app/core/base/base_service.dart';
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/features/auth/data/models/auth_response.dart';

class AuthService extends BaseService {
  Future<BaseResponseModel<AuthResponse>> login(LoginRequest request) async {
    return post<AuthResponse>(
      path: ApiConstants.login,
      data: request.toJson(),
      fromJson: AuthResponse.fromJson,
    );
  }

  Future<BaseResponseModel<AuthResponse>> register(RegisterRequest request) async {
    return post<AuthResponse>(
      path: ApiConstants.register,
      data: request.toJson(),
      fromJson: AuthResponse.fromJson,
    );
  }
} 