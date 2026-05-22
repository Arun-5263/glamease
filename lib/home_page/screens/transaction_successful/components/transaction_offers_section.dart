import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class TransactionOffersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title with horizontal lines
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                'assets/icons/left_line.png',
                width: 15.w,
                fit: BoxFit.contain,
              ),
              Spacer(),
              Text(
                'Offers For You',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textBlack,
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              Image.asset(
                'assets/icons/right_line.png',
                width: 15.w,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        
        // Offers carousel - orange/peach colored cards
        Container(
          height: 90,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: AppColors.primaryLightOrange.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                margin: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: AppColors.primaryLightOrange.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

