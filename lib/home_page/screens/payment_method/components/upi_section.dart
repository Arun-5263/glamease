import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../constants/app_colors.dart';

class UPISection extends StatelessWidget {
  final String selectedMethod;
  final Function(String) onMethodSelected;

  const UPISection({
    Key? key,
    required this.selectedMethod,
    required this.onMethodSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pay by any UPI app',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack,
            ),
          ),
          SizedBox(height: 16),
          // Google Pay Option
          _buildPaymentOption(
            icon: _buildGooglePayIcon(),
            title: 'Google Pay',
            isSelected: selectedMethod == 'google_pay',
            onTap: () => onMethodSelected('google_pay'),
          ),
          SizedBox(height: 12),
          // PhonePe Option
          _buildPaymentOption(
            icon: _buildPhonePeIcon(),
            title: 'Phonepe',
            isSelected: selectedMethod == 'phonepe',
            onTap: () => onMethodSelected('phonepe'),
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

  Widget _buildGooglePayIcon() {
    return Image.asset(
      'assets/icons/g_pay.png',
      width: 40,
      height: 40,
      fit: BoxFit.contain,
    );
  }

  Widget _buildPhonePeIcon() {
    return Image.asset(
      'assets/icons/phonpe.png',
      width: 40,
      height: 40,
      fit: BoxFit.contain,
    );
  }
}
