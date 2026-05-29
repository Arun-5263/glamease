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
    super.key,
    required this.onSwipeToPay,
    required this.venueName,
    required this.address,
    required this.discountedAmount,
  });

  @override
  State<PaymentFooter> createState() => _PaymentFooterState();
}

class _PaymentFooterState extends State<PaymentFooter> {
  String selectedPaymentMethod = 'phonepe';

  Future<void> _changePaymentMethod() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PaymentMethodBottomSheet(
        currentMethod: selectedPaymentMethod,
      ),
    );

    if (result != null && mounted) {
      setState(() {
        selectedPaymentMethod = result;
      });
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final day = dateTime.day;
    final month = months[dateTime.month - 1];
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$day $month, $hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Choose Payment Method row
            GestureDetector(
              onTap: _changePaymentMethod,
              child: Row(
                children: [
                  const Icon(
                    Icons.help_outline,
                    color: AppColors.textGrey,
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Choose Payment Method',
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF5C6579), // Nice gray color
                        fontFamily: 'Manrope',
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: Color(0xFF001EFF), // Blue chevron
                    size: 24,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Swipe to Pay Button
            SwipeButton(
              height: 60.0,
              activeThumbColor: AppColors.primaryOrange,
              activeTrackColor: AppColors.primaryOrange,
              thumb: Container(
                padding: const EdgeInsets.only(left: 8),
                child: Image.asset(
                  'assets/icons/slide_icon.png',
                  width: 30,
                  height: 30,
                  fit: BoxFit.contain,
                ),
              ),
              child: Text(
                'Swipe to Pay',
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onSwipe: () {
                widget.onSwipeToPay();
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
    );
  }
}
