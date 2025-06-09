import 'package:movie_app/core/base/base_response_model.dart';
import 'package:movie_app/core/base/base_service.dart';
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';

class MovieService extends BaseService {
  Future<BaseResponseModel<MovieListResponse>> getMovies({int page = 1}) async {
    return get<MovieListResponse>(
      path: ApiConstants.movieList,
      queryParameters: {'page': page},
      fromJson: (json) => MovieListResponse.fromJson(json['data']),
    );
  }

  Future<BaseResponseModel<MovieFavoritesResponse>> getFavorites() async {
    return get<MovieFavoritesResponse>(
      path: ApiConstants.movieFavorites,
      fromJson: MovieFavoritesResponse.fromJson,
    );
  }

  Future<BaseResponseModel<FavoriteResponse>> addFavorite(String movieId) async {
    return post<FavoriteResponse>(
      path: '${ApiConstants.movieFavorite}/$movieId',
      fromJson: FavoriteResponse.fromJson,
    );
  }
} 