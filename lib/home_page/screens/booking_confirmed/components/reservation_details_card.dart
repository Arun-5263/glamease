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

  const ReservationDetailsCard({
    Key? key,
    required this.dateTime,
    required this.venueName,
    required this.address,
    required this.city,
    this.isCancelled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(12),
       
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pet Information
            Row(
              children: [
                Icon(Icons.pets, color: AppColors.textGrey, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Max, 5 years',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textBlack,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Golden Retriever',
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
            
            SizedBox(height: 16),
            
            // Date and Time
            Row(
              children: [
                Icon(Icons.calendar_today, color: AppColors.textGrey, size: 20),
                SizedBox(width: 12),
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
            
            SizedBox(height: 16),
            
            // Venue and Address
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on, color: AppColors.textGrey, size: 20),
                SizedBox(width: 12),
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
                      SizedBox(height: 4),
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

