import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class BookingConfirmedHeader extends StatelessWidget {
  final String venueName;
  final String city;
  final bool isCancelled;

  const BookingConfirmedHeader({
    Key? key,
    required this.venueName,
    required this.city,
    this.isCancelled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCancelled ? Color(0xFFFFEDEF) : AppColors.successGreen,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(left: 16,right: 16,bottom: 15),
          child: Column(
            children: [
              // Back button
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: isCancelled ? AppColors.textBlack : AppColors.textWhite, size: 20),
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ],
              ),
              // SizedBox(height: 8),
              
              // Success icon with blur (only for confirmed, not cancelled)
              if (!isCancelled)
                ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Center(
                      child: Image.asset(
                        'assets/icons/Success_icon.png',
                        width: 20.w,
                        height: 20.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              
              // Failed icon for cancelled bookings
              if (isCancelled)
                SvgPicture.asset(
                  'assets/icons/failed_icon.svg',
                  width: 20.w,
                  height: 20.w,
                  fit: BoxFit.contain,
                ),
              
              if (!isCancelled) SizedBox(height: 12),
              if (isCancelled) SizedBox(height: 12),
              
              // Booking Confirmed/Cancelled text
              Text(
                isCancelled ? 'Booking Cancelled' : 'Booking Confirmed',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: isCancelled ? Color(0xFFFF2C2C) : AppColors.textWhite,
                ),
              ),
              
              SizedBox(height: 6),
              
              // Venue name
              Text(
                venueName,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isCancelled ? AppColors.textBlack : AppColors.textWhite,
                ),
              ),
              
              SizedBox(height: 2),
              
              // Location
              Text(
                city,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: isCancelled ? AppColors.textBlack : AppColors.textWhite,
                ),
              ),
              
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

