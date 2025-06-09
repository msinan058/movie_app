import 'package:dio/dio.dart';
import 'package:movie_app/core/base/base_response_model.dart';
import 'package:movie_app/core/base/base_service.dart';
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/features/profile/data/models/photo_response.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';

class UserService extends BaseService {
  Future<BaseResponseModel<UserModel>> getProfile() async {
    return get<UserModel>(
      path: ApiConstants.profile,
      fromJson: (json) => UserModel.fromJson(json['data']),
    );
  }

  Future<BaseResponseModel<PhotoUploadResponse>> uploadPhoto(String filePath) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
    });

    return post<PhotoUploadResponse>(
      path: ApiConstants.uploadPhoto,
      data: formData,
      fromJson: PhotoUploadResponse.fromJson,
    );
  }
} 