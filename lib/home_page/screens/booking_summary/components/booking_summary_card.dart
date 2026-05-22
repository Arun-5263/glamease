import 'package:flutter/material.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class BookingSummaryCard extends StatelessWidget {
  final String dateTime;
  final String venueName;
  final String address;
  final String discountText;
  final String coverChargeText;

  const BookingSummaryCard({
    Key? key,
    required this.dateTime,
    required this.venueName,
    required this.address,
    required this.discountText,
    required this.coverChargeText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(12),
      
      ),
      child: Column(
        children: [
          // Date & Time
          _buildInfoRow(
            icon: Icons.calendar_today,
            mainText: dateTime,
          ),
          SizedBox(height: 16),
          // Location
          _buildInfoRow(
            icon: Icons.location_on,
            mainText: venueName,
            subText: address,
          ),
          SizedBox(height: 16),
          // Discount & Cover Charge
          _buildInfoRow(
            icon: Icons.percent,
            mainText: discountText,
            subText: coverChargeText,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String mainText,
    String? subText,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[700], size: 20),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mainText,
                style: TextStyle(
                  fontSize: 12.sp,
                  color:AppColors.textBlack
                  ,fontWeight: FontWeight.w500
                ),
              ),
              if (subText != null) ...[
                SizedBox(height: 2),
                Text(
                  subText,
                  style: TextStyle(
                    fontSize: 10.sp,
                  color:AppColors.textGrey
                  ,fontWeight: FontWeight.w400
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
