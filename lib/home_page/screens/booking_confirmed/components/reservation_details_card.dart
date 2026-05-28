import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class ReservationDetailsCard extends StatelessWidget {
  final String dateTime;
  final String venueName;
  final String address;
  final String city;
  final bool isCancelled;
  final String? customerName;
  final String? stylistName;

  const ReservationDetailsCard({
    super.key,
    required this.dateTime,
    required this.venueName,
    required this.address,
    required this.city,
    this.isCancelled = false,
    this.customerName,
    this.stylistName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (customerName != null && customerName!.trim().isNotEmpty) ...[
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/user.svg',
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                        AppColors.textGrey, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    customerName!.trim(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textBlack,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],

            if (stylistName != null && stylistName!.trim().isNotEmpty) ...[
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/scissor.svg',
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                        AppColors.textGrey, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    stylistName!.trim(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textBlack,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],

            // Date and Time
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/calender.svg',
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                      AppColors.textGrey, BlendMode.srcIn),
                ),
                const SizedBox(width: 12),
                Text(
                  dateTime,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textBlack,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Venue and Address
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/icons/location.png',
                  width: 20,
                  height: 20,
                  color: AppColors.textGrey,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$venueName, $city',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textBlack,
                        ),
                      ),
                      const SizedBox(height: 4),
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

            // Divider and Action buttons (not shown for cancelled)
            if (!isCancelled) ...[
              SizedBox(height: 16),

              // Divider
              Divider(color: AppColors.borderGrey, height: 1),

              SizedBox(height: 16),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Directions button
                  GestureDetector(
                    onTap: () {
                      // Handle directions
                    },
                    child: Row(
                      children: [
                        Center(
                          child: SvgPicture.asset(
                            'assets/icons/getDirections.svg',
                            width: 25,
                            height: 25,
                            fit: BoxFit.contain,
                            color: AppColors.primaryOrange,
                            semanticsLabel: 'Get Directions',
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Directions',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryOrange,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Share button
                  GestureDetector(
                    onTap: () {
                      // Handle share
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/share.svg',
                          width: 25,
                          height: 25,
                          fit: BoxFit.contain,
                          color: AppColors.primaryOrange,
                          semanticsLabel: 'Share',
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Share',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryOrange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
