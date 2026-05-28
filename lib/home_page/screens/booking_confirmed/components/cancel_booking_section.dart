import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';
import '../booking_confirmed_screen.dart';

class CancelBookingSection extends StatelessWidget {
  final String venueName;
  final String city;
  final String dateTime;
  final String address;
  final String coverChargeAmount;
  final String upiTransactionNo;
  final String? customerName;
  final String? stylistName;

  const CancelBookingSection({
    Key? key,
    required this.venueName,
    required this.city,
    required this.dateTime,
    required this.address,
    required this.coverChargeAmount,
    required this.upiTransactionNo,
    this.customerName,
    this.stylistName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 1,
          color: AppColors.borderGrey,
          margin: EdgeInsets.symmetric(horizontal: 16),
        ),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Oops! Can't come?",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBlack,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showCancelBookingDialog(context);
                },
                child: Text(
                  'Cancel Booking',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textRed,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showCancelBookingDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bottomSheetContext) {
        final TextEditingController reasonController = TextEditingController();

        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag handle

                  // Title
                  Text(
                    'Cancel Booking?',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textBlack,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  // Warning message
                  Column(
                    children: [
                      Text(
                        'Are you sure you want to cancel this reservation?',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textGrey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'This action cannot be undone,',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textGrey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'and the amount will not be refunded.',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textGrey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  // Text input field
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhite,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.borderGrey),
                    ),
                    child: TextField(
                      controller: reasonController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Add Reason for Cancellation',
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textGrey,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textBlack,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  // Action buttons
                  Row(
                    children: [
                      // Yes, Cancel button
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // Handle cancel booking
                            reasonController.dispose();
                            Navigator.pop(context); // Close bottom sheet
                            // Navigate to cancelled booking screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingConfirmedScreen(
                                  venueName: venueName,
                                  city: city,
                                  dateTime: dateTime,
                                  address: address,
                                  coverChargeAmount: coverChargeAmount,
                                  upiTransactionNo: upiTransactionNo,
                                  showHomeButton: true,
                                  isCancelled: true,
                                  customerName: customerName,
                                  stylistName: stylistName,
                                ),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: AppColors.textRed, width: 1.5),
                            backgroundColor: AppColors.backgroundWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text(
                            'Yes, Cancel',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textRed,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      // Go Back button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            reasonController.dispose();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.backgroundGrey,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text(
                            'Go Back',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textBlack,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
