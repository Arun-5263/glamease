import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class TransactionDetailsCard extends StatelessWidget {
  final String coverChargeAmount;
  final String upiTransactionNo;
  final bool isCancelled;

  const TransactionDetailsCard({
    Key? key,
    required this.coverChargeAmount,
    required this.upiTransactionNo,
    this.isCancelled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackOpacity10,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Charge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cover Charge',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textBlack,
                  ),
                ),
                Text(
                  coverChargeAmount,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textBlack,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 8),
            
            // Redeemable text or Refund Not applicable
            Text(
              isCancelled ? 'Refund Not applicable' : 'redeemable by paying bill via paw tales',
              style: TextStyle(
                fontSize: 10.sp,
                color: isCancelled ? Color(0xFFFF2C2C) : AppColors.textGreen,
              ),
            ),
            
            SizedBox(height: 16),
            
            // Divider
            Divider(color: AppColors.borderGrey, height: 1),
            
            SizedBox(height: 16),
            
            // Payment Method
            Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textBlack,
              ),
            ),
            
            SizedBox(height: 12),
            
            // UPI Transaction
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UPI Transaction No',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textGrey,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      upiTransactionNo,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
                Text(
                  coverChargeAmount.replaceAll('.00', ''),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

