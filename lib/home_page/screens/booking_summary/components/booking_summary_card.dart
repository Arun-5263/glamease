import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glamease/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

class BookingSummaryCard extends StatelessWidget {
  final String dateTime;
  final String venueName;
  final String address;
  final String discountText;
  final String coverChargeText;
  final String? customerName;
  final String? stylistName;

  const BookingSummaryCard({
    super.key,
    required this.dateTime,
    required this.venueName,
    required this.address,
    required this.discountText,
    required this.coverChargeText,
    this.customerName,
    this.stylistName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          if (customerName != null && customerName!.trim().isNotEmpty) ...[
            _buildInfoRow(
              svgAssetPath: 'assets/icons/user.svg',
              mainText: customerName!.trim(),
            ),
            const SizedBox(height: 16),
          ],
          if (stylistName != null && stylistName!.trim().isNotEmpty) ...[
            _buildInfoRow(
              svgAssetPath: 'assets/icons/scissor.svg',
              mainText: stylistName!.trim(),
            ),
            const SizedBox(height: 16),
          ],
          // Date & Time
          _buildInfoRow(
            svgAssetPath: 'assets/icons/calender.svg',
            mainText: dateTime,
          ),
          const SizedBox(height: 16),
          // Location
          _buildInfoRow(
            pngAssetPath: 'assets/icons/location.png',
            mainText: venueName,
            subText: address,
          ),
          const SizedBox(height: 16),
          // Discount & Cover Charge
          _buildInfoRow(
            svgAssetPath: 'assets/icons/percent.svg',
            mainText: discountText,
            subText: coverChargeText,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    IconData? icon,
    String? svgAssetPath,
    String? pngAssetPath,
    required String mainText,
    String? subText,
  }) {
    return Row(
      children: [
        if (pngAssetPath != null)
          Image.asset(
            pngAssetPath,
            width: 20,
            height: 20,
            color: Colors.grey[700],
          )
        else if (svgAssetPath != null)
          SvgPicture.asset(
            svgAssetPath,
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(Colors.grey[700]!, BlendMode.srcIn),
          )
        else if (icon != null)
          Icon(icon, color: Colors.grey[700], size: 20)
        else
          const SizedBox(width: 20, height: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mainText,
                style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.w500),
              ),
              if (subText != null) ...[
                const SizedBox(height: 2),
                Text(
                  subText,
                  style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
