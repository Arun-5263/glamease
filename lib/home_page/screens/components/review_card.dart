import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:glamease/constants/app_colors.dart';

class ReviewCard extends StatelessWidget {
  final String reviewerName;
  final double rating;
  final String reviewText;
  final String timeAgo;
  final String? profileImageUrl;
  final bool showDivider;

  const ReviewCard({
    Key? key,
    required this.reviewerName,
    required this.rating,
    required this.reviewText,
    required this.timeAgo,
    this.profileImageUrl,
    this.showDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 5.w,
              backgroundColor: AppColors.grey300,
              backgroundImage: profileImageUrl != null 
                  ? NetworkImage(profileImageUrl!) 
                  : null,
              child: profileImageUrl == null 
                  ? Icon(Icons.person, color: AppColors.grey600, size: 5.w)
                  : null,
            ),
            SizedBox(width: 1.5.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        reviewerName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textBlack,
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(5, (index) {
                          if (index < rating.round()) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: SvgPicture.asset(
                                'assets/icons/star_icon.svg',
                                width: 15,
                                height: 15,
                                colorFilter: const ColorFilter.mode(
                                  Colors.amber,
                                  BlendMode.srcIn,
                                ),
                              ),
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: SvgPicture.asset(
                              'assets/icons/star_icon.svg',
                              width: 15,
                              height: 15,
                              colorFilter: ColorFilter.mode(
                                AppColors.grey300,
                                BlendMode.srcIn,
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    reviewText,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textBlack,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    timeAgo,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (showDivider) ...[
          SizedBox(height: 1.5.h),
          Divider(
            color: AppColors.grey300,
            thickness: 1,
            height: 1,
          ),
        ],
      ],
    );
  }
}
