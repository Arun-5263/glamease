import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../constants/app_colors.dart';

class PaymentMethodFooter extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onProceed;

  const PaymentMethodFooter({
    Key? key,
    required this.isEnabled,
    required this.onProceed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: isEnabled ? onProceed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryOrange,
              disabledBackgroundColor: AppColors.grey300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              'Proceed',
              style: TextStyle(
                color: AppColors.textWhite,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
