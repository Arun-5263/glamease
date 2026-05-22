import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:glamease/constants/app_colors.dart';
import 'review_card.dart';

class ReviewsSection extends StatelessWidget {
  final List<Map<String, dynamic>> reviews;
  final String sortBy;
  final VoidCallback onSortChanged;
  final VoidCallback onViewAll;

  const ReviewsSection({
    Key? key,
    required this.reviews,
    required this.sortBy,
    required this.onSortChanged,
    required this.onViewAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Reviews',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlack,
              ),
            ),
            GestureDetector(
              onTap: onSortChanged,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: AppColors.backgroundGrey,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.grey300),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      sortBy,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textBlack,
                      ),
                    ),
                    SizedBox(width: 0.4.w),
                    Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: AppColors.textBlack,
                      size: 3.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        ...reviews.asMap().entries.map((entry) {
          final index = entry.key;
          final review = entry.value;
          final isLast = index == reviews.length - 1;
          return Padding(
            padding: EdgeInsets.only(bottom: 1.5.h),
            child: ReviewCard(
              reviewerName: review['name'],
              rating: review['rating'],
              reviewText: review['text'],
              timeAgo: review['timeAgo'],
              profileImageUrl: review['profileImageUrl'],
              showDivider: !isLast,
            ),
          );
        }).toList(),
        SizedBox(height: 1.h),
        Center(
          child: GestureDetector(
            onTap: onViewAll,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: AppColors.backgroundGrey,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.grey300),
              ),
              child: Text(
                'View all',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlack,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

