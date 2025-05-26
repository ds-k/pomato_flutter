import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pomato_flutter/constant/colors.dart';
import 'package:pomato_flutter/ui/pages/login/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    // TODO: 여기에 유저 로그인 정보 확인 (하단 checkUserLoginStatus 함수 구현)
    _checkUserLoginStatus();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  Future<void> _checkUserLoginStatus() async {
    // TODO: 유저 로그인 상태 확인 로직을 여기에 구현
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.mainOrange,
        child: Center(
          child: SvgPicture.asset('assets/images/splash/splash_logo.svg'),
        ),
      ),
    );
  }
}
