import 'package:equatable/equatable.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';

class AuthResponse extends Equatable {
  final String token;
  final UserModel user;

  const AuthResponse({
    required this.token,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
  final data = json['data'] as Map<String, dynamic>;

  return AuthResponse(
    token: data['token']?.toString() ?? '',
    user: UserModel.fromJson(data),
  );
}


  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user.toJson(),
    };
  }

  @override
  List<Object?> get props => [token, user];
}

class LoginRequest extends Equatable {
  final String email;
  final String password;
  final bool rememberMe;

  const LoginRequest({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'remember_me': rememberMe,
    };
  }

  @override
  List<Object?> get props => [email, password, rememberMe];
}

class RegisterRequest extends Equatable {
  final String email;
  final String name;
  final String password;

  const RegisterRequest({
    required this.email,
    required this.name,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'password': password,
    };
  }

  @override
  List<Object?> get props => [email, name, password];
} 