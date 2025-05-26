import 'package:flutter/material.dart';
import 'package:pomato_flutter/constant/colors.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          '이용약관/개인정보 처리방침',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '이용약관',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '제1조 (목적)\n본 약관은 열린집이 제공하는 서비스의 이용조건 및 절차, 이용자와 열린집의 권리, 의무, 책임사항을 규정함을 목적으로 합니다.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.black,
                height: 1.6,
              ),
            ),
            SizedBox(height: 40),
            Text(
              '개인정보 처리방침',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '포마토는 개인정보보호법에 따라 이용자의 개인정보 보호 및 권익을 보호하고 개인정보와 관련한 이용자의 고충을 원활하게 처리할 수 있도록 다음과 같은 처리방침을 두고 있습니다.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.black,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
