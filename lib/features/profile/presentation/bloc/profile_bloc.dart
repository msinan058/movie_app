import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';
import 'package:movie_app/features/profile/domain/repositories/user_repository.dart';
import 'package:movie_app/features/profile/data/repositories/user_repository_impl.dart';
import 'package:movie_app/features/home/domain/repositories/movie_repository.dart';
import 'package:movie_app/features/home/data/repositories/movie_repository_impl.dart';

// Events
abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}

class LoadFavoriteMovies extends ProfileEvent {}

// States
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;
  final List<MovieModel> favoriteMovies;

  ProfileLoaded({
    required this.user,
    this.favoriteMovies = const [],
  });

  ProfileLoaded copyWith({
    UserModel? user,
    List<MovieModel>? favoriteMovies,
  }) {
    return ProfileLoaded(
      user: user ?? this.user,
      favoriteMovies: favoriteMovies ?? this.favoriteMovies,
    );
  }
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;
  final MovieRepository _movieRepository;

  ProfileBloc({
    UserRepository? userRepository,
    MovieRepository? movieRepository,
  })  : _userRepository = userRepository ?? UserRepositoryImpl(),
        _movieRepository = movieRepository ?? MovieRepositoryImpl(),
        super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<LoadFavoriteMovies>(_onLoadFavoriteMovies);
  }

  Future<void> _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final response = await _userRepository.getProfile();
      if (response.success && response.data != null) {
        emit(ProfileLoaded(user: response.data!));
        add(LoadFavoriteMovies()); // Profil yüklendikten sonra favori filmleri yükle
      } else {
        emit(ProfileError(response.message ?? 'Failed to load profile'));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onLoadFavoriteMovies(LoadFavoriteMovies event, Emitter<ProfileState> emit) async {
    try {
      final currentState = state;
      if (currentState is ProfileLoaded) {
        final response = await _movieRepository.getFavorites();
        if (response.success && response.data != null) {
          emit(currentState.copyWith(favoriteMovies: response.data!.movies));
        }
      }
    } catch (e) {
      // Favori filmler yüklenemezse mevcut state'i koru
      print('Failed to load favorite movies: $e');
    }
  }
} 