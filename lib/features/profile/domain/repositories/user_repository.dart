import 'package:movie_app/core/base/base_response_model.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';
import 'package:movie_app/features/profile/data/models/photo_response.dart';

abstract class UserRepository {
  Future<BaseResponseModel<UserModel>> getProfile();
  Future<BaseResponseModel<PhotoUploadResponse>> uploadPhoto(String filePath);
} 