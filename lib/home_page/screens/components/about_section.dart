import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:glamease/constants/app_colors.dart';

class AboutSection extends StatelessWidget {
  final String aboutText;

  const AboutSection({
    Key? key,
    required this.aboutText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textBlack,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          aboutText,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textBlack,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
