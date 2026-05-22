import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'feedback_bottom_sheet.dart';

class PaymentReceipt extends StatelessWidget {
  final String merchantName;
  final String address;
  final String totalBill;
  final String paidAmount;
  final String savedAmount;
  final String coverCharge;
  final String discount;
  final String couponOffer;
  final bool isPending;
  final bool isFailed;

  const PaymentReceipt({
    Key? key,
    this.merchantName = 'Peek a Bow - The pet club, Hyderabad',
    this.address = 'Lingampally, BHEL road',
    this.totalBill = '₹1500.00',
    this.paidAmount = '₹1125.00',
    this.savedAmount = '₹525',
    this.coverCharge = '50.00',
    this.discount = '375.00',
    this.couponOffer = '150.00',
    this.isPending = false,
    this.isFailed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Success/Pending Icon and Title
          Padding(
            padding: EdgeInsets.only(top: 24, bottom: 16),
            child: Column(
              children: [
                isPending
                    ? Column(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/processing_icon.svg',
                            width: 80,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 16),
                          Padding(
                             padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              'Your payment is still processing',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textBlack,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 1.5.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            child: Text(
                              'This usually takes a few minutes. We\'ll update you as soon as we get a confirmation from your bank.',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w300,
                                color: AppColors.textBlack,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                          SizedBox(height: 2.h),
                         
                       
                          Text(
                            paidAmount,
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimaryBlack,
                            ),
                          ),
                        ],
                      )
                    : isFailed
                        ? Column(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFEDEF),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF2C2C),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Oops!',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textBlack,
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Your payment couldn\'t be completed',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textBlack,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: 1.5.h),
                              Text(
                                paidAmount,
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimaryBlack,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Image.asset(
                                'assets/icons/Success Icon_clrd.png',
                                width: 50,
                                height: 50,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Payment Success!',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textBlack,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                paidAmount,
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimaryBlack,
                                ),
                              ),
                            ],
                          ),
              ],
            ),
          ),

          // Savings Banner (only for successful, not for pending or failed)
          if (!isPending && !isFailed)
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Color(0xFFE5F4ED),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Hurray! You Saved $savedAmount on this bill',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF23A26D),
                ),
                textAlign: TextAlign.center,
              ),
            ),

          SizedBox(height: 24),

          // Merchant Information
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                   Image.asset(
                    'assets/icons/location.png',
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                
                  ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        merchantName,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Text(
                    address,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textGrey,
                          fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Experience Rating Section (only show when not pending and not failed)
          if (!isPending && !isFailed)
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => FeedbackBottomSheet(),
                );
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFFF9E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Text(
                      'How was your experience at Peek a Bow?',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryBlack,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildRatingOption('assets/icons/terrible_unselected.svg', 'Terrible', false),
                        _buildRatingOption('assets/icons/bad_unselected.svg', 'Bad', false),
                        _buildRatingOption('assets/icons/okay_unselected.svg', 'Okay', false),
                        _buildRatingOption('assets/icons/good.svg', 'Good', true),
                        _buildRatingOption('assets/icons/great_unselected.svg', 'Great', false),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          if (!isPending && !isFailed) SizedBox(height: 10),

          // Payment Summary (not shown for failed)
          if (!isFailed)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Payment summary',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlack,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  SizedBox(height: 16),
                  _buildSummaryRow('Total bill', totalBill),
                  SizedBox(height: 12),
                  _buildSummaryRow('Cover Charge', '- $coverCharge', isNegative: true),
                  SizedBox(height: 12),
                  _buildSummaryRow('Discount (25% OFF)', '- $discount', isNegative: true),
                  SizedBox(height: 12),
                  _buildSummaryRow('Coupon/Offer', '- $couponOffer', isNegative: true),
                  SizedBox(height: 10),
                  Divider(thickness: 1, color: AppColors.borderGrey),
                  SizedBox(height: 10),
                  _buildSummaryRow(
                    isPending ? 'Pending' : 'Paid',
                    paidAmount,
                    isBold: true,
                    isPending: isPending,
                    isFailed: isFailed,
                  ),
                  // SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildRatingOption(String iconPath, String label, bool isSelected) {
    return Column(
      children: [
        Center(
          child: SvgPicture.asset(
            iconPath,
            width: 35,
            height: 35,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: AppColors.textGrey,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String amount, {bool isNegative = false, bool isBold = false, bool isPending = false, bool isFailed = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            color: (isBold && (isPending || isFailed)) 
                ? (isFailed ? Color(0xFFFF2C2C) : AppColors.transactionPendingText) 
                : AppColors.textPrimaryBlack,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: isBold ? FontWeight.w400 : FontWeight.w500,
            color: isNegative 
                ? AppColors.textGrey 
                : (isBold && isPending
                    ? AppColors.transactionPendingText
                    : (isBold && isFailed
                        ? Color(0xFFFF2C2C)
                        : (isBold ? AppColors.textPrimaryBlack : AppColors.textPrimaryBlack))),
          ),
        ),
      ],
    );
  }
}

