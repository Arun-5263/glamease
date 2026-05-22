import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../constants/app_colors.dart';
import 'filter_bottom_sheet.dart';

class ExploreSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Explore Pet Spa Centers Near You",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFilterButton(
                context,
                'Filters',
                Icons.filter_list,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => FilterBottomSheet(),
                  );
                },
              ),
              SizedBox(width: 8),
              _buildFilterButton(context, 'Near & Top Rated', null),
              SizedBox(width: 8),
              _buildFilterButton(context, 'Offers', null),
              SizedBox(width: 8),
              _buildFilterButton(context, '20% Off', null),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterButton(
    BuildContext context,
    String text,
    IconData? icon, {
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          // BoxShadow(
          //   color: AppColors.shadowVeryLight,
          //   blurRadius: 24,
          //   offset: Offset(0, 0),
          // ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Card(
        color: AppColors.backgroundWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  if (text == 'Filters')
                    Image.asset(
                      'assets/icons/filter.png',
                      width: 16,
                      height: 16,
                    )
                  else
                    Icon(icon, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 4),
                ],
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textPrimaryBlack,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
