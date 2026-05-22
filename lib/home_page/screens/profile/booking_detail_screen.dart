import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

enum BookingDetailStatus {
  transactionPending,
  transactionFailed,
  bookingCancelled,
}

class BookingDetailScreen extends StatelessWidget {
  final BookingDetailStatus status;
  final String businessName;
  final String location;
  final String address;
  final String dateTime;
  final String amount;
  final String? upiTransactionNo;
  final String? coverCharge;
  final String? totalBill;
  final String? discount;
  final String? couponOffer;

  const BookingDetailScreen({
    Key? key,
    required this.status,
    required this.businessName,
    required this.location,
    required this.address,
    required this.dateTime,
    required this.amount,
    this.upiTransactionNo,
    this.coverCharge,
    this.totalBill,
    this.discount,
    this.couponOffer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: _getHeaderColor(),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        body: SafeArea(
          child: Column(
            children: [
              // Header Section
              _buildHeader(context),
              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  child: _buildContent(context),
                ),
              ),
              // Bottom Button
              _buildBottomButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Color _getHeaderColor() {
    switch (status) {
      case BookingDetailStatus.transactionPending:
        return AppColors.transactionPendingBanner;
      case BookingDetailStatus.transactionFailed:
      case BookingDetailStatus.bookingCancelled:
        return Color(0xFFFFE5E5); // Light pink
    }
  }

  Widget _buildHeader(BuildContext context) {
    String title;
    String? subtitle;
    Color titleColor;

    switch (status) {
      case BookingDetailStatus.transactionPending:
        title = 'Transaction Pending !';
        subtitle = dateTime;
        titleColor = AppColors.textPrimaryBlack;
        break;
      case BookingDetailStatus.transactionFailed:
        title = 'Transaction Failed';
        subtitle = dateTime;
        titleColor = AppColors.bookingCancelledText;
        break;
      case BookingDetailStatus.bookingCancelled:
        title = 'Booking Cancelled';
        subtitle = null;
        titleColor = AppColors.bookingCancelledText;
        break;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: _getHeaderColor(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryBlack),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
              if (subtitle != null) ...[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: titleColor,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: titleColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ] else
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: titleColor,
                    ),
                  ),
                ),
            ],
          ),
          if (status == BookingDetailStatus.bookingCancelled) ...[
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE5E5),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.bookingCancelledText,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    businessName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryBlack,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: status == BookingDetailStatus.bookingCancelled ? 0 : 20),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24),
          // Status Icon and Message
          if (status != BookingDetailStatus.bookingCancelled)
            _buildStatusIconAndMessage(),
          
          // Amount
          if (status != BookingDetailStatus.bookingCancelled)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                amount,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimaryBlack,
                ),
              ),
            ),
          
          SizedBox(height: 16),
          
          // Location
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  size: 20,
                  color: AppColors.textGrey,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$businessName, $location',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimaryBlack,
                        ),
                      ),
                      Text(
                        address,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 24),
          
          // Divider with wave or line
          if (status == BookingDetailStatus.transactionPending ||
              status == BookingDetailStatus.transactionFailed)
            Container(
              height: 1,
              margin: EdgeInsets.symmetric(horizontal: 16),
              color: AppColors.borderGrey,
            ),
          
          SizedBox(height: 24),
          
          // Payment Summary (for pending and failed)
          if (status == BookingDetailStatus.transactionPending)
            _buildPaymentSummary(),
          
          // Reservation Details (for cancelled)
          if (status == BookingDetailStatus.bookingCancelled)
            _buildReservationDetails(),
          
          // Transaction Details (for cancelled)
          if (status == BookingDetailStatus.bookingCancelled)
            _buildTransactionDetails(),
          
          // Offers Section
          _buildOffersSection(),
          
          // Booking History (for cancelled)
          if (status == BookingDetailStatus.bookingCancelled)
            _buildBookingHistory(),
          
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStatusIconAndMessage() {
    Widget icon;
    String message;
    String? subtitle;

    switch (status) {
      case BookingDetailStatus.transactionPending:
        icon = Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.transactionPendingBanner,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.primaryOrange,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.hourglass_empty,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        );
        message = 'Your payment is still processing';
        subtitle = 'This usually takes a few minutes. We\'ll update you as soon as we get a confirmation from your bank.';
        break;
      case BookingDetailStatus.transactionFailed:
        icon = Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.bookingCancelledText,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: 40,
          ),
        );
        message = 'Oops!';
        subtitle = 'Your payment couldn\'t be completed';
        break;
      default:
        icon = SizedBox();
        message = '';
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          icon,
          SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimaryBlack,
            ),
          ),
          if (subtitle != null) ...[
            SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textGrey,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentSummary() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment summary',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryBlack,
            ),
          ),
          SizedBox(height: 16),
          _buildSummaryRow('Total bill', totalBill ?? '₹1500.00', false),
          SizedBox(height: 8),
          _buildSummaryRow('Cover Charge', '- ${coverCharge ?? '50.00'}', false),
          SizedBox(height: 8),
          if (discount != null)
            _buildSummaryRow('Discount (25% OFF)', '- ${discount ?? '375.00'}', false),
          SizedBox(height: 8),
          if (couponOffer != null)
            _buildSummaryRow('Coupon/Offer', '- ${couponOffer ?? '150.00'}', false),
          SizedBox(height: 16),
          Container(
            height: 1,
            color: AppColors.borderGrey,
          ),
          SizedBox(height: 8),
          _buildSummaryRow('Pending', amount, true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, bool isPending) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textPrimaryBlack,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isPending
                ? AppColors.transactionPendingText
                : AppColors.textPrimaryBlack,
          ),
        ),
      ],
    );
  }

  Widget _buildReservationDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reservation Details',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryBlack,
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderGrey),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 20, color: AppColors.textGrey),
                    SizedBox(width: 8),
                    Text(
                      dateTime,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimaryBlack,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, size: 20, color: AppColors.textGrey),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$businessName, $location',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textPrimaryBlack,
                            ),
                          ),
                          Text(
                            address,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildTransactionDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction Details',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryBlack,
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderGrey),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cover Charge',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textPrimaryBlack,
                          ),
                        ),
                        Text(
                          'Refund Not applicable',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.bookingCancelledText,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      coverCharge ?? '₹ 50.00',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryBlack,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(height: 1, color: AppColors.borderGrey),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Method',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textPrimaryBlack,
                          ),
                        ),
                        Text(
                          'UPI Transaction No',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textGrey,
                          ),
                        ),
                        Text(
                          upiTransactionNo ?? '506691771533',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textGrey,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '₹50',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryBlack,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildOffersSection() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 1,
                width: 100,
                color: AppColors.borderGrey,
              ),
              Icon(Icons.arrow_forward, size: 16, color: AppColors.textGrey),
              Expanded(
                child: Text(
                  'Offers For You',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimaryBlack,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          height: 150,
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.transactionPendingBanner,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              'Offers Carousel',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textGrey,
              ),
            ),
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildBookingHistory() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Booking history',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryBlack,
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderGrey),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.check_circle, size: 20, color: AppColors.referralJoinedStatus),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Booking Successful',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textPrimaryBlack,
                          ),
                        ),
                        Text(
                          '19 Oct, 05:00PM',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.cancel, size: 20, color: AppColors.bookingCancelledText),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Booking Cancelled',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textPrimaryBlack,
                          ),
                        ),
                        Text(
                          '19 Oct, 08:00PM',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    String buttonText;
    VoidCallback? onPressed;

    switch (status) {
      case BookingDetailStatus.transactionPending:
      case BookingDetailStatus.transactionFailed:
        return Container(
          padding: EdgeInsets.all(16),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderGrey),
            ),
            child: Row(
              children: [
                Icon(Icons.chat_bubble_outline, size: 20, color: AppColors.textPrimaryBlack),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Need Help? Contact Us',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textPrimaryBlack,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textGrey),
              ],
            ),
          ),
        );
      case BookingDetailStatus.bookingCancelled:
        buttonText = 'Home';
        onPressed = () => Navigator.popUntil(context, (route) => route.isFirst);
        break;
    }

    if (status == BookingDetailStatus.bookingCancelled) {
      return Container(
        padding: EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textWhite,
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox();
  }
}

