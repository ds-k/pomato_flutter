import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../ui/viewmodels/auth_viewmodel.dart';
import '../../../../constant/colors.dart';
import '../../../pages/layout/layout_page.dart';
import 'privacy_policy_page.dart';

class LoginBottomSheet extends ConsumerWidget {
  const LoginBottomSheet({super.key});

  String getErrorMessage(dynamic error) {
    if (error.toString().contains('network_error')) {
      return '네트워크 연결을 확인해주세요.';
    }
    if (error.toString().contains('sign_in_failed')) {
      return 'Google Play Services를 확인해주세요.';
    }
    return '로그인에 실패했습니다. 다시 시도해주세요.';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 86,
              height: 4,
              margin: const EdgeInsets.only(bottom: 40),
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          const Text(
            '로그인 후 포마토를 이용해 보세요.',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            '소셜로그인을 통해 간편하게 이용하실 수 있습니다.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.darkGray,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () async {
              try {
                await ref
                    .read(authViewModelProvider.notifier)
                    .signInWithGoogle();
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LayoutPage()),
                  );
                }
              } catch (error) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(getErrorMessage(error)),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              }
            },
            icon: SvgPicture.asset(
              'assets/images/login/google_logo.svg',
              height: 24,
            ),
            label: const Text('구글로 로그인하기'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.black,
              side: const BorderSide(color: AppColors.googleGray),
              elevation: 0,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () async {
              try {
                await ref
                    .read(authViewModelProvider.notifier)
                    .signInWithApple();
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LayoutPage()),
                  );
                }
              } catch (error) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(getErrorMessage(error)),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              }
            },
            icon: SvgPicture.asset(
              'assets/images/login/apple_logo.svg',
              height: 24,
            ),
            label: const Text('애플로 로그인하기'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: AppColors.appleBlack,
              foregroundColor: AppColors.white,
              elevation: 0,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "계속 진행하면 ",
                style: TextStyle(
                  color: AppColors.darkGray,
                  fontSize: 12,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyPage(),
                    ),
                  );
                },
                child: const Text(
                  "이용약관/개인정보 처리방침",
                  style: TextStyle(
                    color: AppColors.mainOrange,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.mainOrange,
                  ),
                ),
              ),
              Text(
                "이 적용됩니다.",
                style: TextStyle(
                  color: AppColors.darkGray,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
