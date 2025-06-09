class ApiConstants {
  ApiConstants._();

  // Base URL
  static const String baseUrl = 'https://caseapi.servicelabs.tech';

  // Auth Endpoints
  static const String login = '/user/login';
  static const String register = '/user/register';
  static const String profile = '/user/profile';
  static const String uploadPhoto = '/user/upload_photo';

  // Movie Endpoints
  static const String movieList = '/movie/list';
  static const String movieFavorites = '/movie/favorites';
  static const String movieFavorite = '/movie/favorite'; // Append /{favoriteId}

} 