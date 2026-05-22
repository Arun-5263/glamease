import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';
import 'components/booking_confirmed_header.dart';
import 'components/reservation_details_card.dart';
import 'components/offers_section.dart';
import 'components/transaction_details_card.dart';
import 'components/booking_experience_section.dart';
import 'components/cancel_booking_section.dart';
import 'components/booking_history_section.dart';

class BookingConfirmedScreen extends StatelessWidget {
  final String venueName;
  final String city;
  final String dateTime;
  final String address;
  final String coverChargeAmount;
  final String upiTransactionNo;
  final bool showHomeButton;
  final bool isCancelled;

  const BookingConfirmedScreen({
    Key? key,
    required this.venueName,
    required this.city,
    required this.dateTime,
    required this.address,
    required this.coverChargeAmount,
    required this.upiTransactionNo,
    this.showHomeButton = true,
    this.isCancelled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with green background
                  BookingConfirmedHeader(
                    venueName: venueName,
                    city: city,
                    isCancelled: isCancelled,
                  ),

                  SizedBox(height: 24),

                  // Reservation Details
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Reservation Details',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlack,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  ReservationDetailsCard(
                    dateTime: dateTime,
                    venueName: venueName,
                    address: address,
                    city: city,
                    isCancelled: isCancelled,
                  ),

                  SizedBox(height: 24),

                  // For cancelled: Transaction Details comes first, then Offers
                  // For confirmed: Offers comes first, then Transaction Details
                  if (isCancelled) ...[
                    // Transaction Details
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Transaction Details',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    TransactionDetailsCard(
                      coverChargeAmount: coverChargeAmount,
                      upiTransactionNo: upiTransactionNo,
                      isCancelled: isCancelled,
                    ),

                    SizedBox(height: 24),

                    // Offers For You
                    OffersSection(),

                    SizedBox(height: 24),

                    // Booking History
                    BookingHistorySection(),
                  ] else ...[
                    // Offers For You
                    OffersSection(),  

                    SizedBox(height: 24),

                    // Booking History
                    // BookingHistorySection(),

                    SizedBox(height: 24),

                    // Transaction Details
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Transaction Details',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    TransactionDetailsCard(
                      coverChargeAmount: coverChargeAmount,
                      upiTransactionNo: upiTransactionNo,
                      isCancelled: isCancelled,
                    ),
                  ],

                  SizedBox(height: 24),

                  // Booking Experience Section (not shown for cancelled)
                  if (!isCancelled) ...[
                    BookingExperienceSection(),
                    SizedBox(height: 24),
                  ],

                  // Cancel Booking Section (not shown for cancelled)
                  if (!isCancelled) ...[
                    CancelBookingSection(
                      venueName: venueName,
                      city: city,
                      dateTime: dateTime,
                      address: address,
                      coverChargeAmount: coverChargeAmount,
                      upiTransactionNo: upiTransactionNo,
                    ),
                    SizedBox(height: 24),
                  ],

                  SizedBox(height: showHomeButton ? 24 : 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: showHomeButton
          ? SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to home - pop all screens
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Home',
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
