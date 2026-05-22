import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpaInfoSection extends StatelessWidget {
  final String title;
  final String distance;
  final String price;
  final String rating;
  final String address;
  final String hours;
  final VoidCallback onGetDirections;
  final VoidCallback onInstagram;
  final VoidCallback onPhone;

  const SpaInfoSection({
    Key? key,
    required this.title,
    required this.distance,
    required this.price,
    required this.rating,
    required this.address,
    required this.hours,
    required this.onGetDirections,
    required this.onInstagram,
    required this.onPhone,
  }) : super(key: key);

  String _extractDistance(String location) {
    // Extract distance pattern like "2.3km" or "4.3km" from location string
    final regex = RegExp(r'(\d+\.?\d*)\s*km', caseSensitive: false);
    final match = regex.firstMatch(location);
    if (match != null) {
      return '${match.group(1)} km away';
    }
    return location; // Fallback to original if no match found
  }

  @override
  Widget build(BuildContext context) {
    final distanceText = _extractDistance(distance);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.textBlack,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 1.h),
        Row(
          children: [
            Flexible(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      distanceText,
                      style: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Container(
                    width: 0.5.w,
                    height: 0.5.w,
                    decoration: BoxDecoration(
                      color: AppColors.textGrey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Flexible(
                    child: Text(
                      'Starts from $price',
                      style: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 2.w),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  rating.split(' ')[0],
                  style: TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 0.3.w),
                Icon(Icons.star, color: AppColors.textBlack, size: 2.h),
                SizedBox(width: 0.3.w),
                Text(
                  '(24)',
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
        SizedBox(height: 1.h),
        Text(
          address,
          style: TextStyle(
            color: AppColors.textGrey,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          hours,
          style: TextStyle(
            color: AppColors.successGreen,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        // Action buttons
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onGetDirections,
                child: Container(
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundWhite,
                    borderRadius: BorderRadius.circular(36),
             
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/AssistantDirectionRounded.svg',
                        width: 25,
                        height: 25,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        'Get Directions',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 2.w),
            GestureDetector(
              onTap: onInstagram,
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/insta.svg',
                  width: 35,
                  height: 35,
                ),
              ),
            ),
            SizedBox(width: 1.5.w),
            GestureDetector(
              onTap: onPhone,
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/call.svg',
                 width: 35,
                  height: 35,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
