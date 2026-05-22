import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class ReservationHeader extends StatelessWidget {
  final VoidCallback onBackPressed;
  final String venueName;
  final String distance;

  const ReservationHeader({
    Key? key,
    required this.onBackPressed,
    required this.venueName,
    required this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color:AppColors.backgroundWhite,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Navigation bar
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: onBackPressed,
                  child: Icon(Icons.arrow_back, color: Colors.black, size: 24),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reserve',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                   
                      // Venue information
                      Row(
                        children: [
                          Text(
                            venueName,
                            style: TextStyle(
                              fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                              color: AppColors.textGrey,
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.textGrey,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            distance,
                            style: TextStyle(
                              fontSize: 14,
                                fontWeight: FontWeight.w600,
                              color: AppColors.textGrey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      ),
    );
  }
}
