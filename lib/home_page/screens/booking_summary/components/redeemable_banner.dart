import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class RedeemableBanner extends StatelessWidget {
  final String message;

  const RedeemableBanner({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFFFFF9C4), // Light yellow background
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.textBlack,
            fontWeight: FontWeight.w400),
        textAlign: TextAlign.center,
      ),
    );
  }
}
