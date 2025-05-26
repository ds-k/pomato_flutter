import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pomato_flutter/constant/colors.dart';
import 'package:pomato_flutter/ui/pages/layout/layout_page.dart';
import 'package:pomato_flutter/ui/pages/login/widget/login_bottom_sheet.dart';

class CarouselItem {
  final String imagePath;
  final String description;
  final String title;

  CarouselItem({
    required this.imagePath,
    required this.description,
    required this.title,
  });
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<CarouselItem> _carouselItems = [
    CarouselItem(
      imagePath: 'assets/images/login/carousel_1.png',
      title: '내 주변 포마토를\n지도에서 한번에 조회',
      description: '포마토는 이사시 발생하는 물건을\n일괄 판매할 수 있는 플랫폼입니다',
    ),
    CarouselItem(
      imagePath: 'assets/images/login/carousel_2.png',
      title: '열린집',
      description: '포마토는 이사시 발생하는 물건을\n일괄 판매할 수 있는 플랫폼입니다',
    ),
    CarouselItem(
      imagePath: 'assets/images/login/carousel_3.png',
      title: '열린집',
      description: '포마토는 이사시 발생하는 물건을\n일괄 판매할 수 있는 플랫폼입니다',
    ),
  ];

  void _showLoginBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const LoginBottomSheet(),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _carouselItems.length,
                itemBuilder: (context, index) {
                  final item = _carouselItems[index];
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),
                        Image.asset(
                          item.imagePath,
                          height: 200,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          item.title,
                          style: const TextStyle(
                            color: AppColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.description,
                          style: const TextStyle(
                            color: AppColors.darkGray,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _carouselItems.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _currentPage == index ? 20 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(_currentPage == index ? 4 : 100),
                    color: _currentPage == index
                        ? AppColors.mainOrange
                        : AppColors.lightGray,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: _showLoginBottomSheet,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.black,
                  foregroundColor: AppColors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  '로그인하기',
                  style: TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LayoutPage(),
                  ),
                  (route) => false,
                );
              },
              child: const Text(
                '열린집 둘러보기',
                style: TextStyle(
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.darkGray,
                  color: AppColors.darkGray,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
