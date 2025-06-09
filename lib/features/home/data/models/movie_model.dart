import 'package:equatable/equatable.dart';

class MovieModel extends Equatable {
  final String? id;
  final String? title;
  final String? year;
  final String? rated;
  final String? released;
  final String? runtime;
  final String? genre;
  final String? director;
  final String? writer;
  final String? actors;
  final String? description;
  final String? language;
  final String? country;
  final String? awards;
  final String? posterUrl;
  final String? metascore;
  final String? imdbRating;
  final String? imdbVotes;
  final String? imdbId;
  final String? type;
  final List<String>? images;
  final bool? comingSoon;
  final bool? isFavorite;

  const MovieModel({
    this.id,
    this.title,
    this.year,
    this.rated,
    this.released,
    this.runtime,
    this.genre,
    this.director,
    this.writer,
    this.actors,
    this.description,
    this.language,
    this.country,
    this.awards,
    this.posterUrl,
    this.metascore,
    this.imdbRating,
    this.imdbVotes,
    this.imdbId,
    this.type,
    this.images,
    this.comingSoon,
    this.isFavorite,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['_id']?.toString(),
      title: json['Title']?.toString(),
      year: json['Year']?.toString(),
      rated: json['Rated']?.toString(),
      released: json['Released']?.toString(),
      runtime: json['Runtime']?.toString(),
      genre: json['Genre']?.toString(),
      director: json['Director']?.toString(),
      writer: json['Writer']?.toString(),
      actors: json['Actors']?.toString(),
      description: json['Plot']?.toString(),
      language: json['Language']?.toString(),
      country: json['Country']?.toString(),
      awards: json['Awards']?.toString(),
      posterUrl: json['Poster']?.toString(),
      metascore: json['Metascore']?.toString(),
      imdbRating: json['imdbRating']?.toString(),
      imdbVotes: json['imdbVotes']?.toString(),
      imdbId: json['imdbID']?.toString(),
      type: json['Type']?.toString(),
      images: (json['Images'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      comingSoon: json['ComingSoon'] as bool?,
      isFavorite: json['isFavorite'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'Title': title,
      'Year': year,
      'Rated': rated,
      'Released': released,
      'Runtime': runtime,
      'Genre': genre,
      'Director': director,
      'Writer': writer,
      'Actors': actors,
      'Plot': description,
      'Language': language,
      'Country': country,
      'Awards': awards,
      'Poster': posterUrl,
      'Metascore': metascore,
      'imdbRating': imdbRating,
      'imdbVotes': imdbVotes,
      'imdbID': imdbId,
      'Type': type,
      'Images': images,
      'ComingSoon': comingSoon,
      'isFavorite': isFavorite,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        year,
        rated,
        released,
        runtime,
        genre,
        director,
        writer,
        actors,
        description,
        language,
        country,
        awards,
        posterUrl,
        metascore,
        imdbRating,
        imdbVotes,
        imdbId,
        type,
        images,
        comingSoon,
        isFavorite,
      ];
}

class MovieListResponse extends Equatable {
  final List<MovieModel> movies;
  final int currentPage;
  final int totalPages;

  const MovieListResponse({
    required this.movies,
    required this.currentPage,
    required this.totalPages,
  });

 factory MovieListResponse.fromJson(Map<String, dynamic> json) {
  final pagination = json['pagination'] as Map<String, dynamic>? ?? {};

  return MovieListResponse(
    movies: (json['movies'] as List<dynamic>)
        .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    currentPage: pagination['currentPage'] ?? 1,
    totalPages: pagination['maxPage'] ?? 1,
  );
}


  Map<String, dynamic> toJson() {
    return {
      'movies': movies.map((e) => e.toJson()).toList(),
      'currentPage': currentPage,
      'totalPages': totalPages,
    };
  }

  @override
  List<Object?> get props => [movies, currentPage, totalPages];
}

class MovieFavoritesResponse extends Equatable {
  final List<MovieModel> movies;

  const MovieFavoritesResponse({
    required this.movies,
  });

  factory MovieFavoritesResponse.fromJson(Map<String, dynamic> json) {
    return MovieFavoritesResponse(
      movies: (json['data'] as List<dynamic>? ?? [])
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': movies.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [movies];
}

class FavoriteResponse extends Equatable {
  final int code;
  final String message;
  final String action;

  const FavoriteResponse({
    required this.code,
    required this.message,
    required this.action,
  });

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteResponse(
      code: json['response']?['code'] ?? 0,
      message: json['response']?['message'] ?? '',
      action: json['data']?['action'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'response': {
        'code': code,
        'message': message,
      },
      'data': {
        'action': action,
      }
    };
  }

  @override
  List<Object?> get props => [code, message, action];
} 