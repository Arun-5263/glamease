import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../constants/app_colors.dart';

class PaymentMethodHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // Top handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.grey300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 20),
          // Title
          Text(
            'Choose Payment Method',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack,
            ),
          ),
        ],
      ),
    );
  }
}
