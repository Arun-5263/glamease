import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class OffersSection extends StatelessWidget {
  final Function(String) onOfferSelected;
  final String? selectedOffer;

  const OffersSection({
    super.key,
    required this.onOfferSelected,
    this.selectedOffer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Offers',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack,
              fontFamily: 'Manrope',
            ),
          ),
        ),
        SizedBox(height: 16),
        
        // Offers carousel
        SizedBox(
          height: 70,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: [
              // HDFC Bank Offer
              _buildOfferCard(
                context: context,
                discount: '30%',
                minAmount: '₹2000',
                bankName: 'HDFC Bank',
                isSelected: selectedOffer == '30%',
                onTap: () => onOfferSelected('30%'),
              ),
              SizedBox(width: 12),
              
              // PhonePe/Punjab National Bank Offer
              _buildOfferCard(
                context: context,
                discount: '15%',
                minAmount: '₹1500',
                bankName: 'PhonePe',
                isSelected: selectedOffer == '15%',
                onTap: () => onOfferSelected('15%'),
              ),
              SizedBox(width: 12),
              
              // ICICI Bank Offer
              _buildOfferCard(
                context: context,
                discount: '25%',
                minAmount: '₹1500',
                bankName: 'ICICI Bank',
                isSelected: selectedOffer == '25%',
                onTap: () => onOfferSelected('25%'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOfferCard({
    required BuildContext context,
    required String discount,
    required String minAmount,
    required String bankName,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.36,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryLightOrange
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Logo
            Image.asset(
              'assets/icons/master_card.png',
              width: 25,
              height: 25,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 2.w),
            
            // Offer details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Upto $discount OFF',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlack,
                      fontFamily: 'Manrope',
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Above $minAmount',
                    style: TextStyle(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textGrey,
                      fontFamily: 'Manrope',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

