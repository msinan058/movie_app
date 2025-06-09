import 'package:movie_app/core/base/base_response_model.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';

abstract class MovieRepository {
  Future<BaseResponseModel<MovieListResponse>> getMovies({int page = 1});
  Future<BaseResponseModel<MovieFavoritesResponse>> getFavorites();
  Future<BaseResponseModel<FavoriteResponse>> addFavorite(String movieId);
} 