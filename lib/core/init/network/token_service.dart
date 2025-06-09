import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static final TokenService _instance = TokenService._init();
  static TokenService get instance => _instance;
  TokenService._init();

  static const String _tokenKey = 'auth_token';
  final _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('remember_me');
    await prefs.remove('remembered_email');
  }

  bool isTokenError(Map<String, dynamic>? response) {
    if (response == null || response['code'] != 400) return false;
    final message = response['message'] as String?;
    return message == 'JsonWebTokenError: invalid token' || message == 'TOKEN_UNAVAILABLE';
  }
} 