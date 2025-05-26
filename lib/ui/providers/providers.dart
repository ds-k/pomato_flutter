import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomato_flutter/data/repositories/user_repository.dart';
import 'package:pomato_flutter/ui/viewmodels/auth_viewmodel.dart';
import '../../data/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRepository(dio: ref.read(dioProvider));
});

final userRepositoryProvider = Provider<IUserRepository>((ref) {
  return UserRepository(dio: ref.read(dioProvider));
});

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: const String.fromEnvironment("API_SERVER_URL"),
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      options.headers['Authorization'] =
          'Bearer ${ref.read(authViewModelProvider).accessToken}';
      return handler.next(options);
    },
    onError: (error, handler) {
      if (error.response?.statusCode == 401) {
        ref.read(authViewModelProvider.notifier).refreshToken();
      }
      return handler.next(error);
    },
  ));

  return dio;
});
