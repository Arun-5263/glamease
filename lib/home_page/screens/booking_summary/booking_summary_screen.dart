import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'components/booking_summary_card.dart';
import 'components/redeemable_banner.dart';
import 'components/bill_details_card.dart';
import 'components/terms_conditions_section.dart';
import 'components/payment_footer.dart';
import '../booking_confirmed/booking_confirmed_screen.dart';

class BookingSummaryScreen extends StatelessWidget {
  final String venueName;
  final String city;
  final String dateTime;
  final String address;
  final String discountText;
  final String coverChargeText;
  final String coverChargeAmount;
  final String totalAmount;
  final String? stylistName;
  final String? customerName;

  const BookingSummaryScreen({
    super.key,
    required this.venueName,
    required this.city,
    required this.dateTime,
    required this.address,
    required this.discountText,
    required this.coverChargeText,
    required this.coverChargeAmount,
    required this.totalAmount,
    this.stylistName,
    this.customerName,
  });

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
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              venueName,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlack,
              ),
            ),
            SizedBox(height: 4),
            Text(
              city,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textGrey,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
         
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  // Booking Summary Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Booking Summary',
                      style: TextStyle(
                             fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlack,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  // Booking Summary Card
                  BookingSummaryCard(
                    dateTime: dateTime,
                    venueName: venueName,
                    address: address,
                    discountText: discountText,
                    coverChargeText: coverChargeText,
                    customerName: customerName,
                    stylistName: stylistName,
                  ),
                  
                  // Redeemable Banner
                  RedeemableBanner(
                    message: 'Your cover charge will be redeemable when you pay the bill via Paw Tales app',
                  ),
                  
                  // Bill Details Title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Bill Details',
                      style: TextStyle(
                             fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlack,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  // Bill Details Card
                  BillDetailsCard(
                    coverChargeAmount: coverChargeAmount,
                    totalAmount: totalAmount,
                  ),
                  
                  // Terms & Conditions
                  TermsConditionsSection(
                    terms: [
                      'Bookings are applicable only for PawTales partner centers listed in the app.',
                      'Please arrive at the center 15 minutes before your scheduled appointment time.',
                      'Once confirmed, bookings cannot be canceled, modified, or refunded.',
                      'Bookings are non-transferable and valid only for the selected service, date, and time.',
                      'The booking must be redeemed within the scheduled slot',
                    ],
                  ),
                  
                  // Bottom padding for payment footer
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: PaymentFooter(
        onSwipeToPay: () {
          // Generate UPI transaction number
          final upiTransactionNo = DateTime.now().millisecondsSinceEpoch.toString();
          
          // Navigate to Booking Confirmed screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BookingConfirmedScreen(
                venueName: venueName,
                city: city,
                dateTime: dateTime,
                address: address,
                coverChargeAmount: coverChargeAmount,
                upiTransactionNo: upiTransactionNo,
                customerName: customerName,
                stylistName: stylistName,
              ),
            ),
          );
        },
      ),
    );
  }
}
