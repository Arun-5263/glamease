import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:sizer/sizer.dart';
import '../../../../constants/app_colors.dart';
import '../../payment_method/components/payment_method_bottom_sheet.dart';
import '../../transaction_successful/transaction_successful_screen.dart';

class PaymentFooter extends StatefulWidget {
  final VoidCallback onSwipeToPay;
  final String venueName;
  final String address;
  final String discountedAmount;

  const PaymentFooter({
    Key? key,
    required this.onSwipeToPay,
    required this.venueName,
    required this.address,
    required this.discountedAmount,
  }) : super(key: key);

  @override
  _PaymentFooterState createState() => _PaymentFooterState();
}

class _PaymentFooterState extends State<PaymentFooter> {
  bool payFromWallet = false;
  String selectedPaymentMethod = 'phonepe';

  String _formatDateTime(DateTime dateTime) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final day = dateTime.day;
    final month = months[dateTime.month - 1];
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$day $month, $hour:$minute $period';
  }

  Future<void> _showPaymentMethodBottomSheet() async {
    try {
      final result = await showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        enableDrag: true,
        useRootNavigator: false,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black54,
        builder: (context) => PaymentMethodBottomSheet(
            currentMethod: selectedPaymentMethod,
          ),
      );
      
      if (result != null && mounted) {
        setState(() {
          selectedPaymentMethod = result;
        });
      }
    } catch (e) {
      // Handle any errors silently
      print('Error showing payment method bottom sheet: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.backgroundGrey,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Wallet Payment Option
              Row(
                children: [
                  Checkbox(
                    value: payFromWallet,
                    onChanged: (value) {
                      setState(() {
                        payFromWallet = value ?? false;
                      });
                    },
                    activeColor: AppColors.primaryOrange,
                  ),
                  Text(
                    'Pay ₹20 from wallet',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textBlack,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              
              // Choose Payment Method
              GestureDetector(
                onTap: _showPaymentMethodBottomSheet,
                child: Row(
                  children: [
                    Icon(
                      Icons.help_outline,
                      color: AppColors.textGrey,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Choose Payment Method',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.textGrey,
                      size: 16,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              
              // Swipe to Pay Button
              SwipeButton(
                activeThumbColor: AppColors.primaryOrange,
                activeTrackColor: AppColors.primaryOrange,
                thumb: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.textWhite,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/icons/slide_icon.png',
                    width: 18,
                    height: 18,
                    fit: BoxFit.contain,
                  ),
                ),
                child: Text(
                  'Swipe to Pay',
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onSwipe: () {
                  // Navigate to Transaction Successful screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransactionSuccessfulScreen(
                        transactionDate: _formatDateTime(DateTime.now()),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

