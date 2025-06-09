import 'package:movie_app/core/base/base_response_model.dart';
import 'package:movie_app/features/home/data/datasources/movie_service.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';
import 'package:movie_app/features/home/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieService _movieService;

  MovieRepositoryImpl({MovieService? movieService}) 
      : _movieService = movieService ?? MovieService();

  @override
  Future<BaseResponseModel<MovieListResponse>> getMovies({int page = 1}) {
    return _movieService.getMovies(page: page);
  }

  @override
  Future<BaseResponseModel<MovieFavoritesResponse>> getFavorites() {
    return _movieService.getFavorites();
  }

  @override
  Future<BaseResponseModel<FavoriteResponse>> addFavorite(String movieId) {
    return _movieService.addFavorite(movieId);
  }
} 