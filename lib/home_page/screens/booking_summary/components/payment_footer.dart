import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:sizer/sizer.dart';
import '../../../../constants/app_colors.dart';
import '../../payment_method/components/payment_method_bottom_sheet.dart';
import '../../booking_confirmed/booking_confirmed_screen.dart';

class PaymentFooter extends StatefulWidget {
  final VoidCallback onSwipeToPay;

  const PaymentFooter({
    Key? key,
    required this.onSwipeToPay,
  }) : super(key: key);

  @override
  _PaymentFooterState createState() => _PaymentFooterState();
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
    
    if (result != null) {
      setState(() {
        selectedPaymentMethod = result;
      });
    }
  }

  String get _paymentMethodName {
    switch (selectedPaymentMethod) {
      case 'google_pay':
        return 'Google Pay';
      case 'phonepe':
        return 'Phonepe';
      case 'existing_card':
        return 'Card';
      default:
        return 'Phonepe';
    }
  }

  Widget get _paymentMethodIcon {
    switch (selectedPaymentMethod) {
      case 'google_pay':
        return Image.asset(
          'assets/icons/g_pay.png',
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        );
      case 'phonepe':
        return Image.asset(
          'assets/icons/phonpe.png',
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        );
      case 'existing_card':
        return Image.asset(
          'assets/icons/master_card.png',
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        );
      default:
        return Image.asset(
          'assets/icons/phonpe.png',
          width: 40,
          height: 40,
          fit: BoxFit.contain,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Payment Method
            Row(
              children: [
                _paymentMethodIcon,
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pay using',
                        style: TextStyle(
                          color: AppColors.textBlack,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        _paymentMethodName,
                        style: TextStyle(
                           color: AppColors.textGrey,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: _changePaymentMethod,
                  child: Text(
                    'Change >',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF001EFF),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Swipe to Pay Button
            SwipeButton(
              activeThumbColor: AppColors.primaryOrange,
              activeTrackColor: AppColors.primaryOrange,
              thumb: Container(
             
                padding: EdgeInsets.only(left: 8),
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
              },
            ),
          ],
        ),
      ),
    );
  }
}