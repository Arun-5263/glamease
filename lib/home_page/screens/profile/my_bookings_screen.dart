import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import '../booking_confirmed/booking_confirmed_screen.dart';
import '../transaction_successful/transaction_successful_screen.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({Key? key}) : super(key: key);

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundWhite,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        body: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),
              // Tabs (below headers)
              SizedBox(
                height: 2.h,
              ),
              _buildTabs(),
              // Content
              Expanded(
                child: _selectedTabIndex == 0
                    ? _buildUpcomingBookings()
                    : _buildPastBookings(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      color: AppColors.backgroundGrey,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryBlack),
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
          Expanded(
            child: Center(
              child: Text(
                'My Bookings',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimaryBlack,
                ),
              ),
            ),
          ),
          SizedBox(width: 40), // Balance space for back button
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15,),
      child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFE7E7E7),
          borderRadius: BorderRadius.circular(12),
         
        ),
       
        child: Row(
          children: [
            Expanded(
              child: _buildTab(0, 'Upcoming'),
            ),
            Expanded(
              child: _buildTab(1, 'Past Bookings'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(int index, String label) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal:5,vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.backgroundWhite : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.shadowVeryLight,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimaryBlack,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingBookings() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildUpcomingBookingCard(
          hasTransactionPending: true,
          businessName: 'Peek a Bow - The pet club',
          location: 'Lingampally, BHEL road, Hyd',
          date: '22 Oct, 11:00 PM',
          hasDiscount: false,
        ),
        SizedBox(height: 16),
        _buildUpcomingBookingCard(
          hasTransactionPending: false,
          businessName: 'Peek a Bow - The pet club, Hyderabad.',
          location: 'Lingampally, BHEL road',
          date: '20 Oct, 12:00 PM',
          hasDiscount: true,
          discountText: 'Flat 25% Off on Total Bill',
        ),
      ],
    );
  }

  Widget _buildUpcomingBookingCard({
    required bool hasTransactionPending,
    required String businessName,
    required String location,
    required String date,
    required bool hasDiscount,
    String? discountText,
  }) {
    return GestureDetector(
      onTap: () {
        if (hasTransactionPending) {
          // Navigate to Transaction Successful screen with pending status
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionSuccessfulScreen(
                transactionDate: date,
                isPending: true,
              ),
            ),
          );
        } else {
          // Extract city from location (last part after comma)
          final locationParts = location.split(',');
          final city = locationParts.length > 1 
              ? locationParts.last.trim() 
              : 'Hyderabad';
          
          // Generate UPI transaction number or use default
          final upiTransactionNo = '506691771533';
          
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingConfirmedScreen(
                venueName: businessName,
                city: city,
                dateTime: date,
                address: location,
                coverChargeAmount: '₹ 50.00',
                upiTransactionNo: upiTransactionNo,
                showHomeButton: false,
              ),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowVeryLight,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Transaction Pending Banner
          if (hasTransactionPending)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.transactionPendingBanner,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Text(
                  'Transaction Pending',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.transactionPendingText,
                  ),
                ),
              ),
            ),
          // Card Content
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/spa_center.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 80,
                        color: AppColors.backgroundGrey,
                        child: Icon(
                          Icons.image,
                          color: AppColors.textGrey,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 16),
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        businessName,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
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
                      SizedBox(height: 4),
                       Text(
                            date,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textBlack,
                            ),
                          ),
                    
                      if (hasDiscount && discountText != null) ...[
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.percent,
                              size: 14,
                              color: AppColors.savedText,
                            ),
                            SizedBox(width: 4),
                            Text(
                              discountText,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.savedText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                // Arrow Icon
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.textGrey,
                ),
              ],
            ),
          ),
          // Divider
          Container(
            height: 1,
            color: AppColors.borderGrey,
            margin: EdgeInsets.symmetric(horizontal: 16),
          ),
          // Action Buttons
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 10,
              top: 5,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    iconPath: 'assets/icons/getDirections.svg',
                    label: 'Get Directions',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildActionButton(
                    iconPath: 'assets/icons/share.svg',
                    label: 'Share',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildActionButton({required String iconPath, required String label}) {
    return TextButton(
      onPressed: () {
        // Handle action
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            width:20,
            height: 20,
            colorFilter: ColorFilter.mode(
              AppColors.primaryOrange,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryOrange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPastBookings() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildPastBookingCard(
          hasSavedBanner: true,
          savedAmount: '₹525',
          businessName: 'Peek a Bow - The pet club',
          location: 'Lingampally, BHEL road, Hyd',
          date: '19 Oct, 11:00 PM',
          status: BookingStatus.billPaid,
          amount: '₹1200.00',
        ),
        SizedBox(height: 16),
        _buildPastBookingCard(
          hasSavedBanner: false,
          businessName: 'Peek a Bow - The pet club',
          location: 'Lingampally, BHEL road, Hyd',
          date: '18 Oct, 11:00 PM',
          status: BookingStatus.transactionFailed,
        ),
        SizedBox(height: 16),
        _buildPastBookingCard(
          hasSavedBanner: false,
          businessName: 'Peek a Bow - The pet club',
          location: 'Lingampally, BHEL road, Hyd',
          date: '16 Oct, 11:00 PM',
          status: BookingStatus.bookingCancelled,
        ),
      ],
    );
  }

  Widget _buildPastBookingCard({
    required bool hasSavedBanner,
    String? savedAmount,
    required String businessName,
    required String location,
    required String date,
    required BookingStatus status,
    String? amount,
  }) {
    return GestureDetector(
      onTap: () {
        if (status == BookingStatus.transactionFailed) {
          // Navigate to Transaction Successful screen with failed status
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionSuccessfulScreen(
                transactionDate: date,
                isFailed: true,
              ),
            ),
          );
        } else if (status == BookingStatus.bookingCancelled) {
          // Navigate to Booking Cancelled screen using BookingConfirmedScreen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingConfirmedScreen(
                venueName: businessName,
                city: location.split(',').first,
                dateTime: date,
                address: location,
                coverChargeAmount: '₹ 50.00',
                upiTransactionNo: '506691771533',
                showHomeButton: true,
                isCancelled: true,
              ),
            ),
          );
        } else {
          // Navigate to Transaction Successful screen for bill paid
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionSuccessfulScreen(
                transactionDate: date,
              ),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowVeryLight,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Saved Banner
          if (hasSavedBanner && savedAmount != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.savedBanner,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Text(
                  'You Saved $savedAmount on this bill.',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.savedText,
                  ),
                ),
              ),
            ),
          // Card Content
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/spa_center.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 80,
                        color: AppColors.backgroundGrey,
                        child: Icon(
                          Icons.image,
                          color: AppColors.textGrey,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 16),
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        businessName,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
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
                      SizedBox(height: 4),
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ],
                  ),
                ),
                // Arrow Icon
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.textGrey,
                ),
              ],
            ),
            ),
            // Divider
            Container(
              height: 1,
              color: AppColors.borderGrey,
              margin: EdgeInsets.symmetric(horizontal: 16),
            ),
            // Status Footer
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                mainAxisAlignment: (status == BookingStatus.transactionFailed || 
                                   status == BookingStatus.bookingCancelled)
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _getStatusText(status),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(status),
                    ),
                  ),
                  if (amount != null && 
                      status != BookingStatus.transactionFailed && 
                      status != BookingStatus.bookingCancelled)
                    Text(
                      amount,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimaryBlack,
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
      ),
    );
  }

  String _getStatusText(BookingStatus status) {
    switch (status) {
      case BookingStatus.billPaid:
        return 'Bill Paid';
      case BookingStatus.transactionFailed:
        return 'Transaction Failed';
      case BookingStatus.bookingCancelled:
        return 'Booking Cancelled';
    }
  }

  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.billPaid:
        return AppColors.textPrimaryBlack;
      case BookingStatus.transactionFailed:
      case BookingStatus.bookingCancelled:
        return AppColors.bookingCancelledText;
    }
  }
}

enum BookingStatus {
  billPaid,
  transactionFailed,
  bookingCancelled,
}

