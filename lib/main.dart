import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomato_flutter/ui/pages/splash/splash_page.dart';

import 'constant/colors.dart';

void main() {
  print(const String.fromEnvironment('ENV_SAMPLE'));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'pomato_flutter',
      theme: ThemeData(
        fontFamily: 'Pretendard',
        scaffoldBackgroundColor: AppColors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.black,
          unselectedItemColor: AppColors.darkGray,
          selectedLabelStyle: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.normal,
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.black,
          selectionColor: const Color.fromARGB(34, 23, 23, 23),
          selectionHandleColor: AppColors.black,
        ),
      ),
      home: const SplashPage(),
    );
  }
}
