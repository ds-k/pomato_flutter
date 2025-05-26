import 'package:dio/dio.dart';
import '../models/auth_model.dart';

abstract class IAuthRepository {
  Future<AuthModel> socialLogin(String token, String provider);
  Future<AuthModel> refreshToken(String refreshToken);
}

class AuthRepository implements IAuthRepository {
  final Dio _dio;
  final String _baseUrl;

  AuthRepository({
    Dio? dio,
    String? baseUrl,
  })  : _dio = dio ?? Dio(),
        _baseUrl = const String.fromEnvironment("API_SERVER_URL");

  @override
  Future<AuthModel> socialLogin(String token, String provider) async {
    try {
      print(token);
      print(provider);
      print(_baseUrl);
      final response = await _dio.post(
        '$_baseUrl/auth/social-login',
        data: {
          'token': token,
          'provider': provider,
        },
      );

      return AuthModel(
        accessToken: response.data['accessToken'],
        refreshToken: response.data['refreshToken'],
        provider: provider,
      );
    } catch (e) {
      throw Exception('소셜 로그인 실패: $e');
    }
  }

  @override
  Future<AuthModel> refreshToken(String refreshToken) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/auth/refresh',
        data: {
          'refreshToken': refreshToken,
        },
      );

      return AuthModel(
        accessToken: response.data['accessToken'],
        refreshToken: response.data['refreshToken'],
      );
    } catch (e) {
      throw Exception('토큰 갱신 실패: $e');
    }
  }
}
