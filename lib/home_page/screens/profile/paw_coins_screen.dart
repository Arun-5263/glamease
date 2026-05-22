import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class PawCoinsScreen extends StatelessWidget {
  const PawCoinsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textBlack),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Paw Coins',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // White Header Section with rounded bottom corners
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 4.h),

                  // Golden Coin with Paw Print
                  Image.asset(
                    'assets/icons/paw_icon.png',
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: 2.h),

                  // Conversion Rate
                  Text(
                    '1 Coin = ₹1 Rupee',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textBlack,
                    ),
                  ),

                  SizedBox(height: 4.h),
                ],
              ),
            ),

            SizedBox(height: 2.h),

            // Transaction History Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transaction History',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlack,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle view all
                    },
                    child: Text(
                      'view all',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 2.h),

            // Transaction List
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildTransactionItem(
                    transactionType: 'Peek-a-Bow',
                    transactionNo: '1232348998457',
                    amount: '-31.00',
                    isDebit: true,
                    date: '16 Jun, 09:31AM',
                  ),
                  SizedBox(height: 12),
                  _buildTransactionItem(
                    transactionType: 'Refund',
                    transactionNo: '1232348998457',
                    amount: '+211.00',
                    isDebit: false,
                    date: '16 Jun, 09:31AM',
                  ),
                  SizedBox(height: 12),
                  _buildTransactionItem(
                    transactionType: 'Login Bonus',
                    transactionNo: '1232348998457',
                    amount: '+211.00',
                    isDebit: false,
                    date: '16 Jun, 09:31AM',
                  ),
                  SizedBox(height: 12),
                  _buildTransactionItem(
                    transactionType: 'Meow-Spa',
                    transactionNo: '1232348998457',
                    amount: '-31.00',
                    isDebit: true,
                    date: '16 Jun, 09:31AM',
                  ),
                  SizedBox(height: 12),
                  _buildTransactionItem(
                    transactionType: 'Referral Bonus',
                    transactionNo: '1232348998457',
                    amount: '+211.00',
                    isDebit: false,
                    date: '16 Jun, 09:31AM',
                  ),
                ],
              ),
            ),

            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem({
    required String transactionType,
    required String transactionNo,
    required String amount,
    required bool isDebit,
    required String date,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Icon Container
          Center(
            child: SvgPicture.asset(
              isDebit
                  ? 'assets/icons/debit_arrow.svg'
                  : 'assets/icons/Credit_arrow.svg',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                isDebit ? AppColors.textGrey : Color(0xFF4CAF50),
                BlendMode.srcIn,
              ),
            ),
          ),

          SizedBox(width: 12),

          // Transaction Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transactionType,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textBlack,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Txn No: $transactionNo',
                  style: TextStyle(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),

          // Amount and Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: isDebit ? Color(0xFFEB001B) : Color(0xFF4CAF50),
                ),
              ),
              SizedBox(height: 4),
              Text(
                date,
                style: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
