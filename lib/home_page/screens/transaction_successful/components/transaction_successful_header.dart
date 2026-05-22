import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class TransactionSuccessfulHeader extends StatelessWidget {
  final String transactionDate;
  final bool isPending;
  final bool isFailed;

  const TransactionSuccessfulHeader({
    Key? key,
    required this.transactionDate,
    this.isPending = false,
    this.isFailed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 17.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isFailed 
            ? Color(0xFFFFEDEF) 
            : (isPending ? AppColors.transactionPendingBanner : AppColors.successGreen),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Back button and Transaction text in same line (for pending and failed)
            if (isPending || isFailed)
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: AppColors.textBlack, size: 20),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ),
                  Text(
                    isFailed ? 'Transaction Failed' : 'Transaction Pending',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isFailed ? Color(0xFFFF2C2C) : AppColors.textBlack,
                    ),
                  ),
                ],
              )
            else
              // Transaction Successful text
              Text(
                'Transaction Successful',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textWhite,
                ),
              ),
            
       
            
            // Transaction date
            Text(
              transactionDate,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w300,
                color: isFailed 
                    ? Color(0xFFFF2C2C) 
                    : (isPending ? AppColors.textBlack : AppColors.textWhite),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

