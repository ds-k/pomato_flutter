import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pomato_flutter/ui/providers/providers.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../data/models/auth_model.dart';
import '../../data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:pomato_flutter/ui/pages/login/login_page.dart';

enum AuthProvider {
  google,
  apple,
}

// secure_storage

class AuthViewModel extends Notifier<AuthModel> {
  late final IAuthRepository _authRepository = ref.read(authRepositoryProvider);
  final GoogleSignIn _googleSignIn;

  void Function(BuildContext)? onLogout;

  AuthViewModel({
    GoogleSignIn? googleSignIn,
    this.onLogout,
  }) : _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  AuthModel build() {
    return AuthModel(
      accessToken: '',
      refreshToken: '',
      provider: null,
    );
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google 로그인이 취소되었습니다.');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        throw Exception('ID Token을 가져오는데 실패했습니다.');
      }

      final auth =
          await _authRepository.socialLogin(idToken, AuthProvider.google.name);

      state = AuthModel(
        accessToken: auth.accessToken ?? '',
        refreshToken: auth.refreshToken ?? '',
        provider: AuthProvider.google.name,
      );
    } catch (e) {
      throw Exception('Google 로그인 실패: $e');
    }
  }

  Future<void> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      if (credential.identityToken == null) {
        throw Exception('Apple ID Token을 가져오는데 실패했습니다.');
      }

      final auth = await _authRepository.socialLogin(
        credential.identityToken!,
        AuthProvider.apple.name,
      );
      state = AuthModel(
        accessToken: auth.accessToken ?? '',
        refreshToken: auth.refreshToken ?? '',
        provider: AuthProvider.apple.name,
      );
    } catch (e) {
      throw Exception('Apple 로그인 실패: $e');
    }
  }

  Future<void> refreshToken() async {
    if (state.refreshToken == null) return;

    try {
      final auth = await _authRepository.refreshToken(state.refreshToken!);
      state = AuthModel(
        accessToken: auth.accessToken ?? '',
        refreshToken: auth.refreshToken ?? '',
        provider: state.provider,
      );
    } catch (e) {
      throw Exception('토큰 갱신 실패: $e');
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await _authRepository.logout(state.refreshToken!);
      await _googleSignIn.signOut();
      state = AuthModel(
        accessToken: '',
        refreshToken: '',
        provider: null,
      );

      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false,
        );
      }
    } catch (e) {
      throw Exception('로그아웃 실패: $e');
    }
  }
}

final authViewModelProvider = NotifierProvider<AuthViewModel, AuthModel>(() {
  return AuthViewModel();
});
