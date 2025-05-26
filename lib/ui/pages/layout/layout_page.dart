import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pomato_flutter/constant/colors.dart';
import 'package:pomato_flutter/ui/pages/profile/profile_page.dart';
import '../home/home_page.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ProfilePage(),
    // 여기에 다른 페이지 추가
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.lightGray,
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/bn_icons/home.svg',
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 0 ? AppColors.black : AppColors.darkGray,
                  BlendMode.srcIn,
                ),
              ),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/bn_icons/profile.svg',
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 1 ? AppColors.black : AppColors.darkGray,
                  BlendMode.srcIn,
                ),
              ),
              label: '프로필',
            ),
          ],
        ),
      ),
    );
  }
}
