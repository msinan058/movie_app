import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';
import 'package:movie_app/features/home/domain/repositories/movie_repository.dart';
import 'package:movie_app/features/home/data/repositories/movie_repository_impl.dart';

// Events
abstract class HomeEvent {}

class LoadMovies extends HomeEvent {}

class LoadMoreMovies extends HomeEvent {}

class UpdateScrollPosition extends HomeEvent {
  final int index;

  UpdateScrollPosition(this.index);
}

class ToggleFavorite extends HomeEvent {
  final String movieId;
  final int movieIndex;

  ToggleFavorite(this.movieId, this.movieIndex);
}

// States
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<MovieModel> movies;
  final bool hasReachedEnd;
  final int currentPage;
  final int currentIndex;
  final bool isLoadingMore;

  HomeLoaded({
    required this.movies,
    required this.hasReachedEnd,
    required this.currentPage,
    this.currentIndex = 0,
    this.isLoadingMore = false,
  });

  HomeLoaded copyWith({
    List<MovieModel>? movies,
    bool? hasReachedEnd,
    int? currentPage,
    int? currentIndex,
    bool? isLoadingMore,
  }) {
    return HomeLoaded(
      movies: movies ?? this.movies,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      currentPage: currentPage ?? this.currentPage,
      currentIndex: currentIndex ?? this.currentIndex,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  HomeLoaded updateMovieFavoriteStatus(int index, bool isFavorite) {
    final updatedMovies = List<MovieModel>.from(movies);
    final movie = updatedMovies[index];
    updatedMovies[index] = MovieModel(
      id: movie.id,
      title: movie.title,
      year: movie.year,
      rated: movie.rated,
      released: movie.released,
      runtime: movie.runtime,
      genre: movie.genre,
      director: movie.director,
      writer: movie.writer,
      actors: movie.actors,
      description: movie.description,
      language: movie.language,
      country: movie.country,
      awards: movie.awards,
      posterUrl: movie.posterUrl,
      metascore: movie.metascore,
      imdbRating: movie.imdbRating,
      imdbVotes: movie.imdbVotes,
      imdbId: movie.imdbId,
      type: movie.type,
      images: movie.images,
      comingSoon: movie.comingSoon,
      isFavorite: isFavorite,
    );
    return copyWith(movies: updatedMovies);
  }
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieRepository _movieRepository;
  static const int _moviesPerPage = 5;

  HomeBloc({MovieRepository? movieRepository})
      : _movieRepository = movieRepository ?? MovieRepositoryImpl(),
        super(HomeInitial()) {
    on<LoadMovies>(_onLoadMovies);
    on<LoadMoreMovies>(_onLoadMoreMovies);
    on<UpdateScrollPosition>(_onUpdateScrollPosition);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadMovies(LoadMovies event, Emitter<HomeState> emit) async {
    if (state is! HomeLoaded) {
      emit(HomeLoading());
    }
    
    try {
      final response = await _movieRepository.getMovies(page: 1);
      if (response.success && response.data != null) {
        final movies = response.data!.movies;
        final hasReachedEnd = movies.length < _moviesPerPage;
        
        if (state is HomeLoaded) {
          final currentState = state as HomeLoaded;
          emit(currentState.copyWith(
            movies: movies,
            hasReachedEnd: hasReachedEnd,
            currentPage: 1,
          ));
        } else {
          emit(HomeLoaded(
            movies: movies,
            hasReachedEnd: hasReachedEnd,
            currentPage: 1,
          ));
        }
      } else {
        emit(HomeError(response.message ?? 'Failed to load movies'));
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onLoadMoreMovies(LoadMoreMovies event, Emitter<HomeState> emit) async {
    final currentState = state;
    if (currentState is HomeLoaded && !currentState.hasReachedEnd) {
      try {
        // Set loading state
        emit(currentState.copyWith(isLoadingMore: true));
        
        final nextPage = currentState.currentPage + 1;
        final response = await _movieRepository.getMovies(page: nextPage);
        
        if (response.success && response.data != null) {
          final newMovies = response.data!.movies;
          final hasReachedEnd = newMovies.length < _moviesPerPage;

          emit(currentState.copyWith(
            movies: [...currentState.movies, ...newMovies],
            hasReachedEnd: hasReachedEnd,
            currentPage: nextPage,
            isLoadingMore: false,
          ));
        } else {
          emit(currentState.copyWith(isLoadingMore: false));
          emit(HomeError(response.message ?? 'Failed to load more movies'));
        }
      } catch (e) {
        emit(currentState.copyWith(isLoadingMore: false));
        emit(HomeError(e.toString()));
      }
    }
  }

  void _onUpdateScrollPosition(UpdateScrollPosition event, Emitter<HomeState> emit) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(currentState.copyWith(currentIndex: event.index));
    }
  }

  Future<void> _onToggleFavorite(ToggleFavorite event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final currentMovie = currentState.movies[event.movieIndex];
      final newFavoriteStatus = !(currentMovie.isFavorite ?? false);
      
      // Optimistic update
      emit(currentState.updateMovieFavoriteStatus(event.movieIndex, newFavoriteStatus));

      try {
        // Make API call for both favorite and unfavorite actions
        final response = await _movieRepository.addFavorite(event.movieId);
        
        if (!response.success) {
          // Revert on failure
          emit(currentState.updateMovieFavoriteStatus(event.movieIndex, !newFavoriteStatus));
        }
      } catch (e) {
        // Revert on error
        emit(currentState.updateMovieFavoriteStatus(event.movieIndex, !newFavoriteStatus));
        emit(HomeError(e.toString()));
      }
    }
  }
} 