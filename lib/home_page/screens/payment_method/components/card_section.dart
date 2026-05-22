import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../constants/app_colors.dart';

class CardSection extends StatelessWidget {
  final String selectedMethod;
  final Function(String) onMethodSelected;
  final VoidCallback onAddNewCard;

  const CardSection({
    Key? key,
    required this.selectedMethod,
    required this.onMethodSelected,
    required this.onAddNewCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24),
          Text(
            'Pay using Credit/Debit Cards',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack,
            ),
          ),
          SizedBox(height: 16),
          // Existing Card Option
          _buildPaymentOption(
            icon: _buildMastercardIcon(),
            title: '1234xxxxxxxx890',
            isSelected: selectedMethod == 'existing_card',
            onTap: () => onMethodSelected('existing_card'),
          ),
          SizedBox(height: 16),
          // Add New Card Option
          Center(
            child: GestureDetector(
              onTap: onAddNewCard,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, color: AppColors.textBlack, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Add New Card',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required Widget icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
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
        child: Row(
          children: [
            icon,
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.black : AppColors.borderGrey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 14,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMastercardIcon() {
    return Image.asset(
      'assets/icons/master_card.png',
      width: 40,
      height: 40,
      fit: BoxFit.contain,
    );
  }
}
