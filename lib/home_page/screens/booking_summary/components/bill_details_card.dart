import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class BillDetailsCard extends StatelessWidget {
  final String coverChargeAmount;
  final String totalAmount;

  const BillDetailsCard({
    Key? key,
    required this.coverChargeAmount,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(12),
      
      ),
      child: Column(
        children: [
          // Cover Charge Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cover Charge',
                      style: TextStyle(
                        fontSize: 12.sp,
                       color: AppColors.textBlack,
                       fontWeight: FontWeight.w400
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'redeem it by paying bill via paw tales',
                      style: TextStyle(
                         fontSize: 10.sp,
                       color: AppColors.textGreen,
                       fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                coverChargeAmount,
                style: TextStyle(
                   fontSize: 12.sp,
                       color: AppColors.textBlack,
                       fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          // Separator line
          Container(
            height: 1,
            color: Colors.grey[300],
          ),
          SizedBox(height: 12),
          // To Pay Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'To pay',
                style: TextStyle(
                    fontSize: 12.sp,
                       color: AppColors.textBlack,
                       fontWeight: FontWeight.w400
                ),
              ),
              Text(
                totalAmount,
                style: TextStyle(
                  fontSize: 12.sp,
                       color: AppColors.textBlack,
                       fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
