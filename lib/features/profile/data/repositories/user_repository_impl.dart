import 'package:movie_app/core/base/base_response_model.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';
import 'package:movie_app/features/profile/data/datasources/user_service.dart';
import 'package:movie_app/features/profile/data/models/photo_response.dart';
import 'package:movie_app/features/profile/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService _userService;

  UserRepositoryImpl({UserService? userService})
      : _userService = userService ?? UserService();

  @override
  Future<BaseResponseModel<UserModel>> getProfile() {
    return _userService.getProfile();
  }

  @override
  Future<BaseResponseModel<PhotoUploadResponse>> uploadPhoto(String filePath) {
    return _userService.uploadPhoto(filePath);
  }
} 